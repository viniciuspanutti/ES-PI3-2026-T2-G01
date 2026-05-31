// Tom Bean
// importa funções Firebase
import * as functions from "firebase-functions";
// importa admin SDK do Firebase
import * as admin from "firebase-admin";

// Handler callable para efetuar saque, decrementando o saldo
export const sacar = functions.https.onCall(async (request: any) => {
  // uid do usuário autenticado
  const uid = request.auth.uid;
  // valor a sacar vindo na requisição
  const { valor } = request.data;

  // valida valor
  if (!valor || valor <= 0) {
    return { success: false, message: "Valor inválido." };
  }

  try {
    // referência ao documento de saldo
    const carteiraRef = admin.firestore()
      .collection("users")
      .doc(uid)
      .collection("carteira")
      .doc("saldo");

    // busca o documento para obter saldo atual
    const carteira = await carteiraRef.get();
    const saldoAtual = carteira.data()?.saldo ?? 0;

    // verifica saldo suficiente
    if (saldoAtual < valor) {
      return { success: false, message: "Saldo insuficiente." };
    }

    // decrementa o saldo de forma atômica
    await carteiraRef.set({
      saldo: admin.firestore.FieldValue.increment(-valor),
    }, { merge: true });

    // retorna sucesso
    return { success: true, message: "Saque realizado com sucesso." };

  } catch (error: any) {
    // retorna erro em caso de exceção
    return { success: false, message: "Erro ao realizar saque." };
  }
});