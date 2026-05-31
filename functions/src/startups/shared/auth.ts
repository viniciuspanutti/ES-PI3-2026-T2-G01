// Vinícius Panutti Salgado - 25007329
// ── startups/shared/auth.ts ────────────────────────────────────────────
// Módulo utilitário de autenticação para as Cloud Functions de startups.
//
// Exporta a função requireAuthenticatedUser() que é chamada no início
// de TODAS as Cloud Functions do módulo startups para garantir que
// apenas utilizadores autenticados possam acessar os endpoints.
//
// Padrão Guard Clause:
//   Se request.auth for null (chamada não autenticada), a função lança
//   HttpsError("unauthenticated") que é capturado pelo Flutter como
//   FirebaseFunctionsException e exibido ao utilizador.
// ──────────────────────────────────────────────────────────────────────

// CallableRequest contém auth, data e rawRequest da chamada
import {CallableRequest, HttpsError} from "firebase-functions/https";
// Tipo local que representa o subset de dados do user autenticado
import {AuthenticatedUser} from "../types";

// ── requireAuthenticatedUser — Guard de autenticação ─────────────────
// Verifica se o request possui contexto de autenticação válido.
// Se sim, retorna {uid, email} para uso no handler.
// Se não, lança HttpsError que aborta a execução da Cloud Function.
export function requireAuthenticatedUser(
  request: CallableRequest
): AuthenticatedUser {
  // request.auth é populado automaticamente pelo Firebase SDK quando
  // o utilizador está logado no Flutter (token JWT válido)
  if (!request.auth) {
    throw new HttpsError(
      "unauthenticated",
      "Usuario precisa estar autenticado para acessar esta funcao."
    );
  }
  // Retorna apenas os campos necessários (uid + email do token JWT)
  return {
    uid: request.auth.uid,
    email: request.auth.token.email as string | undefined,
  };
}


