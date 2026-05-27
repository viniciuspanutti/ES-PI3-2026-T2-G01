import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const buscarSaldo = functions.https.onCall(async (request: any) => {
  const uid = request.auth.uid;

  try {
    const carteiraRef = admin.firestore()
      .collection("users")
      .doc(uid)
      .collection("carteira")
      .doc("saldo");

    const carteira = await carteiraRef.get();

    if (!carteira.exists) {
      return { success: false, message: "Carteira não encontrada." };
    }

    return {
      success: true,
      saldo: carteira.data()?.saldo ?? 0,
    };

  } catch (error: any) {
    return { message: "Erro ao buscar saldo." };
  }
});