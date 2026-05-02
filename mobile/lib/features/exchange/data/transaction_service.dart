import 'package:flutter/material.dart';

class TransactionService {
  static final TransactionService _instance = TransactionService._internal();
  factory TransactionService() => _instance;
  TransactionService._internal();

  final List<Map<String, dynamic>> _transactions = [];
  final List<Map<String, dynamic>> _valuationData = [];
  
  // Notifiers para atualização da UI
  final _transactionsNotifier = ValueNotifier<List<Map<String, dynamic>>>([]);
  final _valuationNotifier = ValueNotifier<List<Map<String, dynamic>>>([]);

  ValueNotifier<List<Map<String, dynamic>>> get transactionsNotifier => _transactionsNotifier;
  ValueNotifier<List<Map<String, dynamic>>> get valuationNotifier => _valuationNotifier;

  List<Map<String, dynamic>> get transactions => List.from(_transactions);
  List<Map<String, dynamic>> get valuationData => List.from(_valuationData);

  void initializeData() {
    // Dados históricos iniciais
    _transactions.addAll([
      {
        'id': '1',
        'type': 'COMPRA',
        'amount': '25',
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
        'status': 'COMPLETA',
        'price': 5.95,
        'total': '148.75',
      },
      {
        'id': '2',
        'type': 'TRANSFERENCIA',
        'amount': '100',
        'timestamp': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        'status': 'COMPLETA',
        'price': 6.00,
        'total': '600.00',
      },
      {
        'id': '3',
        'type': 'COMPRA',
        'amount': '30',
        'timestamp': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
        'status': 'COMPLETA',
        'price': 5.80,
        'total': '174.00',
      },
    ]);

    // Dados de valorização iniciais
    _valuationData.addAll([
      {'period': '2024-01-01', 'price': 100.0, 'volume': 1000, 'highPrice': 105.0, 'lowPrice': 95.0},
      {'period': '2024-01-02', 'price': 102.0, 'volume': 1200, 'highPrice': 108.0, 'lowPrice': 98.0},
      {'period': '2024-01-03', 'price': 98.0, 'volume': 900, 'highPrice': 103.0, 'lowPrice': 92.0},
      {'period': '2024-01-04', 'price': 105.0, 'volume': 1500, 'highPrice': 110.0, 'lowPrice': 100.0},
      {'period': '2024-01-05', 'price': 110.0, 'volume': 1800, 'highPrice': 115.0, 'lowPrice': 105.0},
      {'period': '2024-01-06', 'price': 108.0, 'volume': 1400, 'highPrice': 112.0, 'lowPrice': 104.0},
      {'period': '2024-01-07', 'price': 112.0, 'volume': 1600, 'highPrice': 118.0, 'lowPrice': 108.0},
    ]);

    _transactionsNotifier.value = List.from(_transactions);
    _valuationNotifier.value = List.from(_valuationData);
  }

  void addTransaction({
    required String type,
    required String amount,
    required double price,
    required String status,
  }) {
    final agora = DateTime.now();
    final transaction = {
      'id': agora.millisecondsSinceEpoch.toString(),
      'type': type,
      'amount': amount,
      'timestamp': agora.toIso8601String(),
      'status': status,
      'price': price,
      'total': (double.parse(amount) * price).toStringAsFixed(2),
    };

    _transactions.insert(0, transaction);
    _transactionsNotifier.value = List.from(_transactions);

    // Atualizar dados de valorização com base na transação
    _updateValuationData(transaction);
  }

  void _updateValuationData(Map<String, dynamic> transaction) {
    final hoje = DateTime.now();
    final hojeStr = '${hoje.year}-${hoje.month.toString().padLeft(2, '0')}-${hoje.day.toString().padLeft(2, '0')}';
    
    // Encontrar ou criar entrada para hoje
    int hojeIndex = _valuationData.indexWhere((data) => data['period'] == hojeStr);
    
    if (hojeIndex == -1) {
      // Criar nova entrada para hoje
      final ultimoPreco = _valuationData.isNotEmpty ? _valuationData.last['price'] : 100.0;
      _valuationData.add({
        'period': hojeStr,
        'price': transaction['price'],
        'volume': int.parse(transaction['amount']),
        'highPrice': transaction['price'] > ultimoPreco ? transaction['price'] : ultimoPreco,
        'lowPrice': transaction['price'] < ultimoPreco ? transaction['price'] : ultimoPreco,
      });
    } else {
      // Atualizar entrada existente
      final dadosHoje = _valuationData[hojeIndex];
      dadosHoje['price'] = transaction['price'];
      dadosHoje['volume'] = (dadosHoje['volume'] as int) + int.parse(transaction['amount']);
      dadosHoje['highPrice'] = transaction['price'] > dadosHoje['highPrice'] ? transaction['price'] : dadosHoje['highPrice'];
      dadosHoje['lowPrice'] = transaction['price'] < dadosHoje['lowPrice'] ? transaction['price'] : dadosHoje['lowPrice'];
    }

    _valuationNotifier.value = List.from(_valuationData);
  }

  Map<String, dynamic> getStatistics() {
    if (_transactions.isEmpty) {
      return {
        'totalTransactions': 0,
        'totalVolume': '0.00',
        'avgPrice': 0.0,
      };
    }

    final totalVolume = _transactions.fold<double>(
      0.0, 
      (sum, transaction) => sum + double.parse(transaction['total'].toString())
    );

    final avgPrice = _transactions.fold<double>(
      0.0, 
      (sum, transaction) => sum + transaction['price']
    ) / _transactions.length;

    return {
      'totalTransactions': _transactions.length,
      'totalVolume': totalVolume.toStringAsFixed(2),
      'avgPrice': avgPrice,
    };
  }

  Map<String, dynamic> getValuationStatistics() {
    if (_valuationData.isEmpty) {
      return {
        'avgPrice': 0.0,
        'variation': 0.0,
        'totalVolume': 0,
        'volatility': 0.0,
      };
    }

    final prices = _valuationData.map<double>((data) => data['price']).toList();
    final avgPrice = prices.reduce((a, b) => a + b) / prices.length;
    
    final firstPrice = prices.first;
    final lastPrice = prices.last;
    final variation = ((lastPrice - firstPrice) / firstPrice) * 100;

    final totalVolume = _valuationData.fold<int>(
      0, 
      (sum, data) => sum + (data['volume'] as int)
    );

    // Cálculo simples de volatilidade
    final maxPrice = prices.reduce((a, b) => a > b ? a : b);
    final minPrice = prices.reduce((a, b) => a < b ? a : b);
    final volatility = ((maxPrice - minPrice) / avgPrice) * 100;

    return {
      'avgPrice': avgPrice,
      'variation': variation,
      'totalVolume': totalVolume,
      'volatility': volatility,
    };
  }

  void clearAll() {
    _transactions.clear();
    _valuationData.clear();
    _transactionsNotifier.value = [];
    _valuationNotifier.value = [];
  }
}
