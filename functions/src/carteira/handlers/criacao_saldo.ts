// Tom Bean
// importa funções do Firebase
import * as functions from "firebase-functions";
// importa admin SDK para Firestore
import * as admin from "firebase-admin";

// Handler callable que cria o documento de saldo da carteira do usuário
export const criarCarteira = functions.https.onCall(async (request: any) => {
  // obtém uid do usuário autenticado
  const uid = request.auth.uid;

  try {
    // referência ao documento saldo na subcoleção carteira
    const carteiraRef = admin.firestore()
      .collection("users")
      .doc(uid)
      .collection("carteira")
      .doc("saldo");

    // verifica se já existe
    const carteira = await carteiraRef.get();

    if (carteira.exists) {
      // se já existir, informa ao cliente
      return { success: true, message: "Carteira já existe." };
    }

    // cria documento com saldo inicial 0 e timestamp
    await carteiraRef.set({
      saldo: 0,
      criadoEm: admin.firestore.FieldValue.serverTimestamp(),
    });

    // retorna sucesso
    return { success: true, message: "Carteira criada com sucesso." };

  } catch (error: any) {
    // retorna erro em caso de exceção
    return { success: false, message: "Erro ao criar carteira." };
  }
});