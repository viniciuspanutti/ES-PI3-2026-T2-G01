/**Vinícius
 * Explicação: com gravação do histórico de preços
 */
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const sellTokens = functions.https.onCall(async (request) => {
  if (!request.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Log in necessário.");
  }

  const userId = request.auth.uid;
  const { startupId, quantidade } = request.data;

  if (!startupId || typeof quantidade !== "number" || quantidade <= 0) {
    throw new functions.https.HttpsError("invalid-argument", "Parâmetros inválidos.");
  }

  const db = admin.firestore();

  try {
    await db.runTransaction(async (t) => {
      const carteiraRef = db.collection("users").doc(userId).collection("carteira").doc("saldo");
      const investimentoRef = db.collection("users").doc(userId).collection("investimentos").doc(startupId);
      const exchangeRef = db.collection("exchange").doc(startupId);

      const [carteiraSnap, investimentoSnap, exchangeSnap] = await Promise.all([
        t.get(carteiraRef),
        t.get(investimentoRef),
        t.get(exchangeRef)
      ]);

      if (!exchangeSnap.exists) {
        throw new functions.https.HttpsError("failed-precondition", "Exchange não encontrada para esta startup.");
      }

      const invData = investimentoSnap.exists ? investimentoSnap.data() : {};
      const tokensPossuidos = invData?.tokensComprados || 0;
      if (tokensPossuidos < quantidade) {
        throw new functions.https.HttpsError("failed-precondition", "Tokens insuficientes para venda.");
      }

      const exchangeData = exchangeSnap.data()!;
      const precoAtual = exchangeData.precoAtual || 0;
      const tokensDisponiveis = exchangeData.tokensDisponiveis || 0;
      const capitalArrecadado = exchangeData.capitalArrecadado || 0;

      const valorVenda = Number((precoAtual * quantidade).toFixed(2));

      if (capitalArrecadado < valorVenda) {
        throw new functions.https.HttpsError("failed-precondition", "Liquidez insuficiente no pool.");
      }

      const saldoData = carteiraSnap.exists ? carteiraSnap.data() : { saldo: 0 };
      const saldo = saldoData?.saldo || 0;

      const novoSaldo = Number((saldo + valorVenda).toFixed(2));
      const novoCapitalArrecadado = Number((capitalArrecadado - valorVenda).toFixed(2));
      const novosTokensDisponiveis = tokensDisponiveis + quantidade;

      const novoPreco = novosTokensDisponiveis > 0
        ? Number((novoCapitalArrecadado / novosTokensDisponiveis).toFixed(4))
        : precoAtual;

      t.set(carteiraRef, { saldo: novoSaldo }, { merge: true });

      const valorPagoAtual = invData?.valorPago || 0;
      const proporcao = quantidade / tokensPossuidos;
      const reducaoValorPago = valorPagoAtual * proporcao;

      t.set(investimentoRef, {
        tokensComprados: tokensPossuidos - quantidade,
        valorPago: Number((valorPagoAtual - reducaoValorPago).toFixed(2))
      }, { merge: true });

      t.update(exchangeRef, {
        tokensDisponiveis: novosTokensDisponiveis,
        capitalArrecadado: novoCapitalArrecadado,
        precoAtual: novoPreco
      });

      const dataAtualObj = new Date();
      const yyyy = dataAtualObj.getFullYear();
      const mm = String(dataAtualObj.getMonth() + 1).padStart(2, '0');
      const dd = String(dataAtualObj.getDate()).padStart(2, '0');
      const dataAtualId = `${yyyy}-${mm}-${dd}`;

      t.set(exchangeRef.collection("historicoPrecos").doc(dataAtualId), {
        data: admin.firestore.Timestamp.now(),
        preco: novoPreco
      }, { merge: true });
    });

    return { status: "success" };
  } catch (error: any) {
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError("failed-precondition", error.message);
  }
});
