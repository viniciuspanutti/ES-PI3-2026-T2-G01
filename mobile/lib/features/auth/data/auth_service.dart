// ── auth_service.dart ─────────────────────────────────────────────────
// Camada Data — integração real com Firebase Auth.
// Substitui a autenticação local (SharedPreferences) por sessão na nuvem.
// ──────────────────────────────────────────────────────────────────────

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
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
      return await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  // ────────────────────────────────────────────────────────────────────
  // Reset Password
  // ────────────────────────────────────────────────────────────────────
  Future<void> resetPassword({required String email}) async {
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
