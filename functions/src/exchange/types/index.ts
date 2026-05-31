/** Vinícius Panutti Salgado - 25007329
 * Explicação do código ->
 *
 * ── exchange/types/index.ts — Tipos TypeScript do módulo Exchange ────
 * Define a interface Wallet que representa a estrutura de dados da
 * carteira digital do utilizador no contexto da exchange.
 *
 * Nota: No estado atual do MVP, a carteira real no Firestore usa
 * subcoleções separadas (carteira/saldo e investimentos/{startupId}),
 * mas esta interface documenta o modelo conceitual original.
 */

// ── Wallet — Modelo conceitual da carteira do investidor ─────────────
// Representa o saldo em reais e o portfólio de toykens por startup.
export interface Wallet {
  balance: number; // Saldo em Reais (ex: 150.00)
  portfolio: {
    [startupId: string]: number; // Ex: { "id_da_healthbit": 50 } (tem 50 tokens HLTH)
  };
}