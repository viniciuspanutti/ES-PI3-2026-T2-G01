/* Vinícius Panutti Salgado - 25007329

 * Explicação do código -> Refatorado para usar AMM e transações atômicas unificadas no Firebase.
 *
 * ── buyTokens (Cloud Function — HTTPS Callable) ──────────────────────
 * Handler responsável pela COMPRA de tokens de uma startup pelo investidor.
 *
 * Modelo Econômico (AMM — Automated Market Maker):
 *   O preço do token é recalculado dinamicamente após cada operação:
 *   novoPreço = capitalArrecadado / tokensDisponiveis
 *   Quanto menos tokens no pool, mais caro cada token se torna.
 *
 * Atomicidade:
 *   TODA a operação ocorre dentro de db.runTransaction(). Se qualquer
 *   etapa falhar, o Firestore faz rollback automático de TODAS as escritas.
 *
 * Documentos afetados:
 *   1. users/{uid}/carteira/saldo      → debita saldo R$ do investidor
 *   2. users/{uid}/investimentos/{id}   → incrementa tokens comprados
 *   3. exchange/{startupId}             → atualiza pool (tokens, capital, preço)
 *   4. exchange/{id}/historicoPrecos    → registra preço do dia para gráficos
 *   5. startups/{id}/Histórico          → audit trail da transação
 */

// SDK do Firebase Functions v2 — para onCall e HttpsError
import * as functions from "firebase-functions";
// SDK Admin do Firebase — acesso privilegiado ao Firestore server-side
import * as admin from "firebase-admin";

// Exporta como HTTPS Callable — recebe auth context + data do Flutter
export const buyTokens = functions.https.onCall(async (request) => {
  // Validação de autenticação: apenas utilizadores logados podem comprar
  if (!request.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Log in necessário.");
  }

  // UID do utilizador autenticado (identificador único Firebase Auth)
  const userId = request.auth.uid;
  // startupId: ID do pool na coleção 'exchange'
  // quantidade: número de tokens a comprar (inteiro positivo)
  const { startupId, quantidade } = request.data;

  // Validação de parâmetros: rejeita dados malformados ou negativos
  if (!startupId || typeof quantidade !== "number" || quantidade <= 0) {
    throw new functions.https.HttpsError("invalid-argument", "Parâmetros inválidos.");
  }

  const db = admin.firestore();

  try {
    // ── TRANSAÇÃO ATÔMICA do Firestore ───────────────────────────────
    // Todas as leituras/escritas são executadas atomicamente.
    // Em caso de conflito de concorrência, o Firestore re-executa até 5x.
    await db.runTransaction(async (t) => {
      // Referências aos 3 documentos principais da operação
      const carteiraRef = db.collection("users").doc(userId).collection("carteira").doc("saldo");
      const investimentoRef = db.collection("users").doc(userId).collection("investimentos").doc(startupId);
      const exchangeRef = db.collection("exchange").doc(startupId);

      // Leitura paralela (Promise.all) — otimiza latência de rede
      const [carteiraSnap, investimentoSnap, exchangeSnap] = await Promise.all([
        t.get(carteiraRef),
        t.get(investimentoRef),
        t.get(exchangeRef)
      ]);

      // O pool de liquidez DEVE existir (criado pelo seedStartupCatalog)
      if (!exchangeSnap.exists) {
        throw new functions.https.HttpsError("failed-precondition", "Exchange não encontrada para esta startup.");
      }

      // Extrai dados atuais do pool de liquidez
      const exchangeData = exchangeSnap.data()!;
      const precoAtual = exchangeData.precoAtual || 0;           // Preço unitário R$
      const tokensDisponiveis = exchangeData.tokensDisponiveis || 0; // Tokens no pool
      const capitalArrecadado = exchangeData.capitalArrecadado || 0; // Capital total R$

      // custoTotal = preço × quantidade (toFixed evita floating point errors)
      const custoTotal = Number((precoAtual * quantidade).toFixed(2));

      // Saldo atual da carteira (se não existe, assume 0)
      const saldoData = carteiraSnap.exists ? carteiraSnap.data() : { saldo: 0 };
      const saldo = saldoData?.saldo || 0;

      // Valida saldo suficiente
      if (saldo < custoTotal) {
        throw new functions.https.HttpsError("failed-precondition", "Saldo insuficiente.");
      }

      // Valida liquidez do pool (tokens suficientes para vender)
      if (tokensDisponiveis < quantidade) {
        throw new functions.https.HttpsError("failed-precondition", "Liquidez insuficiente.");
      }

      // ── Cálculos pós-compra ────────────────────────────────────────
      const novoSaldo = Number((saldo - custoTotal).toFixed(2));
      const novoCapitalArrecadado = Number((capitalArrecadado + custoTotal).toFixed(2));
      const novosTokensDisponiveis = tokensDisponiveis - quantidade;

      // AMM: novoPreço = capital / tokens (divisão protegida contra zero)
      const novoPreco = novosTokensDisponiveis > 0
        ? Number((novoCapitalArrecadado / novosTokensDisponiveis).toFixed(4))
        : precoAtual;

      // Variação percentual para exibição no frontend
      const variacao = ((novoPreco - precoAtual) / precoAtual) * 100;

      // ── ESCRITAS ATÔMICAS ──────────────────────────────────────────

      // 1. Debita saldo da carteira (merge: cria doc se não existir)
      t.set(carteiraRef, { saldo: novoSaldo }, { merge: true });

      // 2. Acumula tokens e valor pago no registro de investimento
      const invData = investimentoSnap.exists ? investimentoSnap.data() : {};
      const tokensCompradosAtuais = invData?.tokensComprados || 0;
      const valorPagoAtual = invData?.valorPago || 0;

      t.set(investimentoRef, {
        tokensComprados: tokensCompradosAtuais + quantidade,
        valorPago: Number((valorPagoAtual + custoTotal).toFixed(2))
      }, { merge: true });

      // 3. Atualiza o pool de liquidez da exchange
      t.update(exchangeRef, {
        tokensDisponiveis: novosTokensDisponiveis,
        capitalArrecadado: novoCapitalArrecadado,
        precoAtual: novoPreco,
        variacao: variacao
      });

      // 4. Registra preço do dia na subcoleção historicoPrecos (para gráficos)
      const dataAtualObj = new Date();
      const yyyy = dataAtualObj.getFullYear();
      const mm = String(dataAtualObj.getMonth() + 1).padStart(2, '0');
      const dd = String(dataAtualObj.getDate()).padStart(2, '0');
      const dataAtualId = `${yyyy}-${mm}-${dd}`;

      t.set(exchangeRef.collection("historicoPrecos").doc(dataAtualId), {
        data: admin.firestore.Timestamp.now(),
        preco: novoPreco
      }, { merge: true });

      // 5. Audit trail — registra transação no histórico da startup
      const startupRef = db.collection("startups").doc(startupId);
      const historicoRef = startupRef.collection("Histórico").doc();
      t.set(historicoRef, {
        "Preco Pago": custoTotal,
        "Tokens Comprados": quantidade,
        "Valor Token": precoAtual,
        data: admin.firestore.Timestamp.now(),
        status: "Sucesso",
        tipo: "Compra",
        uid: request.auth?.uid,
      });
    });

    // Transação completada com sucesso — retorna ao Flutter
    return { status: "success" };
  } catch (error: any) {
    // Re-lança erros HttpsError conhecidos (saldo insuficiente, etc.)
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    // Erros inesperados encapsulados como failed-precondition
    throw new functions.https.HttpsError("failed-precondition", error.message);
  }
});