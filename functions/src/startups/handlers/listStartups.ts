// Vinícius Panutti Salgado - 25007329
// ── listStartups.ts ────────────────────────────────────────────────────
// Cloud Function — Lista startups do catálogo com filtros opcionais.
//
// Filtros suportados (request.data):
//   • stage  — filtra por estágio (nova, em_operacao, em_expansao)
//   • search — busca textual no nome, descrição, estágio e tags
//
// Pipeline de processamento:
//   1. Busca TODOS os documentos da coleção startups (limit 100)
//   2. Aplica filtro de estágio (se fornecido)
//   3. Aplica busca textual case-insensitive (se fornecida)
//   4. Ordena alfabeticamente por nome (locale pt-BR)
//   5. Retorna array com count, filtros aplicados e dados
//
// Nota: O filtro é aplicado em memória (client-side do server) e não
// via query Firestore, pois o Firestore não suporta LIKE/CONTAINS.
// Com ~5 startups no MVP, isto não é um problema de performance.
// ──────────────────────────────────────────────────────────────────────

import {HttpsError, onCall} from "firebase-functions/https";
import {allowedStages} from "../shared/constants";
import {requireAuthenticatedUser} from "../shared/auth";
import {normalizeString} from "../shared/validation";
import {listStartupItems} from "../repositories/startupRepository";
import {StartupStage} from "../types";

export const listStartups = onCall(async (request) => {
  // Guard clause de autenticação
  requireAuthenticatedUser(request);

  // Sanitiza parâmetros opcionais de filtro
  const stage = normalizeString(request.data?.stage);
  // Normaliza busca para lowercase pt-BR (busca case-insensitive)
  const search = normalizeString(request.data?.search)
    ?.toLocaleLowerCase("pt-BR");

  // Valida estágio contra a whitelist de valores permitidos
  if (stage && !allowedStages.includes(stage as StartupStage)) {
    throw new HttpsError(
      "invalid-argument",
      "Filtro stage invalido. Use nova, em_operacao ou em_expansao."
    );
  }

  // Pipeline de filtragem e ordenação
  const startups = (await listStartupItems())
    // Filtro 1: estágio (se não fornecido, inclui todas)
    .filter((startup) => !stage || startup.stage == stage)
    // Filtro 2: busca textual — concatena campos pesquisáveis
    // e verifica se o termo de busca está contido na string resultante
    .filter((startup) => {
      if (!search) {
        return true;
      }
      // Junta nome, descrição, estágio e tags num único string pesquisável
      const searchable = [
        startup.name,
        startup.shortDescription,
        startup.stage,
        ...startup.tags,
      ].join(" ").toLocaleLowerCase("pt-BR");

      return searchable.includes(search);
    })
    // Ordena alfabeticamente por nome usando locale pt-BR
    .sort((left, right) => left.name.localeCompare(right.name, "pt-BR"));

  // Retorna com metadados de paginação e filtros aplicados
  return {
    count: startups.length,
    filters: {
      availableStages: allowedStages,    // Estágios disponíveis para o dropdown
      stage: stage ?? null,              // Estágio aplicado (ou null)
      search: search ?? null,            // Termo de busca aplicado (ou null)
    },
    data: startups,                      // Array de StartupListItem
  };
});