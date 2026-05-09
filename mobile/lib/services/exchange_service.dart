import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

class ExchangeService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<void> buyTokens(String startupId, int tokenQuantity) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('exchange-buyTokens');
      final result = await callable.call(<String, dynamic>{
        'startupId': startupId,
        'tokenQuantity': tokenQuantity,
      });
      
      debugPrint('Status da Compra: ${result.data['status']}');
      
    } catch (e) {
      debugPrint('Erro ao comprar tokens: $e');
      rethrow; // Repassa o erro para a tela (ex: "Saldo insuficiente")
    }
  }
}
