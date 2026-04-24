// feito por camila fernandes costacurta RA:25012949 
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static const String _usersKey = 'users';
  static const String _currentEmailKey = 'current_email';
  static const String _walletBalanceKey = 'wallet_balance';
  static const String _walletTransactionsKey = 'wallet_transactions';
  static const String _mfaEnabledKey = 'mfa_enabled';

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_usersKey);
    if (raw == null || raw.isEmpty) return <Map<String, dynamic>>[];
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();
  }

  static Future<void> saveUsers(List<Map<String, dynamic>> users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  static Future<void> setCurrentEmail(String? email) async {
    final prefs = await SharedPreferences.getInstance();
    if (email == null) {
      await prefs.remove(_currentEmailKey);
      return;
    }
    await prefs.setString(_currentEmailKey, email);
  }

  static Future<String?> getCurrentEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentEmailKey);
  }

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
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();
  }

  static Future<void> setWalletTransactions(
    List<Map<String, dynamic>> transactions,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_walletTransactionsKey, jsonEncode(transactions));
  }

  static Future<bool> getMfaEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_mfaEnabledKey) ?? false;
  }

  static Future<void> setMfaEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_mfaEnabledKey, value);
  }

  static Future<Map<String, dynamic>?> getCurrentUser() async {
    final email = await getCurrentEmail();
    if (email == null) return null;
    final users = await getUsers();
    for (final user in users) {
      if (user['email'] == email) {
        return user;
      }
    }
    return null;
  }

  static Future<void> setCurrentUserMfaEnabled(bool value) async {
    final email = await getCurrentEmail();
    if (email == null) return;

    final users = await getUsers();
    for (var i = 0; i < users.length; i++) {
      if (users[i]['email'] == email) {
        users[i]['mfaEnabled'] = value;
      }
    }
    await saveUsers(users);
    await setMfaEnabled(value);
  }

  static Future<bool> getCurrentUserMfaEnabled() async {
    final user = await getCurrentUser();
    if (user == null) return await getMfaEnabled();
    return user['mfaEnabled'] == true;
  }
}
