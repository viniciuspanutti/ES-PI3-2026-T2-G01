/**Vinícius
 * Explicação do código -> Sistema de variação de valor dos tokens (diária/semanal/mensal)
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

interface PriceHistory {
  date: string; // YYYY-MM-DD
  openPrice: number;
  closePrice: number;
  highPrice: number;
  lowPrice: number;
  volume: number;
  trades: number;
}

interface ValuationMetrics {
  dailyChange: number;
  dailyChangePercent: number;
  weeklyChange: number;
  weeklyChangePercent: number;
  monthlyChange: number;
  monthlyChangePercent: number;
  volatility: number;
  trend: 'up' | 'down' | 'stable';
}

export const updateTokenValuation = functions.https.onCall(async (request) => {
  if (!request.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Log in necessário.");
  }

  const { startupId } = request.data;
  const db = admin.firestore();

  try {
    await db.runTransaction(async (t) => {
      const startupRef = db.collection("startups").doc(startupId);
      const startupSnap = await t.get(startupRef);
      
      if (!startupSnap.exists) {
        throw new Error("Startup não encontrada.");
      }

      const startupData = startupSnap.data();
      const currentPrice = startupData?.currentTokenPrice || 0;
      const now = new Date();
      const today = now.toISOString().split('T')[0]; // YYYY-MM-DD

      // Busca histórico de preços
      const priceHistoryRef = db
        .collection("startups")
        .doc(startupId)
        .collection("priceHistory")
        .doc(today);

      const priceHistorySnap = await t.get(priceHistoryRef);
      let todayHistory: PriceHistory;

      if (priceHistorySnap.exists) {
        // Atualiza histórico do dia
        todayHistory = priceHistorySnap.data() as PriceHistory;
        todayHistory.closePrice = currentPrice;
        todayHistory.highPrice = Math.max(todayHistory.highPrice, currentPrice);
        todayHistory.lowPrice = Math.min(todayHistory.lowPrice, currentPrice);
        todayHistory.volume += startupData?.lastTradeVolume || 0;
        todayHistory.trades += 1;
      } else {
        // Cria novo histórico do dia
        todayHistory = {
          date: today,
          openPrice: currentPrice,
          closePrice: currentPrice,
          highPrice: currentPrice,
          lowPrice: currentPrice,
          volume: startupData?.lastTradeVolume || 0,
          trades: 1
        };
      }

      // Salva histórico do dia
      t.set(priceHistoryRef, todayHistory);

      // Calcula métricas de valorização
      const metrics = await calculateValuationMetrics(t, startupId, currentPrice, today);

      // Atualiza startup com as métricas
      t.update(startupRef, {
        ...metrics,
        lastValuationUpdate: now,
        priceHistory: {
          daily: todayHistory,
          weekly: metrics.weeklyChange,
          monthly: metrics.monthlyChange
        }
      });
    });

    return { 
      status: "success",
      message: "Valorização atualizada com sucesso"
    };

  } catch (error: any) {
    throw new functions.https.HttpsError("failed-precondition", error.message);
  }
});

async function calculateValuationMetrics(
  t: any, 
  startupId: string, 
  currentPrice: number, 
  today: string
): Promise<ValuationMetrics> {
  const db = admin.firestore();
  
  // Busca históricos para cálculos
  const yesterday = new Date(today);
  yesterday.setDate(yesterday.getDate() - 1);
  const yesterdayStr = yesterday.toISOString().split('T')[0];

  const lastWeek = new Date(today);
  lastWeek.setDate(lastWeek.getDate() - 7);
  const lastWeekStr = lastWeek.toISOString().split('T')[0];

  const lastMonth = new Date(today);
  lastMonth.setMonth(lastMonth.getMonth() - 1);
  const lastMonthStr = lastMonth.toISOString().split('T')[0];

  // Busca preços históricos
  const [
    yesterdayHistory,
    lastWeekHistory,
    lastMonthHistory
  ] = await Promise.all([
    t.get(db.collection("startups").doc(startupId).collection("priceHistory").doc(yesterdayStr)),
    t.get(db.collection("startups").doc(startupId).collection("priceHistory").doc(lastWeekStr)),
    t.get(db.collection("startups").doc(startupId).collection("priceHistory").doc(lastMonthStr))
  ]);

  // Variação diária
  let dailyChange = 0;
  let dailyChangePercent = 0;
  if (yesterdayHistory.exists) {
    const yesterdayData = yesterdayHistory.data() as PriceHistory;
    dailyChange = currentPrice - yesterdayData.closePrice;
    dailyChangePercent = (dailyChange / yesterdayData.closePrice) * 100;
  }

  // Variação semanal
  let weeklyChange = 0;
  let weeklyChangePercent = 0;
  if (lastWeekHistory.exists) {
    const lastWeekData = lastWeekHistory.data() as PriceHistory;
    weeklyChange = currentPrice - lastWeekData.closePrice;
    weeklyChangePercent = (weeklyChange / lastWeekData.closePrice) * 100;
  }

  // Variação mensal
  let monthlyChange = 0;
  let monthlyChangePercent = 0;
  if (lastMonthHistory.exists) {
    const lastMonthData = lastMonthHistory.data() as PriceHistory;
    monthlyChange = currentPrice - lastMonthData.closePrice;
    monthlyChangePercent = (monthlyChange / lastMonthData.closePrice) * 100;
  }

  // Calcula volatilidade (últimos 7 dias)
  const volatility = await calculateVolatility(t, startupId, today);

  // Determina tendência
  let trend: 'up' | 'down' | 'stable' = 'stable';
  if (Math.abs(dailyChangePercent) > 0.5) {
    trend = dailyChangePercent > 0 ? 'up' : 'down';
  }

  return {
    dailyChange,
    dailyChangePercent,
    weeklyChange,
    weeklyChangePercent,
    monthlyChange,
    monthlyChangePercent,
    volatility,
    trend
  };
}

async function calculateVolatility(t: any, startupId: string, today: string): Promise<number> {
  const db = admin.firestore();
  
  // Busca últimos 7 dias de preços
  const sevenDaysAgo = new Date(today);
  sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);
  const sevenDaysAgoStr = sevenDaysAgo.toISOString().split('T')[0];

  const priceHistoryQuery = db
    .collection("startups")
    .doc(startupId)
    .collection("priceHistory")
    .where("date", ">=", sevenDaysAgoStr)
    .where("date", "<=", today)
    .orderBy("date", "asc");

  const priceHistorySnap = await t.get(priceHistoryQuery);
  const prices = priceHistorySnap.docs.map(doc => (doc.data() as PriceHistory).closePrice);

  if (prices.length < 2) return 0;

  // Calcula volatilidade como desvio padrão dos retornos diários
  const returns = [];
  for (let i = 1; i < prices.length; i++) {
    const returnRate = (prices[i] - prices[i-1]) / prices[i-1];
    returns.push(returnRate);
  }

  const mean = returns.reduce((sum, r) => sum + r, 0) / returns.length;
  const variance = returns.reduce((sum, r) => sum + Math.pow(r - mean, 2), 0) / returns.length;
  const volatility = Math.sqrt(variance) * 100; // Em percentagem

  return volatility;
}

// Função agendada para atualizar valorizações diariamente
export const scheduledValuationUpdate = functions.pubsub
  .schedule('0 0 * * *') // Todos os dias à meia-noite
  .timeZone('America/Sao_Paulo')
  .onRun(async (context) => {
    const db = admin.firestore();
    
    try {
      // Busca todas as startups
      const startupsSnap = await db.collection("startups").get();
      
      for (const startupDoc of startupsSnap.docs) {
        const startupId = startupDoc.id;
        
        try {
          // Atualiza valorização para cada startup
          await updateTokenValuationInternal(db, startupId);
          console.log(`Valorização atualizada para startup: ${startupId}`);
        } catch (error) {
          console.error(`Erro ao atualizar valorização da startup ${startupId}:`, error);
        }
      }
      
      console.log('Atualização de valorizações concluída com sucesso');
      return null;
    } catch (error) {
      console.error('Erro na atualização agendada de valorizações:', error);
      throw error;
    }
  });

// Função interna sem autenticação para uso agendado
async function updateTokenValuationInternal(db: admin.firestore.Firestore, startupId: string) {
  await db.runTransaction(async (t) => {
    const startupRef = db.collection("startups").doc(startupId);
    const startupSnap = await t.get(startupRef);
    
    if (!startupSnap.exists) return;

    const startupData = startupSnap.data();
    const currentPrice = startupData?.currentTokenPrice || 0;
    const now = new Date();
    const today = now.toISOString().split('T')[0];

    // Similar à função principal, mas sem autenticação
    const priceHistoryRef = db
      .collection("startups")
      .doc(startupId)
      .collection("priceHistory")
      .doc(today);

    const priceHistorySnap = await t.get(priceHistoryRef);
    let todayHistory: PriceHistory;

    if (priceHistorySnap.exists) {
      todayHistory = priceHistorySnap.data() as PriceHistory;
      todayHistory.closePrice = currentPrice;
      todayHistory.highPrice = Math.max(todayHistory.highPrice, currentPrice);
      todayHistory.lowPrice = Math.min(todayHistory.lowPrice, currentPrice);
    } else {
      todayHistory = {
        date: today,
        openPrice: currentPrice,
        closePrice: currentPrice,
        highPrice: currentPrice,
        lowPrice: currentPrice,
        volume: 0,
        trades: 0
      };
    }

    t.set(priceHistoryRef, todayHistory);

    const metrics = await calculateValuationMetrics(t, startupId, currentPrice, today);
    t.update(startupRef, {
      ...metrics,
      lastValuationUpdate: now
    });
  });
}
