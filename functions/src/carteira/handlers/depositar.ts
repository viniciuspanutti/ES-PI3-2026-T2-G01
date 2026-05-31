// Tom Bean
// importa as funções do Firebase
import * as functions from "firebase-functions";
// importa SDK admin para manipular Firestore
import * as admin from "firebase-admin";

// Handler callable para realizar depósito incrementando o saldo
export const depositar = functions.https.onCall(async (request: any) => {
  // obtém uid do usuário autenticado
  const uid = request.auth.uid;
  // extrai valor enviado na requisição
  const { valor } = request.data;

  // valida valor positivo
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

    // incrementa o saldo com FieldValue.increment para operação atômica
    await carteiraRef.set({
      saldo: admin.firestore.FieldValue.increment(valor),
    }, { merge: true });

    // retorna sucesso
    return { success: true, message: "Depósito realizado com sucesso." };

  } catch (error: any) {
    // retorna erro caso ocorra exceção
    return { success: false, message: "Erro ao realizar depósito." };
  }
});