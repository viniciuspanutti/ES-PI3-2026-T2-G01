// Vinícius Panutti Salgado - 25007329
// ── createStartupQuestion.ts ───────────────────────────────────────────
// Cloud Function — Cria uma pergunta (pública ou privada) numa startup.
//
// Regras de Negócio:
//   1. O utilizador DEVE estar autenticado
//   2. A startup referenciada DEVE existir no Firestore
//   3. Se visibility == "privada", o utilizador DEVE ser investidor
//      (verificado via subcoleção investors da startup)
//   4. A pergunta é armazenada na subcoleção startups/{id}/questions
//
// Parâmetros (request.data):
//   • startupId  — ID do documento da startup
//   • text       — texto da pergunta
//   • visibility — "publica" (default) ou "privada"
// ──────────────────────────────────────────────────────────────────────

// FieldValue.serverTimestamp() para marcar o momento da criação no servidor
import {FieldValue} from "firebase-admin/firestore";
// onCall para definir Cloud Function, HttpsError para erros tipados
import {HttpsError, onCall} from "firebase-functions/https";
// Logger estruturado do Firebase para logs no Cloud Console
import * as logger from "firebase-functions/logger";
// Constantes de validação (visibilidades permitidas)
import {allowedVisibilities} from "../shared/constants";
// Guard de autenticação — lança erro se não autenticado
import {requireAuthenticatedUser} from "../shared/auth";
// Sanitização de strings de entrada
import {normalizeString} from "../shared/validation";
// Funções de acesso a dados (repository pattern)
import {
  createQuestion,
  getStartupById,
  userIsInvestor,
} from "../repositories/startupRepository";
// Tipos TypeScript para type-safety
import {QuestionVisibility, StartupQuestionDocument} from "../types";

// ── Handler principal ────────────────────────────────────────────────
export const createStartupQuestion = onCall(async (request) => {
  // Guard clause: garante autenticação e extrai uid/email
  const user = requireAuthenticatedUser(request);

  // Sanitiza e valida os parâmetros de entrada
  const startupId = normalizeString(request.data?.startupId);
  const text = normalizeString(request.data?.text);
  // Default "publica" se visibility não for fornecida
  const visibility = normalizeString(request.data?.visibility) ?? "publica";

  // Valida que startupId e text foram fornecidos (não-vazios)
  if (!startupId || !text) {
    throw new HttpsError("invalid-argument", "Informe startupId e text.");
  }

  // Valida que a visibility é uma das permitidas (publica/privada)
  if (!allowedVisibilities.includes(visibility as QuestionVisibility)) {
    throw new HttpsError(
      "invalid-argument",
      "Visibility invalida. Use publica ou privada."
    );
  }

  // Verifica se a startup existe no Firestore
  const startup = await getStartupById(startupId);

  if (!startup) {
    throw new HttpsError("not-found", "Startup nao encontrada.");
  }

  // ── Regra de acesso para perguntas privadas ────────────────────────
  // Apenas investidores (que possuem tokens) podem enviar perguntas
  // privadas aos fundadores. Isto cria um canal exclusivo de comunicação.
  if (visibility === "privada") {
    const isInvestor = await userIsInvestor(startupId, user.uid);
    if (!isInvestor) {
      throw new HttpsError(
        "permission-denied",
        "Somente investidores desta startup podem enviar perguntas privadas."
      );
    }
  }

  // Monta o documento da pergunta com timestamp do servidor
  const question: StartupQuestionDocument = {
    authorUid: user.uid,
    authorEmail: user.email,
    text,
    visibility: visibility as QuestionVisibility,
    // serverTimestamp() garante que o timestamp é definido pelo servidor
    // e não pelo dispositivo do cliente (previne manipulação)
    createdAt: FieldValue.serverTimestamp(),
  };

  // Persiste a pergunta na subcoleção questions da startup
  const questionId = await createQuestion(startupId, question);

  // Log estruturado para monitoramento no Firebase Console
  logger.info("Pergunta criada para startup.", {
    startupId,
    questionId,
    visibility,
  });

  // Retorna o ID da pergunta criada para o Flutter
  return {
    data: {
      id: questionId,
      startupId,
      visibility,
    },
  };
});
