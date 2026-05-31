// Vinícius Panutti Salgado - 25007329
// ── seedStartupCatalog.ts ──────────────────────────────────────────────
// Cloud Function — Popula o Firestore com 5 startups demo e seus pools
// de exchange com histórico de preços simulado de 365 dias.
//
// Uso:
//   Esta function é chamada uma ÚNICA vez para inicializar o catálogo.
//   Pode ser invocada via emulador (sem restrição) ou em produção
//   (com seedKey validada contra a env var SEED_STARTUP_CATALOG_KEY).
//
// Segurança:
//   Fora do emulador, requer uma chave secreta (seedKey) que DEVE
//   corresponder à variável de ambiente SEED_STARTUP_CATALOG_KEY.
//   Isto previne que qualquer utilizador sobrescreva o catálogo.
//
// Dados criados:
//   1. Coleção startups/{id} — 5 documentos com dados completos
//   2. Coleção exchange/{id} — pool de liquidez para cada startup
//   3. Subcoleção exchange/{id}/historicoPrecos — 365 docs por startup
// ──────────────────────────────────────────────────────────────────────

import { HttpsError, onCall } from "firebase-functions/https";
import { seedDemoStartups } from "../repositories/startupRepository";
import { normalizeString } from "../shared/validation";

export const seedStartupCatalog = onCall(async (request) => {
  // Sanitiza a chave secreta recebida do caller
  const seedKey = normalizeString(request.data?.seedKey);

  // ── Proteção de Segurança ──────────────────────────────────────────
  // No emulador (FUNCTIONS_EMULATOR=true), permite execução livre.
  // Em produção, exige que a seedKey corresponda à env var configurada.
  if (!process.env.FUNCTIONS_EMULATOR) {
    if (!process.env.SEED_STARTUP_CATALOG_KEY ||
      seedKey !== process.env.SEED_STARTUP_CATALOG_KEY) {
      throw new HttpsError(
        "permission-denied",
        "Seed bloqueado fora do emulator sem seedKey valido."
      );
    }
  }

  // Executa o seed via batch write (todas as escritas são atômicas)
  const startupIds = await seedDemoStartups();

  // Retorna os IDs das startups criadas para confirmação
  return {
    data: {
      count: startupIds.length,
      ids: startupIds,
    },
  };
});
