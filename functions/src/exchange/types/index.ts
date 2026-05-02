/**Vinícius
 * Explicação do código ->
 */

export interface Wallet {
  balance: number; // Saldo em Reais (ex: 150.00)
  portfolio: {
    [startupId: string]: number; // Ex: { "id_da_healthbit": 50 } (tem 50 tokens HLTH)
  };
}

export interface Transaction {
  id: string;
  userId: string;
  startupId: string;
  type: 'buy' | 'sell';
  quantity: number;
  unitPrice: number;
  totalValue: number;
  timestamp: Date;
  status: 'completed' | 'pending' | 'cancelled';
}

export interface SellOrder {
  id: string;
  userId: string;
  startupId: string;
  quantity: number;
  desiredPrice: number;
  totalValue: number;
  timestamp: Date;
  status: 'open' | 'matched' | 'cancelled';
  type: 'direct' | 'orderbook';
}