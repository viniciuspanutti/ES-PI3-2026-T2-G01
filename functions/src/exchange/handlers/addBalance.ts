/**Vinícius
 * Explicação do código -> Backend para adicionar saldo fictício na carteira
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const addBalance = functions.https.onCall(async (request) => {
  if (!request.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Log in necessário.");
  }

  const userId = request.auth.uid;
  const { amount } = request.data;
  const db = admin.firestore();

  // Validações
  if (typeof amount !== 'number' || amount <= 0) {
    throw new functions.https.HttpsError("invalid-argument", "Valor inválido. O valor deve ser um número positivo.");
  }

  // Limite máximo para evitar abusos
  if (amount > 10000) {
    throw new functions.https.HttpsError("invalid-argument", "Valor máximo permitido é R$ 10.000,00.");
  }

  try {
    await db.runTransaction(async (t) => {
      const walletRef = db.collection("wallets").doc(userId);
      const walletSnap = await t.get(walletRef);

      const currentBalance = walletSnap.exists ? walletSnap.data()?.balance || 0 : 0;
      const newBalance = currentBalance + amount;

      // Atualiza ou cria a carteira
      if (walletSnap.exists) {
        t.update(walletRef, {
          balance: newBalance,
          lastBalanceUpdate: new Date(),
        });
      } else {
        t.set(walletRef, {
          balance: newBalance,
          portfolio: {},
          createdAt: new Date(),
          lastBalanceUpdate: new Date(),
        });
      }

      // Registra a transação de crédito
      const creditTransaction = {
        userId: userId,
        type: 'credit',
        amount: amount,
        description: 'Crédito de saldo fictício',
        timestamp: new Date(),
        status: 'completed',
        source: 'system_credit'
      };

      const transactionRef = db.collection("creditTransactions").doc();
      t.set(transactionRef, creditTransaction);
    });

    return { 
      status: "success",
      message: `Saldo de R$ ${amount.toFixed(2)} adicionado com sucesso!`,
      amount: amount
    };

  } catch (error: any) {
    throw new functions.https.HttpsError("failed-precondition", error.message);
  }
});
