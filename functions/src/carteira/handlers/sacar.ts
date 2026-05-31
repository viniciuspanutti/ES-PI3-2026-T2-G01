import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const sacar = functions.https.onCall(async (request: any) => {
  const uid = request.auth.uid;
  const { valor } = request.data;

  if (!valor || valor <= 0) {
    return { success: false, message: "Valor inválido." };
  }

  try {
    const carteiraRef = admin.firestore()
      .collection("users")
      .doc(uid)
      .collection("carteira")
      .doc("saldo");

    const carteira = await carteiraRef.get();
    const saldoAtual = carteira.data()?.saldo ?? 0;

    if (saldoAtual < valor) {
      return { success: false, message: "Saldo insuficiente." };
    }

    await carteiraRef.set({
      saldo: admin.firestore.FieldValue.increment(-valor),
    }, { merge: true });

    return { success: true, message: "Saque realizado com sucesso." };

  } catch (error: any) {
    return { success: false, message: "Erro ao realizar saque." };
  }
});