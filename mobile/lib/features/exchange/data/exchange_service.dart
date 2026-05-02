import 'package:cloud_functions/cloud_functions.dart';

class ExchangeService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<void> buyTokens(String startupId, int tokenQuantity) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('exchange-buyTokens');
      final result = await callable.call(<String, dynamic>{
        'startupId': startupId,
        'tokenQuantity': tokenQuantity,
      });
      
      print('Status da Compra: ${result.data['status']}');
      
    } catch (e) {
      print('Erro ao comprar tokens: $e');
      rethrow; // Repassa o erro para a tela (ex: "Saldo insuficiente")
    }
  }

  Future<void> sellTokens(String startupId, int tokenQuantity, String sellType, double? desiredPrice) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('exchange-sellTokens');
      final result = await callable.call(<String, dynamic>{
        'startupId': startupId,
        'tokenQuantity': tokenQuantity,
        'sellType': sellType, // 'direct' ou 'orderbook'
        if (desiredPrice != null) 'desiredPrice': desiredPrice,
      });
      
      print('Status da Venda: ${result.data['status']}');
      print('Mensagem: ${result.data['message']}');
      
    } catch (e) {
      print('Erro ao vender tokens: $e');
      rethrow; // Repassa o erro para a tela
    }
  }

  Future<Map<String, dynamic>> getOrderBook(String startupId) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('exchange-getOrderBook');
      final result = await callable.call(<String, dynamic>{
        'startupId': startupId,
      });
      
      return result.data;
      
    } catch (e) {
      print('Erro ao buscar livro de ofertas: $e');
      rethrow;
    }
  }

  Future<void> matchOrders(String startupId, int buyQuantity, double maxPrice) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('exchange-matchOrders');
      final result = await callable.call(<String, dynamic>{
        'startupId': startupId,
        'buyQuantity': buyQuantity,
        'maxPrice': maxPrice,
      });
      
      print('Status do Matching: ${result.data['status']}');
      print('Mensagem: ${result.data['message']}');
      
    } catch (e) {
      print('Erro no matching de ordens: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getTransactionHistory({
    int limit = 50,
    int offset = 0,
    String? startupId,
    String? transactionType,
  }) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('exchange-getTransactionHistory');
      final result = await callable.call(<String, dynamic>{
        'limit': limit,
        'offset': offset,
        if (startupId != null) 'startupId': startupId,
        if (transactionType != null) 'transactionType': transactionType,
      });
      
      return result.data;
      
    } catch (e) {
      print('Erro ao buscar histórico de transações: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getValuationHistory({
    required String startupId,
    String period = 'daily',
  }) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('exchange-getValuationHistory');
      final result = await callable.call(<String, dynamic>{
        'startupId': startupId,
        'period': period,
      });
      
      return result.data;
      
    } catch (e) {
      print('Erro ao buscar histórico de valorização: $e');
      rethrow;
    }
  }

  Future<void> addBalance(double amount) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('exchange-addBalance');
      final result = await callable.call(<String, dynamic>{
        'amount': amount,
      });
      
      print('Status do crédito: ${result.data['status']}');
      print('Mensagem: ${result.data['message']}');
      
    } catch (e) {
      print('Erro ao adicionar saldo: $e');
      rethrow;
    }
  }
}