/**Vinícius
 * Explicação do código -> Backend para buscar histórico de transações do usuário
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const getTransactionHistory = functions.https.onCall(async (request) => {
  if (!request.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Log in necessário.");
  }

  const userId = request.auth.uid;
  const { limit = 50, offset = 0, startupId, transactionType } = request.data;
  const db = admin.firestore();

  try {
    // Busca transações do usuário
    let transactionsQuery = db
      .collection("transactions")
      .where("userId", "==", userId)
      .orderBy("timestamp", "desc")
      .limit(limit);

    // Filtros opcionais
    if (startupId) {
      transactionsQuery = transactionsQuery.where("startupId", "==", startupId);
    }
    if (transactionType) {
      transactionsQuery = transactionsQuery.where("type", "==", transactionType);
    }

    // Aplica offset se necessário
    if (offset > 0) {
      const offsetSnapshot = await db
        .collection("transactions")
        .where("userId", "==", userId)
        .orderBy("timestamp", "desc")
        .limit(offset)
        .get();
      
      if (offsetSnapshot.docs.length > 0) {
        const lastDoc = offsetSnapshot.docs[offsetSnapshot.docs.length - 1];
        transactionsQuery = transactionsQuery.startAfter(lastDoc);
      }
    }

    const transactionsSnapshot = await transactionsQuery.get();
    
    // Busca informações das startups para enriquecer os dados
    const startupIds = [...new Set(transactionsSnapshot.docs.map(doc => doc.data().startupId))];
    const startupsData = new Map();
    
    if (startupIds.length > 0) {
      const startupsSnapshot = await db
        .collection("startups")
        .where(admin.firestore.FieldPath.documentId(), "in", startupIds)
        .get();
      
      startupsSnapshot.docs.forEach(doc => {
        startupsData.set(doc.id, doc.data());
      });
    }

    // Formata as transações com informações completas
    const transactions = transactionsSnapshot.docs.map(doc => {
      const data = doc.data();
      const startupInfo = startupsData.get(data.startupId) || {};
      
      return {
        id: doc.id,
        userId: data.userId,
        startupId: data.startupId,
        startupName: startupInfo.name || 'Startup Desconhecida',
        type: data.type, // 'buy' ou 'sell'
        quantity: data.quantity,
        unitPrice: data.unitPrice,
        totalValue: data.totalValue,
        timestamp: data.timestamp,
        status: data.status,
        // Formatações para exibição
        formattedDate: new Date(data.timestamp.toDate()).toLocaleDateString('pt-BR'),
        formattedTime: new Date(data.timestamp.toDate()).toLocaleTimeString('pt-BR'),
        formattedTotalValue: `R$ ${data.totalValue.toFixed(2)}`,
        formattedUnitPrice: `R$ ${data.unitPrice.toFixed(2)}`,
        typeLabel: data.type === 'buy' ? 'Compra' : 'Venda',
        typeColor: data.type === 'buy' ? '#4CAF50' : '#F44336'
      };
    });

    // Estatísticas do usuário
    const walletSnapshot = await db.collection("wallets").doc(userId).get();
    const walletData = walletSnapshot.exists ? walletSnapshot.data() : {};
    const portfolio = walletData.portfolio || {};

    // Calcula estatísticas
    const buyTransactions = transactions.filter(t => t.type === 'buy');
    const sellTransactions = transactions.filter(t => t.type === 'sell');
    
    const totalInvested = buyTransactions.reduce((sum, t) => sum + t.totalValue, 0);
    const totalReceived = sellTransactions.reduce((sum, t) => sum + t.totalValue, 0);
    const totalVolume = transactions.reduce((sum, t) => sum + t.quantity, 0);

    return {
      status: "success",
      transactions: transactions,
      statistics: {
        totalTransactions: transactions.length,
        buyTransactions: buyTransactions.length,
        sellTransactions: sellTransactions.length,
        totalInvested: totalInvested,
        totalReceived: totalReceived,
        totalVolume: totalVolume,
        currentBalance: walletData.balance || 0,
        portfolioValue: Object.keys(portfolio).length,
        portfolio: portfolio
      },
      hasMore: transactions.length === limit
    };

  } catch (error: any) {
    throw new functions.https.HttpsError("failed-precondition", error.message);
  }
});

// Função para buscar histórico de valorização de uma startup
export const getValuationHistory = functions.https.onCall(async (request) => {
  if (!request.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Log in necessário.");
  }

  const { startupId, period = 'daily' } = request.data;
  const db = admin.firestore();

  try {
    const now = new Date();
    let startDate: Date;
    let groupBy: string;

    switch (period) {
      case 'daily':
        startDate = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000); // 30 dias
        groupBy = 'day';
        break;
      case 'weekly':
        startDate = new Date(now.getTime() - 12 * 7 * 24 * 60 * 60 * 1000); // 12 semanas
        groupBy = 'week';
        break;
      case 'monthly':
        startDate = new Date(now.getTime() - 12 * 30 * 24 * 60 * 60 * 1000); // 12 meses
        groupBy = 'month';
        break;
      case '6months':
        startDate = new Date(now.getTime() - 6 * 30 * 24 * 60 * 60 * 1000); // 6 meses
        groupBy = 'month';
        break;
      case 'ytd':
        startDate = new Date(now.getFullYear(), 0, 1); // Início do ano
        groupBy = 'month';
        break;
      default:
        startDate = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);
        groupBy = 'day';
    }

    // Busca histórico de preços
    const priceHistorySnapshot = await db
      .collection("startups")
      .doc(startupId)
      .collection("priceHistory")
      .where("date", ">=", startDate.toISOString().split('T')[0])
      .orderBy("date", "asc")
      .get();

    // Busca transações para complementar dados
    const transactionsSnapshot = await db
      .collection("transactions")
      .where("startupId", "==", startupId)
      .where("timestamp", ">=", startDate)
      .orderBy("timestamp", "asc")
      .get();

    // Processa dados para o gráfico
    const priceData = priceHistorySnapshot.docs.map(doc => {
      const data = doc.data();
      return {
        date: data.date,
        openPrice: data.openPrice,
        closePrice: data.closePrice,
        highPrice: data.highPrice,
        lowPrice: data.lowPrice,
        volume: data.volume,
        trades: data.trades
      };
    });

    // Agrupa dados por período
    const groupedData = groupDataByPeriod(priceData, groupBy);
    
    // Calcula estatísticas
    const currentPrice = priceData.length > 0 ? priceData[priceData.length - 1].closePrice : 0;
    const startPrice = priceData.length > 0 ? priceData[0].openPrice : 0;
    const priceChange = currentPrice - startPrice;
    const priceChangePercent = startPrice > 0 ? (priceChange / startPrice) * 100 : 0;

    // Volatilidade
    const volatility = calculateVolatilityFromData(priceData);

    return {
      status: "success",
      period: period,
      data: groupedData,
      statistics: {
        currentPrice: currentPrice,
        startPrice: startPrice,
        priceChange: priceChange,
        priceChangePercent: priceChangePercent,
        volatility: volatility,
        totalVolume: transactionsSnapshot.docs.reduce((sum, doc) => sum + doc.data().quantity, 0),
        totalTrades: transactionsSnapshot.docs.length
      }
    };

  } catch (error: any) {
    throw new functions.https.HttpsError("failed-precondition", error.message);
  }
});

// Função auxiliar para agrupar dados por período
function groupDataByPeriod(data: any[], groupBy: string) {
  const grouped = new Map();

  data.forEach(item => {
    let key: string;
    const date = new Date(item.date);

    switch (groupBy) {
      case 'day':
        key = item.date;
        break;
      case 'week':
        const weekStart = new Date(date);
        weekStart.setDate(date.getDate() - date.getDay());
        key = weekStart.toISOString().split('T')[0];
        break;
      case 'month':
        key = `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}`;
        break;
      default:
        key = item.date;
    }

    if (!grouped.has(key)) {
      grouped.set(key, {
        period: key,
        openPrice: item.openPrice,
        closePrice: item.closePrice,
        highPrice: item.highPrice,
        lowPrice: item.lowPrice,
        volume: item.volume,
        trades: item.trades
      });
    } else {
      const existing = grouped.get(key);
      existing.closePrice = item.closePrice;
      existing.highPrice = Math.max(existing.highPrice, item.highPrice);
      existing.lowPrice = Math.min(existing.lowPrice, item.lowPrice);
      existing.volume += item.volume;
      existing.trades += item.trades;
    }
  });

  return Array.from(grouped.values());
}

// Função auxiliar para calcular volatilidade
function calculateVolatilityFromData(data: any[]): number {
  if (data.length < 2) return 0;

  const returns = [];
  for (let i = 1; i < data.length; i++) {
    const returnRate = (data[i].closePrice - data[i-1].closePrice) / data[i-1].closePrice;
    returns.push(returnRate);
  }

  const mean = returns.reduce((sum, r) => sum + r, 0) / returns.length;
  const variance = returns.reduce((sum, r) => sum + Math.pow(r - mean, 2), 0) / returns.length;
  return Math.sqrt(variance) * 100; // Em percentagem
}
