// Vinícius Panutti Salgado - 25007329
// ── startups/shared/constants.ts ───────────────────────────────────────
// Constantes de domínio para validação de entrada nas Cloud Functions.
//
// allowedStages — estágios de maturidade aceitos para uma startup:
//   "nova"         → startup recém-cadastrada, em fase de captação
//   "em_operacao"  → startup ativa com produto no mercado
//   "em_expansao"  → startup crescendo e buscando escalar
//
// allowedVisibilities — tipos de visibilidade de perguntas:
//   "publica"  → visível para todos os utilizadores
//   "privada"  → visível apenas para investidores e fundadores
//
// Estas arrays são usadas como whitelist nos handlers listStartups
// e createStartupQuestion para validar os parâmetros recebidos.
// ──────────────────────────────────────────────────────────────────────

import {QuestionVisibility, StartupStage} from "../types";

// Estágios válidos para filtro na listagem de startups
export const allowedStages: StartupStage[] = [
  "nova",
  "em_operacao",
  "em_expansao",
];

// Visibilidades válidas para perguntas (publica ou privada)
export const allowedVisibilities: QuestionVisibility[] = [
  "publica",
  "privada",
];
