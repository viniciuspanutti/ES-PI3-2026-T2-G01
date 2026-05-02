/**Vinícius
 * Explicação do código -> Visualização do livro de ofertas
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const getOrderBook = functions.https.onCall(async (request) => {
  if (!request.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Log in necessário.");
  }

  const { startupId } = request.data;
  const db = admin.firestore();

  try {
    // Busca ordens de venda abertas para a startup
    const sellOrdersSnapshot = await db
      .collection("sellOrders")
      .where("startupId", "==", startupId)
      .where("status", "==", "open")
      .orderBy("desiredPrice", "asc")
      .orderBy("timestamp", "asc")
      .get();

    const sellOrders = sellOrdersSnapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data()
    }));

    // Busca informações da startup
    const startupDoc = await db.collection("startups").doc(startupId).get();
    if (!startupDoc.exists) {
      throw new Error("Startup não encontrada.");
    }

    const startupData = startupDoc.data();

    return {
      status: "success",
      startup: {
        id: startupId,
        name: startupData?.name,
        currentTokenPrice: startupData?.currentTokenPrice,
        lastTradePrice: startupData?.lastTradePrice,
        lastTradeVolume: startupData?.lastTradeVolume,
        lastTradeTime: startupData?.lastTradeTime,
      },
      sellOrders: sellOrders,
      totalOrders: sellOrders.length,
      totalVolume: sellOrders.reduce((sum, order) => sum + order.quantity, 0)
    };

  } catch (error: any) {
    throw new functions.https.HttpsError("failed-precondition", error.message);
  }
});
