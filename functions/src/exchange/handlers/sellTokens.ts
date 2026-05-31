// Vinícius Panutti Salgado - 25007329

 * Explicação: com gravação do histórico de preços
 *
 * ── sellTokens (Cloud Function — HTTPS Callable) ─────────────────────
 * Handler responsável pela VENDA de tokens de uma startup pelo investidor.
 *
 * Modelo Econômico (AMM inverso):
 *   Na venda, tokens são DEVOLVIDOS ao pool e capital é RETIRADO.
 *   novoPreço = capitalArrecadado / tokensDisponiveis
 *   Mais tokens no pool → preço CAI (oferta aumenta).
 *
 * Diferença crucial vs buyTokens:
 *   Na venda, o valorPago do investidor é reduzido PROPORCIONALMENTE
 *   à fração de tokens vendidos (não pelo valor de mercado).
 *   Isto permite calcular lucro/prejuízo real do investidor.
 *   Fórmula: reduçãoValorPago = valorPagoTotal × (qtdVendida / qtdTotal)
 *
 * Documentos afetados:
 *   1. users/{uid}/carteira/saldo      → credita saldo R$ do investidor
 *   2. users/{uid}/investimentos/{id}   → decrementa tokens e valor pago
 *   3. exchange/{startupId}             → atualiza pool
 *   4. exchange/{id}/historicoPrecos    → registra preço do dia
 *   5. startups/{id}/Histórico          → audit trail
 */
// SDK do Firebase Functions v2
import * as functions from "firebase-functions";
// SDK Admin — acesso privilegiado ao Firestore
import * as admin from "firebase-admin";

// Exporta como HTTPS Callable
export const sellTokens = functions.https.onCall(async (request) => {
  // Valida autenticação
  if (!request.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Log in necessário.");
  }

  const userId = request.auth.uid;
  const { startupId, quantidade } = request.data;

  // Validação de parâmetros de entrada
  if (!startupId || typeof quantidade !== "number" || quantidade <= 0) {
    throw new functions.https.HttpsError("invalid-argument", "Parâmetros inválidos.");
  }

  const db = admin.firestore();

  try {
    // ── TRANSAÇÃO ATÔMICA ────────────────────────────────────────────
    await db.runTransaction(async (t) => {
      // Referências aos documentos envolvidos
      const carteiraRef = db.collection("users").doc(userId).collection("carteira").doc("saldo");
      const investimentoRef = db.collection("users").doc(userId).collection("investimentos").doc(startupId);
      const exchangeRef = db.collection("exchange").doc(startupId);

      // Leitura paralela dos 3 documentos
      const [carteiraSnap, investimentoSnap, exchangeSnap] = await Promise.all([
        t.get(carteiraRef),
        t.get(investimentoRef),
        t.get(exchangeRef)
      ]);

      // Pool de liquidez deve existir
      if (!exchangeSnap.exists) {
        throw new functions.https.HttpsError("failed-precondition", "Exchange não encontrada para esta startup.");
      }

      // Verifica se o investidor possui tokens suficientes para vender
      const invData = investimentoSnap.exists ? investimentoSnap.data() : {};
      const tokensPossuidos = invData?.tokensComprados || 0;
      if (tokensPossuidos < quantidade) {
        throw new functions.https.HttpsError("failed-precondition", "Tokens insuficientes para venda.");
      }

      // Dados atuais do pool de liquidez
      const exchangeData = exchangeSnap.data()!;
      const precoAtual = exchangeData.precoAtual || 0;
      const tokensDisponiveis = exchangeData.tokensDisponiveis || 0;
      const capitalArrecadado = exchangeData.capitalArrecadado || 0;

      // valorVenda = preço atual × quantidade vendida
      const valorVenda = Number((precoAtual * quantidade).toFixed(2));

      // Valida que o pool tem capital suficiente para pagar o investidor
      if (capitalArrecadado < valorVenda) {
        throw new functions.https.HttpsError("failed-precondition", "Liquidez insuficiente no pool.");
      }

      // Saldo atual da carteira do investidor
      const saldoData = carteiraSnap.exists ? carteiraSnap.data() : { saldo: 0 };
      const saldo = saldoData?.saldo || 0;

      // ── Cálculos pós-venda ─────────────────────────────────────────
      // Credita o valor da venda na carteira do investidor
      const novoSaldo = Number((saldo + valorVenda).toFixed(2));
      // Retira capital do pool (o investidor recebe R$ de volta)
      const novoCapitalArrecadado = Number((capitalArrecadado - valorVenda).toFixed(2));
      // Devolve tokens ao pool (aumenta a oferta disponível)
      const novosTokensDisponiveis = tokensDisponiveis + quantidade;

      // AMM inverso: mais tokens no pool → preço cai
      const novoPreco = novosTokensDisponiveis > 0
        ? Number((novoCapitalArrecadado / novosTokensDisponiveis).toFixed(4))
        : precoAtual;

      // Variação percentual do preço
      const variacao = ((novoPreco - precoAtual) / precoAtual) * 100;

      // ── ESCRITAS ATÔMICAS ──────────────────────────────────────────

      // 1. Credita saldo na carteira do investidor
      t.set(carteiraRef, { saldo: novoSaldo }, { merge: true });

      // 2. Atualiza registro de investimento com redução proporcional
      const valorPagoAtual = invData?.valorPago || 0;
      // Proporção vendida em relação ao total de tokens possuídos
      const proporcao = quantidade / tokensPossuidos;
      // Reduz o valorPago proporcionalmente (para cálculo correto de P&L)
      const reducaoValorPago = valorPagoAtual * proporcao;

      t.set(investimentoRef, {
        tokensComprados: tokensPossuidos - quantidade,
        valorPago: Number((valorPagoAtual - reducaoValorPago).toFixed(2))
      }, { merge: true });

      // 3. Atualiza pool de liquidez
      t.update(exchangeRef, {
        tokensDisponiveis: novosTokensDisponiveis,
        capitalArrecadado: novoCapitalArrecadado,
        precoAtual: novoPreco,
        variacao: variacao
      });

      // 4. Registra preço do dia no histórico para gráficos
      const dataAtualObj = new Date();
      const yyyy = dataAtualObj.getFullYear();
      const mm = String(dataAtualObj.getMonth() + 1).padStart(2, '0');
      const dd = String(dataAtualObj.getDate()).padStart(2, '0');
      const dataAtualId = `${yyyy}-${mm}-${dd}`;

      t.set(exchangeRef.collection("historicoPrecos").doc(dataAtualId), {
        data: admin.firestore.Timestamp.now(),
        preco: novoPreco
      }, { merge: true });

      // 5. Audit trail — registra venda no histórico da startup
      const startupRef = db.collection("startups").doc(startupId);
      const historicoRef = startupRef.collection("Histórico").doc();
      t.set(historicoRef, {
        "Preco Vendido": valorVenda,
        "Tokens Vendidos": quantidade,
        "Valor Token": precoAtual,
        data: admin.firestore.Timestamp.now(),
        status: "Sucesso",
        tipo: "Venda",
        uid: request.auth?.uid,
      });
    });

    return { status: "success" };
  } catch (error: any) {
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError("failed-precondition", error.message);
  }
});
