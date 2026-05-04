import * as functions from "firebase-functions"; 
 import * as admin from "firebase-admin"; 
 
 export const sellTokens = functions.https.onCall(async (request) => { 
   if (!request.auth) { 
     throw new functions.https.HttpsError("unauthenticated", "Log in necessário."); 
   } 
 
   const userId = request.auth.uid; 
   const { startupId, tokenQuantity } = request.data; 
   const db = admin.firestore(); 
 
   try { 
     await db.runTransaction(async (t) => { 
       const startupRef = db.collection("startups").doc(startupId); 
       const walletRef = db.collection("wallets").doc(userId); 
 
       const startupSnap = await t.get(startupRef); 
       if (!startupSnap.exists) throw new Error("Startup não encontrada."); 
 
       const price = startupSnap.data()?.currentTokenPrice; 
       const totalRevenue = price * tokenQuantity; 
 
       const walletSnap = await t.get(walletRef); 
       if (!walletSnap.exists) throw new Error("Carteira não encontrada."); 
 
       const currentTokens = walletSnap.data()?.portfolio?.[startupId] || 0; 
       if (currentTokens < tokenQuantity) { 
         throw new Error("Tokens insuficientes para venda."); 
       } 
 
       const currentBalance = walletSnap.data()?.balance || 0; 
 
       t.set(walletRef, { 
         balance: currentBalance + totalRevenue, 
         portfolio: { [startupId]: currentTokens - tokenQuantity } 
       }, { merge: true }); 
 
       // Registra a transação 
       const transactionRef = db.collection("transactions").doc(); 
       t.set(transactionRef, { 
         userId, 
         startupId, 
         tokenQuantity, 
         unitPrice: price, 
         totalRevenue, 
         kind: "sell", 
         status: "Completed", 
         createdAt: admin.firestore.FieldValue.serverTimestamp(), 
         title: "Venda de Token", 
         subtitle: `Startup: ${startupSnap.data()?.name || startupId}` 
       }); 
     }); 
     return { status: "success" }; 
   } catch (error: any) { 
     throw new functions.https.HttpsError("failed-precondition", error.message); 
   } 
 });
