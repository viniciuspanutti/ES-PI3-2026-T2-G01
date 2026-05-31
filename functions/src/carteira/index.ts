// Vinícius Panutti Salgado - 25007329
// ── carteira/index.ts — Barrel Export do módulo Carteira ─────────────
// Re-exporta todas as Cloud Functions relacionadas à carteira digital.
//
// Funções exportadas:
//   • criarCarteira — inicializa a carteira do utilizador com saldo 0
//                     (chamada pelo Flutter no momento do registro)
//   • buscarSaldo   — retorna o saldo atual da carteira do utilizador
//   • depositar     — adiciona valor ao saldo da carteira
//   • sacar         — retira valor do saldo da carteira
//
// Nota: Todas as funções usam set() com merge: true (padrão upsert)
// para evitar crashes quando o documento da carteira ainda não existe.
// ──────────────────────────────────────────────────────────────────────
export { criarCarteira } from "./handlers/criacao_saldo";
export { buscarSaldo } from "./handlers/buscar_saldo";
export { depositar } from "./handlers/depositar";
export { sacar } from "./handlers/sacar";