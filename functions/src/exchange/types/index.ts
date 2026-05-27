/**Vinícius
 * Explicação do código ->
 */

export interface Wallet {
  balance: number; // Saldo em Reais (ex: 150.00)
  portfolio: {
    [startupId: string]: number; // Ex: { "id_da_healthbit": 50 } (tem 50 tokens HLTH)
  };
}