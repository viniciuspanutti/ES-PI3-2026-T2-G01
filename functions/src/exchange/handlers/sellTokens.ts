/**Vinícius
 * Explicação do código -> Implementação de venda simulada de tokens
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { Transaction, SellOrder } from "../types";

export const sellTokens = functions.https.onCall(async (request) => {
  if (!request.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Log in necessário.");
  }

  const userId = request.auth.uid;
  const { startupId, tokenQuantity, sellType, desiredPrice } = request.data;
  const db = admin.firestore();

  try {
    await db.runTransaction(async (t) => {
      // 1. Verificação de Custódia
      const startupRef = db.collection("startups").doc(startupId);
      const walletRef = db.collection("wallets").doc(userId);

      const startupSnap = await t.get(startupRef);
      if (!startupSnap.exists) throw new Error("Startup não encontrada.");

      const startupData = startupSnap.data();
      const currentTokenPrice = startupData?.currentTokenPrice || 0;

      // Verificar se o usuário possui os tokens
      const walletSnap = await t.get(walletRef);
      if (!walletSnap.exists) throw new Error("Carteira não encontrada.");
      
      const portfolio = walletSnap.data()?.portfolio || {};
      const ownedTokens = portfolio[startupId] || 0;

      if (ownedTokens < tokenQuantity) {
        throw new Error(`Você possui apenas ${ownedTokens} tokens, mas tentou vender ${tokenQuantity}.`);
      }

      // 2. Definição da venda
      const sellPrice = sellType === 'direct' ? currentTokenPrice : desiredPrice;
      const totalValue = sellPrice * tokenQuantity;

      if (sellType === 'direct') {
        // Venda Direta (Simulada) - vende para o sistema
        const newBalance = (walletSnap.data()?.balance || 0) + totalValue;
        const newTokenCount = ownedTokens - tokenQuantity;

        // Atualização da Posição do Investidor
        if (newTokenCount === 0) {
          // Remove a startup do portfólio se não tiver mais tokens
          const newPortfolio = { ...portfolio };
          delete newPortfolio[startupId];
          t.update(walletRef, {
            balance: newBalance,
            portfolio: newPortfolio
          });
        } else {
          t.update(walletRef, {
            balance: newBalance,
            [`portfolio.${startupId}`]: newTokenCount
          });
        }

        // 3. Registro da Transação
        const transaction: Omit<Transaction, 'id'> = {
          userId,
          startupId,
          type: 'sell',
          quantity: tokenQuantity,
          unitPrice: sellPrice,
          totalValue,
          timestamp: new Date(),
          status: 'completed'
        };

        const transactionRef = db.collection("transactions").doc();
        t.set(transactionRef, transaction);

        // 4. Impacto na Valorização do Token (lógica simples de exemplo)
        // Reduz o preço um pouco baseado no volume de venda
        const priceImpact = Math.min(0.02, (tokenQuantity / 1000) * 0.01); // Máximo 2% de impacto
        const newTokenPrice = currentTokenPrice * (1 - priceImpact);
        
        t.update(startupRef, {
          currentTokenPrice: newTokenPrice,
          lastTradePrice: sellPrice,
          lastTradeVolume: tokenQuantity,
          lastTradeTime: new Date()
        });

      } else if (sellType === 'orderbook') {
        // Livro de Ofertas - registra a oferta para outro usuário comprar
        const sellOrder: Omit<SellOrder, 'id'> = {
          userId,
          startupId,
          quantity: tokenQuantity,
          desiredPrice,
          totalValue,
          timestamp: new Date(),
          status: 'open',
          type: 'orderbook'
        };

        const orderRef = db.collection("sellOrders").doc();
        t.set(orderRef, sellOrder);

        // Bloqueia os tokens para venda (opcional - para vender múltiplas vezes)
        t.update(walletRef, {
          [`portfolio.${startupId}`]: ownedTokens - tokenQuantity,
          [`lockedTokens.${startupId}`]: (walletSnap.data()?.lockedTokens?.[startupId] || 0) + tokenQuantity
        });
      }
    });

    return { 
      status: "success",
      message: sellType === 'direct' ? 'Venda direta realizada com sucesso' : 'Oferta registrada no balcão de negociação'
    };

  } catch (error: any) {
    throw new functions.https.HttpsError("failed-precondition", error.message);
  }
});
