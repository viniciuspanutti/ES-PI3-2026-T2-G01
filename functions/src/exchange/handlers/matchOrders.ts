/**Vinícius
 * Explicação do código -> Sistema de matching automático de ordens
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { Transaction } from "../types";

export const matchOrders = functions.https.onCall(async (request) => {
  if (!request.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Log in necessário.");
  }

  const { startupId, buyQuantity, maxPrice } = request.data;
  const db = admin.firestore();

  try {
    await db.runTransaction(async (t) => {
      // Busca ordens de venda abertas ordenadas por preço (menor primeiro)
      const sellOrdersQuery = db
        .collection("sellOrders")
        .where("startupId", "==", startupId)
        .where("status", "==", "open")
        .where("desiredPrice", "<=", maxPrice)
        .orderBy("desiredPrice", "asc")
        .orderBy("timestamp", "asc");

      const sellOrdersSnapshot = await t.get(sellOrdersQuery);
      const sellOrders = sellOrdersSnapshot.docs.map(doc => ({
        id: doc.id,
        ...doc.data()
      }));

      if (sellOrders.length === 0) {
        throw new Error("Nenhuma ordem de venda encontrada para o preço máximo especificado.");
      }

      let remainingQuantity = buyQuantity;
      let totalCost = 0;
      const matchedOrders = [];

      // Processa matching
      for (const order of sellOrders) {
        if (remainingQuantity <= 0) break;

        const orderQuantity = order.quantity;
        const orderPrice = order.desiredPrice;
        const matchQuantity = Math.min(remainingQuantity, orderQuantity);

        totalCost += matchQuantity * orderPrice;
        remainingQuantity -= matchQuantity;
        matchedOrders.push({
          orderId: order.id,
          sellerId: order.userId,
          quantity: matchQuantity,
          price: orderPrice
        });

        // Atualiza ou remove ordem de venda
        if (matchQuantity === orderQuantity) {
          // Ordem completamente executada
          t.update(db.collection("sellOrders").doc(order.id), {
            status: "matched",
            matchedAt: new Date()
          });
        } else {
          // Ordem parcialmente executada
          t.update(db.collection("sellOrders").doc(order.id), {
            quantity: orderQuantity - matchQuantity,
            totalValue: (orderQuantity - matchQuantity) * orderPrice
          });
        }
      }

      if (remainingQuantity > 0) {
        throw new Error(`Quantidade insuficiente. Faltam ${remainingQuantity} tokens.`);
      }

      // Processa pagamento e transferência de tokens
      const buyerId = request.auth.uid;
      const buyerWalletRef = db.collection("wallets").doc(buyerId);
      const buyerWalletSnap = await t.get(buyerWalletRef);
      
      if (!buyerWalletSnap.exists) {
        throw new Error("Carteira do comprador não encontrada.");
      }

      const buyerBalance = buyerWalletSnap.data()?.balance || 0;
      if (buyerBalance < totalCost) {
        throw new Error("Saldo insuficiente para completar a compra.");
      }

      // Atualiza carteira do comprador
      const buyerPortfolio = buyerWalletSnap.data()?.portfolio || {};
      const currentBuyerTokens = buyerPortfolio[startupId] || 0;
      
      t.update(buyerWalletRef, {
        balance: buyerBalance - totalCost,
        [`portfolio.${startupId}`]: currentBuyerTokens + buyQuantity
      });

      // Processa vendedores
      for (const match of matchedOrders) {
        const sellerWalletRef = db.collection("wallets").doc(match.sellerId);
        const sellerWalletSnap = await t.get(sellerWalletRef);
        
        if (sellerWalletSnap.exists) {
          const sellerBalance = sellerWalletSnap.data()?.balance || 0;
          const sellerPortfolio = sellerWalletSnap.data()?.portfolio || {};
          const currentSellerTokens = sellerPortfolio[startupId] || 0;
          const lockedTokens = sellerWalletSnap.data()?.lockedTokens?.[startupId] || 0;

          t.update(sellerWalletRef, {
            balance: sellerBalance + (match.quantity * match.price),
            [`portfolio.${startupId}`]: currentSellerTokens - match.quantity,
            [`lockedTokens.${startupId}`]: Math.max(0, lockedTokens - match.quantity)
          });
        }

        // Registra transação do vendedor
        const sellTransaction: Omit<Transaction, 'id'> = {
          userId: match.sellerId,
          startupId,
          type: 'sell',
          quantity: match.quantity,
          unitPrice: match.price,
          totalValue: match.quantity * match.price,
          timestamp: new Date(),
          status: 'completed'
        };

        const sellTransactionRef = db.collection("transactions").doc();
        t.set(sellTransactionRef, sellTransaction);
      }

      // Registra transação do comprador
      const buyTransaction: Omit<Transaction, 'id'> = {
        userId: buyerId,
        startupId,
        type: 'buy',
        quantity: buyQuantity,
        unitPrice: totalCost / buyQuantity, // Preço médio
        totalValue: totalCost,
        timestamp: new Date(),
        status: 'completed'
      };

      const buyTransactionRef = db.collection("transactions").doc();
      t.set(buyTransactionRef, buyTransaction);

      // Atualiza preço da startup
      const startupRef = db.collection("startups").doc(startupId);
      const startupSnap = await t.get(startupRef);
      
      if (startupSnap.exists) {
        const avgPrice = totalCost / buyQuantity;
        const currentPrice = startupSnap.data()?.currentTokenPrice || 0;
        
        // Lógica de impacto no preço baseada no volume
        const priceImpact = Math.min(0.05, (buyQuantity / 1000) * 0.02);
        const newPrice = currentPrice > avgPrice 
          ? currentPrice * (1 - priceImpact * 0.5) // Reduz menos se preço já for alto
          : avgPrice * (1 + priceImpact * 0.3);   // Aumenta menos se preço for baixo

        t.update(startupRef, {
          currentTokenPrice: newPrice,
          lastTradePrice: avgPrice,
          lastTradeVolume: buyQuantity,
          lastTradeTime: new Date(),
          totalVolume: (startupSnap.data()?.totalVolume || 0) + buyQuantity
        });
      }
    });

    return { 
      status: "success",
      message: "Ordens executadas com sucesso"
    };

  } catch (error: any) {
    throw new functions.https.HttpsError("failed-precondition", error.message);
  }
});
