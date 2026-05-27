// ── user_service.dart ──────────────────────────────────────────────────
// Camada Data — serviço responsável por ler e escrever os dados de
// segurança do usuário na coleção `users` do Firestore.
//
// Documento: users/{uid}
// Campos gerenciados:
//   • email        — e-mail do Firebase Auth
//   • securityPin  — PIN numérico de 4 a 6 dígitos (texto plano)
//   • hasMfaEnabled — booleano que indica PIN configurado
// ──────────────────────────────────────────────────────────────────────

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/features/auth/domain/user_model.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ── Referência ao documento do usuário logado ──────────────────────
  DocumentReference<Map<String, dynamic>> _userDoc(String uid) =>
      _db.collection('users').doc(uid);

  // ── Obtém o UID do usuário corrente (lança se não autenticado) ─────
  String get _currentUid {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado.');
    return user.uid;
  }

  // ──────────────────────────────────────────────────────────────────
  // Cria ou garante a existência do documento do usuário no Firestore.
  // Chamado logo após o cadastro ou primeiro login.
  // ──────────────────────────────────────────────────────────────────
  Future<void> ensureUserDocument(User firebaseUser) async {
    final ref = _userDoc(firebaseUser.uid);
    final snapshot = await ref.get();

    if (!snapshot.exists) {
      await ref.set({
        'email': firebaseUser.email,
        'securityPin': null,
        'hasMfaEnabled': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // Busca os dados de segurança do usuário logado.
  // Retorna null se o documento ainda não existir.
  // ──────────────────────────────────────────────────────────────────
  Future<UserModel?> fetchCurrentUser() async {
    final uid = _currentUid;
    final snapshot = await _userDoc(uid).get();

    if (!snapshot.exists || snapshot.data() == null) return null;
    return UserModel.fromMap(uid, snapshot.data()!);
  }

  // ──────────────────────────────────────────────────────────────────
  // Salva (cria ou atualiza) o PIN de segurança do usuário.
  // Também habilita o MFA automaticamente.
  // ──────────────────────────────────────────────────────────────────
  Future<void> saveSecurityPin(String pin) async {
    final uid = _currentUid;
    await _userDoc(uid).set(
      {
        'securityPin': pin,
        'hasMfaEnabled': true,
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true), // não sobrescreve outros campos
    );
  }

  // ──────────────────────────────────────────────────────────────────
  // Remove o PIN e desabilita o MFA.
  // ──────────────────────────────────────────────────────────────────
  Future<void> removeSecurityPin() async {
    final uid = _currentUid;
    await _userDoc(uid).update({
      'securityPin': null,
      'hasMfaEnabled': false,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // ──────────────────────────────────────────────────────────────────
  // Valida um PIN digitado comparando com o armazenado no Firestore.
  // Retorna true se correto, false caso contrário.
  // ──────────────────────────────────────────────────────────────────
  Future<bool> validatePin(String inputPin) async {
    final user = await fetchCurrentUser();
    if (user == null || user.securityPin == null) return false;
    return user.securityPin == inputPin;
  }
}
