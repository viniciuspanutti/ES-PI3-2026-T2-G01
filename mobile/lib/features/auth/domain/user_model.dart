// ── user_model.dart ────────────────────────────────────────────────────
// Camada Domain — modelo imutável que representa os dados de segurança
// do usuário armazenados no Firestore (coleção: users/{uid}).
// ──────────────────────────────────────────────────────────────────────

class UserModel {
  final String uid;
  final String? email;
  final String? securityPin; // PIN em texto plano (4-6 dígitos)
  final bool hasMfaEnabled;

  const UserModel({
    required this.uid,
    this.email,
    this.securityPin,
    this.hasMfaEnabled = false,
  });

  // ── Desserialização do Firestore ─────────────────────────────────────
  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      email: map['email'] as String?,
      securityPin: map['securityPin'] as String?,
      hasMfaEnabled: map['hasMfaEnabled'] as bool? ?? false,
    );
  }

  // ── Serialização para o Firestore ────────────────────────────────────
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'securityPin': securityPin,
      'hasMfaEnabled': hasMfaEnabled,
    };
  }

  // ── Copia com novos valores ──────────────────────────────────────────
  UserModel copyWith({
    String? securityPin,
    bool? hasMfaEnabled,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      securityPin: securityPin ?? this.securityPin,
      hasMfaEnabled: hasMfaEnabled ?? this.hasMfaEnabled,
    );
  }
}
