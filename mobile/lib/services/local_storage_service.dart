// feito por camila fernandes costacurta RA:25012949
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static const String _walletBalanceKey = 'wallet_balance';
  static const String _walletTransactionsKey = 'wallet_transactions';

  static Future<double> getWalletBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_walletBalanceKey) ?? 345.71;
  }

  static Future<void> setWalletBalance(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_walletBalanceKey, value);
  }

  static Future<List<Map<String, dynamic>>> getWalletTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_walletTransactionsKey);
    if (raw == null || raw.isEmpty) {
      return <Map<String, dynamic>>[
        {
          'title': 'Compra inicial',
          'subtitle': 'Carga simulada da carteira',
          'value': '+345.71 BYD',
          'kind': 'buy',
        },
      ];
    }
    final decoded = await compute(jsonDecode, raw) as List<dynamic>;
    return decoded
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();
  }

  static Future<void> setWalletTransactions(
    List<Map<String, dynamic>> transactions,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = await compute(jsonEncode, transactions);
    await prefs.setString(_walletTransactionsKey, encoded);
  }
}
