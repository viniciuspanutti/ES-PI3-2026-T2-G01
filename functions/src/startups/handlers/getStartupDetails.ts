// Vinícius Panutti Salgado - 25007329
// ── getStartupDetails.ts ───────────────────────────────────────────────
// Cloud Function — Busca detalhes completos de uma startup específica.
//
// Retorna:
//   • Todos os campos do documento da startup
//   • Perguntas públicas da subcoleção questions (ordenadas por data)
//   • Flags de acesso do utilizador (isInvestor, canTradeTokens, etc.)
//
// As flags de acesso são usadas pelo Flutter para habilitar/desabilitar
// botões e funcionalidades na tela de detalhes (ex: chat privado,
// botão de investir, enviar perguntas privadas).
// ──────────────────────────────────────────────────────────────────────

import {HttpsError, onCall} from "firebase-functions/https";
import {requireAuthenticatedUser} from "../shared/auth";
import {normalizeString} from "../shared/validation";
import {
  getStartupById,
  listPublicQuestions,
  userIsInvestor,
} from "../repositories/startupRepository";

export const getStartupDetails = onCall(async (request) => {
  // Guard clause de autenticação
  requireAuthenticatedUser(request);
  // Sanitiza o ID da startup recebido do Flutter
  const startupId = normalizeString(request.data?.id);
  // Extrai dados do utilizador autenticado para verificar acesso
  const user = requireAuthenticatedUser(request);

  if (!startupId) {
    throw new HttpsError(
      "invalid-argument",
      "Informe o parametro id da startup."
    );
  }

  // Busca o documento completo da startup no Firestore
  const startup = await getStartupById(startupId);

  if (!startup) {
    throw new HttpsError("not-found", "Startup nao encontrada.");
  }

  // Verifica se o utilizador é investidor desta startup
  // (possui tokens registrados na subcoleção investors)
  const isInvestor = await userIsInvestor(startupId, user.uid);
  // Busca perguntas públicas da startup (ordenadas por data descendente)
  const questions = await listPublicQuestions(startupId);

  // Retorna o payload completo para o Flutter
  return {
    data: {
      id: startupId,
      // Spread dos campos da startup (name, stage, description, etc.)
      ...startup,
      // Converte Timestamps do Firestore para ISO strings (JSON-safe)
      createdAt: startup.createdAt?.toDate().toISOString() ?? null,
      updatedAt: startup.updatedAt?.toDate().toISOString() ?? null,
      // Lista de perguntas públicas com respostas
      publicQuestions: questions,
      // ── Flags de acesso ────────────────────────────────────────────
      // Estas flags controlam a UI no Flutter:
      //   isInvestor → habilita chat privado e perguntas privadas
      //   canTradeTokens → habilita botões de compra/venda
      //   canSendPrivateQuestions → habilita opção de pergunta privada
      access: {
        isInvestor,
        canTradeTokens: isInvestor,
        canSendPrivateQuestions: isInvestor,
      },
    },
  };
});

