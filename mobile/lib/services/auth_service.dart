// ── auth_service.dart ─────────────────────────────────────────────────
// Camada Data — integração real com Firebase Auth.
// Substitui a autenticação local (SharedPreferences) por sessão na nuvem.
//
// Após login/cadastro bem-sucedido, garante a existência do documento
// do usuário na coleção `users` do Firestore (via UserService).
// ──────────────────────────────────────────────────────────────────────

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/auth/data/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  // ────────────────────────────────────────────────────────────────────
  // Stream de estado de autenticação
  // Permite que widgets (ex: AuthGate) reajam a login/logout em tempo real.
  // ────────────────────────────────────────────────────────────────────
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Retorna o usuário logado, ou null se não houver sessão.
  User? get currentUser => _auth.currentUser;

  /// Verifica se existe um usuário autenticado.
  bool get isLoggedIn => _auth.currentUser != null;

  // ────────────────────────────────────────────────────────────────────
  // Sign In — e-mail e senha
  // ────────────────────────────────────────────────────────────────────
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    debugPrint('>>> entrou no signInWithEmailAndPassword');
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    final functions = FirebaseFunctions.instanceFor(region: 'us-central1');
      // Garante que o documento Firestore existe para este usuário
    try {
      final resultado = await functions.httpsCallable('criarCarteira').call();
      debugPrint('Resultado criarCarteira: ${resultado.data}');
    } catch (e) {
      debugPrint('Erro criarCarteira: $e');
    }
      // Garante que o documento Firestore existe para este usuário
      await _userService.ensureUserDocument(credential.user!);
      return credential;
    } on FirebaseAuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  // ────────────────────────────────────────────────────────────────────
  // Sign Up — e-mail e senha
  // ────────────────────────────────────────────────────────────────────
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // Instancia a carteira para o novo usuário no Firestore
      final functions = FirebaseFunctions.instanceFor(region: 'us-central1');
      try {
        await functions.httpsCallable('criarCarteira').call();
      } catch (e) {
        debugPrint('Erro a instanciar a carteira no registo: $e');
      }
      // Cria o documento do usuário no Firestore na primeira vez
      await _userService.ensureUserDocument(credential.user!);
      return credential;
    } on FirebaseAuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  // ────────────────────────────────────────────────────────────────────
  // Reset Password
  // ────────────────────────────────────────────────────────────────────
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  // ────────────────────────────────────────────────────────────────────
  // Sign Out
  // ────────────────────────────────────────────────────────────────────
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ────────────────────────────────────────────────────────────────────
  // Mapeamento de erros Firebase → mensagens amigáveis em PT-BR
  // ────────────────────────────────────────────────────────────────────
  Exception _mapAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('E-mail não cadastrado.');
      case 'wrong-password':
        return Exception('Senha incorreta.');
      case 'invalid-credential':
        return Exception('Credenciais inválidas. Verifique e-mail e senha.');
      case 'email-already-in-use':
        return Exception('Este e-mail já está cadastrado.');
      case 'weak-password':
        return Exception('A senha deve ter no mínimo 6 caracteres.');
      case 'invalid-email':
        return Exception('Formato de e-mail inválido.');
      case 'too-many-requests':
        return Exception('Muitas tentativas. Tente novamente mais tarde.');
      case 'network-request-failed':
        return Exception('Sem conexão com a internet.');
      default:
        return Exception(e.message ?? 'Erro de autenticação desconhecido.');
    }
  }
}
