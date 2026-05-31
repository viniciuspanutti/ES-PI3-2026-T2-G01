// Tom Bean
// importa as funções do Firebase
import * as functions from "firebase-functions";
// importa SDK admin do Firebase para acessar Firestore
import * as admin from "firebase-admin";

// Handler callable para buscar o saldo da carteira do usuário
export const buscarSaldo = functions.https.onCall(async (request: any) => {
  // obtém o uid do usuário autenticado na requisição
  const uid = request.auth.uid;

  try {
    // referência ao documento `users/{uid}/carteira/saldo`
    const carteiraRef = admin.firestore()
      .collection("users")
      .doc(uid)
      .collection("carteira")
      .doc("saldo");

    // busca o documento
    const carteira = await carteiraRef.get();

    // se não existe, retorna falha
    if (!carteira.exists) {
      return { success: false, message: "Carteira não encontrada." };
    }

    // retorna o saldo (ou 0 caso indefinido)
    return {
      success: true,
      saldo: carteira.data()?.saldo ?? 0,
    };

  } catch (error: any) {
    // em caso de erro genérico, retorna mensagem de erro
    return { success: false, message: "Erro ao buscar saldo." };
  }
});