import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const criarCarteira = functions.https.onCall(async (request: any) => {
  const uid = request.auth.uid;

  try {
    const carteiraRef = admin.firestore()
      .collection("users")
      .doc(uid)
      .collection("carteira")
      .doc("saldo");

    const carteira = await carteiraRef.get();

    if (carteira.exists) {
      return { success: true, message: "Carteira já existe." };
    }

    await carteiraRef.set({
      saldo: 0,
      criadoEm: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { success: true, message: "Carteira criada com sucesso." };

  } catch (error: any) {
    return { success: false, message: "Erro ao criar carteira." };
  }
});