/**Vinícius
 * Explicação do código ->
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const buyTokens = functions.https.onCall(async (request) => {
  // Agora o auth vem de dentro do objeto 'request'
  if (!request.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Log in necessário.");
  }

  const userId = request.auth.uid;
  // Os dados do body também vêm de dentro de 'request.data'
  const { startupId, tokenQuantity } = request.data;
  const db = admin.firestore();

  try {
    await db.runTransaction(async (t) => {
      const startupRef = db.collection("startups").doc(startupId);
      const walletRef = db.collection("wallets").doc(userId);

      const startupSnap = await t.get(startupRef);
      if (!startupSnap.exists) throw new Error("Startup não encontrada.");

      const price = startupSnap.data()?.currentTokenPrice;
      const totalCost = price * tokenQuantity;

      const walletSnap = await t.get(walletRef);
      const balance = walletSnap.exists ? walletSnap.data()?.balance : 0;

      if (balance < totalCost) throw new Error("Saldo insuficiente na carteira.");

      const currentTokens = walletSnap.exists ? walletSnap.data()?.portfolio?.[startupId] || 0 : 0;

      t.set(walletRef, {
        balance: balance - totalCost,
        portfolio: { [startupId]: currentTokens + tokenQuantity }
      }, { merge: true });
    });
    return { status: "success" };
  } catch (error: any) {
    throw new functions.https.HttpsError("failed-precondition", error.message);
  }
});