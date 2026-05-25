/**Vinícius
 * Explicação do código -> Refatorado para usar AMM e transações atômicas unificadas no Firebase.
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const buyTokens = functions.https.onCall(async (request) => {
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

      const exchangeData = exchangeSnap.data()!;
      const precoAtual = exchangeData.precoAtual || 0;
      const tokensDisponiveis = exchangeData.tokensDisponiveis || 0;
      const capitalArrecadado = exchangeData.capitalArrecadado || 0;

      const custoTotal = Number((precoAtual * quantidade).toFixed(2));

      const saldoData = carteiraSnap.exists ? carteiraSnap.data() : { saldo: 0 };
      const saldo = saldoData?.saldo || 0;

      if (saldo < custoTotal) {
        throw new functions.https.HttpsError("failed-precondition", "Saldo insuficiente.");
      }

      if (tokensDisponiveis < quantidade) {
        throw new functions.https.HttpsError("failed-precondition", "Liquidez insuficiente.");
      }

      const novoSaldo = Number((saldo - custoTotal).toFixed(2));
      const novoCapitalArrecadado = Number((capitalArrecadado + custoTotal).toFixed(2));
      const novosTokensDisponiveis = tokensDisponiveis - quantidade;
      
      const novoPreco = novosTokensDisponiveis > 0 
        ? Number((novoCapitalArrecadado / novosTokensDisponiveis).toFixed(4)) 
        : precoAtual;

      const variacao = ((novoPreco - precoAtual) / precoAtual) * 100;

      t.set(carteiraRef, { saldo: novoSaldo }, { merge: true });

      const invData = investimentoSnap.exists ? investimentoSnap.data() : {};
      const tokensCompradosAtuais = invData?.tokensComprados || 0;
      const valorPagoAtual = invData?.valorPago || 0;

      t.set(investimentoRef, {
        tokensComprados: tokensCompradosAtuais + quantidade,
        valorPago: Number((valorPagoAtual + custoTotal).toFixed(2))
      }, { merge: true });

      t.update(exchangeRef, {
        tokensDisponiveis: novosTokensDisponiveis,
        capitalArrecadado: novoCapitalArrecadado,
        precoAtual: novoPreco,
        variacao: variacao
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

      const startupRef = db.collection("startups").doc(startupId);
      const historicoRef = startupRef.collection("Histórico").doc();
      t.set(historicoRef, {
        "Preco Pago": custoTotal,
        "Tokens Comprados": quantidade,
        "Valor Token": precoAtual,
        data: admin.firestore.Timestamp.now(),
        status: "Sucesso",
        tipo: "Compra",
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