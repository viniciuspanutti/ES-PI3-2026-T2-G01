/* Vinícius Panutti Salgado - 25007329

 * Explicação do código ->
 *
 * ── exchange/index.ts — Barrel Export do módulo Exchange ──────────────
 * Ficheiro de barril (barrel file) que re-exporta todas as Cloud
 * Functions do módulo de exchange (compra e venda de tokens).
 *
 * Padrão Barrel Export:
 *   Em vez de importar cada handler individualmente no index.ts raiz,
 *   o barrel file centraliza as exportações do módulo. Isto mantém o
 *   código organizado e permite adicionar novos handlers (ex: swapTokens)
 *   sem alterar o ficheiro raiz.
 *
 * Funções exportadas:
 *   • buyTokens  — compra de tokens via AMM (debita saldo, credita tokens)
 *   • sellTokens — venda de tokens via AMM inverso (credita saldo, devolve tokens)
 */

export { buyTokens } from "./handlers/buyTokens";
export { sellTokens } from "./handlers/sellTokens";