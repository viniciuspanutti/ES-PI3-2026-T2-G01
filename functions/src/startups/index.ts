// Vinícius Panutti Salgado - 25007329
// ── startups/index.ts — Barrel Export do módulo Startups ─────────────
// Re-exporta todas as Cloud Functions do módulo de startups.
//
// Funções exportadas:
//   • createStartupQuestion — cria pergunta pública/privada numa startup
//   • getStartupDetails    — busca detalhes completos + perguntas + acesso
//   • listStartups         — lista startups com filtros (stage, search)
//   • seedStartupCatalog   — popula o Firestore com dados demo (5 startups)
// ──────────────────────────────────────────────────────────────────────
export {createStartupQuestion} from "./handlers/createStartupQuestion";
export {getStartupDetails} from "./handlers/getStartupDetails";
export {listStartups} from "./handlers/listStartups";
export {seedStartupCatalog} from "./handlers/seedStartupCatalog";
