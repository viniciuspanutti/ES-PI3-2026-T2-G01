import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";

// Inicializar Firebase Admin
admin.initializeApp();
const db = admin.firestore();

// ===== FUNÇÕES EXISTENTES =====

// Função "fake" só para o teste não quebrar no setUpAll
export const seedStartupCatalog = onCall((request) => {
  return { data: { count: 3, ids: ['biochip-campus', 'rota-verde', 'mentorai'] } };
});

export const listStartups = onCall((request) => {
  return { data: [{ id: 'biochip-campus', stage: 'nova' }], count: 1 };
});

export const getStartupDetails = onCall((request) => {
  return {
    data: {
      id: 'biochip-campus',
      executiveSummary: 'Teste',
      founders: ['João Silva'],
      publicQuestions: [
        {'question': 'O que faz a startup?'},
      ],
    },
    access: { isInvestor: false },
  };
});

// ===== FUNÇÕES DE VENDA DE TOKENS =====

/**
 * Verificar posse de tokens
 * Valida se o usuário possui os tokens desejados
 */
export const checkTokenOwnership = onCall(async (request) => {
  const { userId, startupId, quantity } = request.data;

  if (!userId || !startupId || !quantity) {
    throw new HttpsError(
      "invalid-argument",
      "userId, startupId e quantity são obrigatórios"
    );
  }

  try {
    const portfolioRef = db
      .collection("users")
      .doc(userId)
      .collection("portfolio")
      .doc(startupId);

    const portfolioDoc = await portfolioRef.get();

    if (!portfolioDoc.exists) {
      return {
        data: {
          hasTokens: false,
          message: "Usuário não possui tokens desta startup",
        },
      };
    }

    const portfolioData = portfolioDoc.data();
    const currentQuantity = portfolioData?.tokenQuantity || 0;
    const canSell = currentQuantity >= quantity;

    return {
      data: {
        hasTokens: true,
        currentQuantity,
        canSell,
        message: canSell
          ? "Usuário possui saldo suficiente"
          : `Saldo insuficiente. Disponível: ${currentQuantity}`,
      },
    };
  } catch (error) {
    throw new HttpsError("internal", `Erro ao verificar posse: ${error}`);
  }
});

/**
 * Criar oferta de venda (LISTING)
 * Registra a oferta no livro de ofertas para outros compradores
 */
export const createSaleOffer = onCall(async (request) => {
  const { userId, startupId, quantity, pricePerToken, saleType } = request.data;

  if (!userId || !startupId || !quantity || !pricePerToken) {
    throw new HttpsError(
      "invalid-argument",
      "Dados incompletos para criar oferta"
    );
  }

  try {
    // Verificar posse
    const portfolioRef = db
      .collection("users")
      .doc(userId)
      .collection("portfolio")
      .doc(startupId);

    const portfolioDoc = await portfolioRef.get();

    if (!portfolioDoc.exists || portfolioDoc.data()?.tokenQuantity < quantity) {
      throw new HttpsError(
        "failed-precondition",
        "Usuário não possui tokens suficientes"
      );
    }

    const offerId = db.collection("sales_offers").doc().id;
    const totalValue = quantity * pricePerToken;
    const now = new Date();

    const saleOfferData = {
      id: offerId,
      userId,
      startupId,
      quantity,
      pricePerToken,
      totalValue,
      createdAt: admin.firestore.Timestamp.fromDate(now),
      status: "ACTIVE",
      saleType: saleType || "LISTING",
      reservedQuantity: 0,
    };

    await db.collection("sales_offers").doc(offerId).set(saleOfferData);

    return {
      data: {
        success: true,
        offerId,
        message: "Oferta criada com sucesso",
        saleOffer: saleOfferData,
      },
    };
  } catch (error: any) {
    throw new HttpsError("internal", `Erro ao criar oferta: ${error.message}`);
  }
});

/**
 * Executar venda direta
 * O usuário vende imediatamente para o sistema (simulado)
 * Atualiza o portfólio e o saldo do usuário
 */
export const executeDirectSale = onCall(async (request) => {
  const { userId, startupId, quantity, pricePerToken } = request.data;

  if (!userId || !startupId || !quantity || !pricePerToken) {
    throw new HttpsError(
      "invalid-argument",
      "Dados incompletos para executar venda"
    );
  }

  const batch = db.batch();
  const transactionId = db.collection("transactions").doc().id;
  const now = new Date();

  try {
    // 1. Verificar posse de tokens
    const portfolioRef = db
      .collection("users")
      .doc(userId)
      .collection("portfolio")
      .doc(startupId);

    const portfolioDoc = await portfolioRef.get();

    if (!portfolioDoc.exists || portfolioDoc.data()?.tokenQuantity < quantity) {
      throw new HttpsError(
        "failed-precondition",
        "Saldo insuficiente de tokens"
      );
    }

    const totalValue = quantity * pricePerToken;

    // 2. Atualizar portfólio - Subtrair tokens
    const currentQuantity = portfolioDoc.data()?.tokenQuantity || 0;
    batch.update(portfolioRef, {
      tokenQuantity: currentQuantity - quantity,
      updatedAt: admin.firestore.Timestamp.fromDate(now),
    });

    // 3. Atualizar saldo da carteira do usuário
    const walletRef = db.collection("users").doc(userId).collection("wallet").doc("balance");
    const walletDoc = await walletRef.get();
    const currentBalance = walletDoc.exists ? walletDoc.data()?.balance || 0 : 0;

    batch.set(
      walletRef,
      {
        balance: currentBalance + totalValue,
        lastUpdated: admin.firestore.Timestamp.fromDate(now),
      },
      { merge: true }
    );

    // 4. Registrar transação
    const transactionData = {
      id: transactionId,
      sellerId: userId,
      buyerId: "SYSTEM",
      startupId,
      quantity,
      pricePerToken,
      totalValue,
      executedAt: admin.firestore.Timestamp.fromDate(now),
      transactionType: "DIRECT_SALE",
      status: "COMPLETED",
      metadata: {
        saleMethod: "DIRECT_SYSTEM",
      },
    };

    batch.set(
      db.collection("transactions").doc(transactionId),
      transactionData
    );

    // 5. Registrar histórico de transações do usuário
    batch.set(
      db
        .collection("users")
        .doc(userId)
        .collection("transaction_history")
        .doc(transactionId),
      transactionData
    );

    // 6. Atualizar valorização da startup (impacto da venda)
    await updateStartupValuation(batch, startupId, quantity, pricePerToken);

    // Executar todas as operações atomicamente
    await batch.commit();

    return {
      data: {
        success: true,
        transactionId,
        message: "Venda executada com sucesso",
        transaction: transactionData,
        newBalance: currentBalance + totalValue,
      },
    };
  } catch (error: any) {
    throw new HttpsError(
      "internal",
      `Erro ao executar venda: ${error.message}`
    );
  }
});

/**
 * Listar ofertas disponíveis para compra
 */
export const listAvailableSaleOffers = onCall(async (request) => {
  const { startupId, limit = 20 } = request.data;

  try {
    let query: FirebaseFirestore.Query = db.collection("sales_offers");

    if (startupId) {
      query = query.where("startupId", "==", startupId);
    }

    query = query
      .where("status", "==", "ACTIVE")
      .orderBy("createdAt", "desc")
      .limit(limit);

    const snapshot = await query.get();
    const offers = snapshot.docs.map((doc) => doc.data());

    return {
      data: {
        success: true,
        offers,
        count: offers.length,
      },
    };
  } catch (error: any) {
    throw new HttpsError(
      "internal",
      `Erro ao listar ofertas: ${error.message}`
    );
  }
});

/**
 * Executar compra de oferta (marketplace)
 * Um comprador compra de uma oferta listada
 */
export const executePurchaseFromListing = onCall(async (request) => {
  const { buyerId, offerId, quantity } = request.data;

  if (!buyerId || !offerId || !quantity) {
    throw new HttpsError(
      "invalid-argument",
      "buyerId, offerId e quantity são obrigatórios"
    );
  }

  const batch = db.batch();
  const transactionId = db.collection("transactions").doc().id;
  const now = new Date();

  try {
    // 1. Obter a oferta
    const offerRef = db.collection("sales_offers").doc(offerId);
    const offerDoc = await offerRef.get();

    if (!offerDoc.exists) {
      throw new HttpsError("not-found", "Oferta não encontrada");
    }

    const offerData = offerDoc.data();
    const availableQuantity =
      (offerData?.quantity || 0) - (offerData?.reservedQuantity || 0);

    if (availableQuantity < quantity) {
      throw new HttpsError(
        "failed-precondition",
        `Quantidade disponível: ${availableQuantity}`
      );
    }

    // 2. Verificar saldo do comprador
    const buyerWalletRef = db
      .collection("users")
      .doc(buyerId)
      .collection("wallet")
      .doc("balance");
    const buyerWalletDoc = await buyerWalletRef.get();
    const buyerBalance = buyerWalletDoc.exists
      ? buyerWalletDoc.data()?.balance || 0
      : 0;

    const totalCost = quantity * (offerData?.pricePerToken || 0);

    if (buyerBalance < totalCost) {
      throw new HttpsError("failed-precondition", "Saldo insuficiente");
    }

    // 3. Atualizar oferta
    batch.update(offerRef, {
      reservedQuantity: (offerData?.reservedQuantity || 0) + quantity,
      status:
        availableQuantity - quantity === 0 ? "COMPLETED" : "PARTIALLY_FILLED",
      updatedAt: admin.firestore.Timestamp.fromDate(now),
    });

    // 4. Debitar do comprador
    batch.update(buyerWalletRef, {
      balance: buyerBalance - totalCost,
      lastUpdated: admin.firestore.Timestamp.fromDate(now),
    });

    // 5. Creditar ao vendedor
    const sellerWalletRef = db
      .collection("users")
      .doc(offerData?.userId)
      .collection("wallet")
      .doc("balance");
    const sellerWalletDoc = await sellerWalletRef.get();
    const sellerBalance = sellerWalletDoc.exists
      ? sellerWalletDoc.data()?.balance || 0
      : 0;

    batch.update(sellerWalletRef, {
      balance: sellerBalance + totalCost,
      lastUpdated: admin.firestore.Timestamp.fromDate(now),
    });

    // 6. Atualizar portfólio do vendedor (subtrair)
    const sellerPortfolioRef = db
      .collection("users")
      .doc(offerData?.userId)
      .collection("portfolio")
      .doc(offerData?.startupId);
    const sellerPortfolioDoc = await sellerPortfolioRef.get();
    const sellerTokens = sellerPortfolioDoc.exists
      ? sellerPortfolioDoc.data()?.tokenQuantity || 0
      : 0;

    batch.update(sellerPortfolioRef, {
      tokenQuantity: sellerTokens - quantity,
      updatedAt: admin.firestore.Timestamp.fromDate(now),
    });

    // 7. Atualizar portfólio do comprador (adicionar)
    const buyerPortfolioRef = db
      .collection("users")
      .doc(buyerId)
      .collection("portfolio")
      .doc(offerData?.startupId);
    const buyerPortfolioDoc = await buyerPortfolioRef.get();
    const buyerTokens = buyerPortfolioDoc.exists
      ? buyerPortfolioDoc.data()?.tokenQuantity || 0
      : 0;

    batch.set(
      buyerPortfolioRef,
      {
        userId: buyerId,
        startupId: offerData?.startupId,
        tokenQuantity: buyerTokens + quantity,
        averageBuyPrice: (offerData?.pricePerToken || 0),
        currentValue: quantity * (offerData?.pricePerToken || 0),
        acquiredAt: admin.firestore.Timestamp.fromDate(now),
        updatedAt: admin.firestore.Timestamp.fromDate(now),
      },
      { merge: true }
    );

    // 8. Registrar transação
    const transactionData = {
      id: transactionId,
      sellerId: offerData?.userId,
      buyerId,
      startupId: offerData?.startupId,
      quantity,
      pricePerToken: offerData?.pricePerToken,
      totalValue: totalCost,
      executedAt: admin.firestore.Timestamp.fromDate(now),
      transactionType: "MARKETPLACE",
      status: "COMPLETED",
      metadata: {
        offerId,
        saleMethod: "PEER_TO_PEER",
      },
    };

    batch.set(
      db.collection("transactions").doc(transactionId),
      transactionData
    );

    // 9. Registrar no histórico de ambos os usuários
    batch.set(
      db
        .collection("users")
        .doc(offerData?.userId)
        .collection("transaction_history")
        .doc(transactionId),
      transactionData
    );

    batch.set(
      db
        .collection("users")
        .doc(buyerId)
        .collection("transaction_history")
        .doc(transactionId),
      transactionData
    );

    // 10. Atualizar valorização da startup
    await updateStartupValuation(
      batch,
      offerData?.startupId,
      quantity,
      offerData?.pricePerToken || 0
    );

    await batch.commit();

    return {
      data: {
        success: true,
        transactionId,
        message: "Compra executada com sucesso",
      },
    };
  } catch (error: any) {
    throw new HttpsError(
      "internal",
      `Erro ao executar compra: ${error.message}`
    );
  }
});

/**
 * Obter histórico de transações do usuário
 */
export const getUserTransactionHistory = onCall(async (request) => {
  const { userId, limit = 50 } = request.data;

  if (!userId) {
    throw new HttpsError("invalid-argument", "userId é obrigatório");
  }

  try {
    const snapshot = await db
      .collection("users")
      .doc(userId)
      .collection("transaction_history")
      .orderBy("executedAt", "desc")
      .limit(limit)
      .get();

    const transactions = snapshot.docs.map((doc) => doc.data());

    return {
      data: {
        success: true,
        transactions,
        count: transactions.length,
      },
    };
  } catch (error: any) {
    throw new HttpsError(
      "internal",
      `Erro ao obter histórico: ${error.message}`
    );
  }
});

/**
 * Obter portfólio do usuário
 */
export const getUserPortfolio = onCall(async (request) => {
  const { userId } = request.data;

  if (!userId) {
    throw new HttpsError("invalid-argument", "userId é obrigatório");
  }

  try {
    const snapshot = await db
      .collection("users")
      .doc(userId)
      .collection("portfolio")
      .get();

    const portfolio = snapshot.docs.map((doc) => ({
      ...doc.data(),
      startupId: doc.id,
    }));

    return {
      data: {
        success: true,
        portfolio,
        count: portfolio.length,
      },
    };
  } catch (error: any) {
    throw new HttpsError(
      "internal",
      `Erro ao obter portfólio: ${error.message}`
    );
  }
});

/**
 * Obter saldo da carteira
 */
export const getWalletBalance = onCall(async (request) => {
  const { userId } = request.data;

  if (!userId) {
    throw new HttpsError("invalid-argument", "userId é obrigatório");
  }

  try {
    const walletDoc = await db
      .collection("users")
      .doc(userId)
      .collection("wallet")
      .doc("balance")
      .get();

    const balance = walletDoc.exists ? walletDoc.data()?.balance || 0 : 0;

    return {
      data: {
        success: true,
        balance,
      },
    };
  } catch (error: any) {
    throw new HttpsError(
      "internal",
      `Erro ao obter saldo: ${error.message}`
    );
  }
});

/**
 * Cancelar oferta de venda
 */
export const cancelSaleOffer = onCall(async (request) => {
  const { offerId, userId } = request.data;

  if (!offerId || !userId) {
    throw new HttpsError(
      "invalid-argument",
      "offerId e userId são obrigatórios"
    );
  }

  try {
    const offerRef = db.collection("sales_offers").doc(offerId);
    const offerDoc = await offerRef.get();

    if (!offerDoc.exists) {
      throw new HttpsError("not-found", "Oferta não encontrada");
    }

    const offerData = offerDoc.data();

    if (offerData?.userId !== userId) {
      throw new HttpsError("permission-denied", "Usuário não é o proprietário");
    }

    if (offerData?.status === "COMPLETED") {
      throw new HttpsError(
        "failed-precondition",
        "Não é possível cancelar uma oferta completada"
      );
    }

    await offerRef.update({
      status: "CANCELLED",
      cancelledAt: admin.firestore.Timestamp.fromDate(new Date()),
    });

    return {
      data: {
        success: true,
        message: "Oferta cancelada com sucesso",
      },
    };
  } catch (error: any) {
    throw new HttpsError(
      "internal",
      `Erro ao cancelar oferta: ${error.message}`
    );
  }
});

/**
 * Obter dados de valorização da startup
 * Retorna histórico de preços e dados para gráficos
 */
export const getStartupValuation = onCall(async (request) => {
  const { startupId, period = 'DAILY' } = request.data;

  if (!startupId) {
    throw new HttpsError("invalid-argument", "startupId é obrigatório");
  }

  try {
    const valuationDoc = await db.collection("startups").doc(startupId).get();
    
    if (!valuationDoc.exists) {
      // Criar dados iniciais se não existir
      const initialPrice = 100.00; // Preço base inicial
      const today = new Date().toISOString().split("T")[0];
      const initialData = {
        startupId,
        currentPrice: initialPrice,
        previousPrice: initialPrice,
        lastUpdated: admin.firestore.Timestamp.fromDate(new Date()),
        valuationMethod: period,
        priceHistory: {
          [today]: initialPrice
        },
        createdAt: admin.firestore.Timestamp.fromDate(new Date())
      };

      await db.collection("startups").doc(startupId).set(initialData);
      return {
        data: {
          success: true,
          valuation: initialData,
          chartData: generateChartData(initialData.priceHistory, period)
        }
      };
    }

    const valuationData = valuationDoc.data();
    const chartData = generateChartData(valuationData.priceHistory || {}, period);

    return {
      data: {
        success: true,
        valuation: valuationData,
        chartData,
        currentPrice: valuationData.currentPrice,
        previousPrice: valuationData.previousPrice,
        variation: calculateVariation(valuationData.currentPrice, valuationData.previousPrice)
      }
    };
  } catch (error: any) {
    throw new HttpsError("internal", `Erro ao obter valorização: ${error.message}`);
  }
});

/**
 * Obter histórico de transações da startup para cálculos de valorização
 */
export const getStartupTransactionHistory = onCall(async (request) => {
  const { startupId, limit = 100 } = request.data;

  if (!startupId) {
    throw new HttpsError("invalid-argument", "startupId é obrigatório");
  }

  try {
    const snapshot = await db
      .collection("transactions")
      .where("startupId", "==", startupId)
      .orderBy("executedAt", "desc")
      .limit(limit)
      .get();

    const transactions = snapshot.docs.map((doc) => doc.data());

    return {
      data: {
        success: true,
        transactions,
        count: transactions.length,
        volume: transactions.reduce((sum, tx) => sum + (tx.quantity || 0), 0),
        totalValue: transactions.reduce((sum, tx) => sum + (tx.totalValue || 0), 0)
      }
    };
  } catch (error: any) {
    throw new HttpsError("internal", `Erro ao obter histórico: ${error.message}`);
  }
});

/**
 * FUNÇÃO AUXILIAR: Atualizar valorização da startup
 * Impacta o preço do token baseado nas transações
 */
async function updateStartupValuation(
  batch: FirebaseFirestore.WriteBatch,
  startupId: string,
  quantity: number,
  pricePerToken: number
): Promise<void> {
  try {
    const valuationRef = db.collection("startups").doc(startupId);
    const valuationDoc = await valuationRef.get();

    const valuationData = valuationDoc.exists
      ? valuationDoc.data()
      : {
          startupId,
          currentPrice: pricePerToken,
          previousPrice: pricePerToken,
          lastUpdated: new Date(),
          valuationMethod: "DAILY",
          priceHistory: {},
        };

    const previousPrice = valuationData.currentPrice || pricePerToken;

    // Simular impacto: pequena variação baseada no volume
    // Cada 1000 tokens vendidos = 0.5% de impacto no preço
    const volumeImpact = (quantity / 1000) * 0.005;
    const newPrice = previousPrice * (1 + volumeImpact);

    const today = new Date().toISOString().split("T")[0];
    const priceHistory = valuationData.priceHistory || {};
    priceHistory[today] = newPrice;

    batch.set(
      valuationRef,
      {
        startupId,
        currentPrice: newPrice,
        previousPrice,
        lastUpdated: admin.firestore.Timestamp.fromDate(new Date()),
        valuationMethod: "DAILY",
        priceHistory,
      },
      { merge: true }
    );
  } catch (error) {
    console.error("Erro ao atualizar valorização:", error);
  }
}

/**
 * FUNÇÃO AUXILIAR: Gerar dados para gráficos baseados no período
 */
function generateChartData(priceHistory: any, period: string): Array<{x: number, y: number}> {
  const entries = Object.entries(priceHistory).sort(([a], [b]) => a.localeCompare(b));
  
  switch (period) {
    case 'DAILY':
      return entries.slice(-24).map((_, index) => ({
        x: index,
        y: parseFloat(entries[index][1] as string)
      }));
    
    case 'WEEKLY':
      return entries.slice(-7).map((_, index) => ({
        x: index,
        y: parseFloat(entries[index][1] as string)
      }));
    
    case 'MONTHLY':
      return entries.slice(-30).map((_, index) => ({
        x: index,
        y: parseFloat(entries[index][1] as string)
      }));
    
    case '6M':
      return entries.slice(-180).map((_, index) => ({
        x: index,
        y: parseFloat(entries[index][1] as string)
      }));
    
    case 'YTD':
      const currentYear = new Date().getFullYear();
      const yearStart = `${currentYear}-01-01`;
      const yearEntries = entries.filter(([date]) => date >= yearStart);
      return yearEntries.map((_, index) => ({
        x: index,
        y: parseFloat(yearEntries[index][1] as string)
      }));
    
    default:
      return entries.slice(-30).map((_, index) => ({
        x: index,
        y: parseFloat(entries[index][1] as string)
      }));
  }
}

/**
 * FUNÇÃO AUXILIAR: Calcular variação percentual
 */
function calculateVariation(currentPrice: number, previousPrice: number): number {
  if (!previousPrice || previousPrice === 0) return 0;
  return ((currentPrice - previousPrice) / previousPrice) * 100;
}
