// ── startup_service.dart ──────────────────────────────────────────────
// SUBSTITUIÇÃO DO MOCK: este arquivo agora conecta diretamente ao
// Firestore em vez de consumir dados estáticos do startup_mock.dart.
// ──────────────────────────────────────────────────────────────────────

import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/startup.dart';

class StartupService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Referência à coleção "startups" no Firestore.
  CollectionReference get _startupsRef => _firestore.collection('startups');

  // ────────────────────────────────────────────────────────────────────
  // getStartups()
  // Busca TODOS os documentos da coleção e mapeia para StartupDetail.
  // Campos nulos (videoUrl, executiveSummary, etc.) são tratados com
  // valores padrão no fromJson do domínio.
  // ────────────────────────────────────────────────────────────────────
  Future<List<StartupDetail>> getStartups() async {
    try {
      final QuerySnapshot snapshot = await _startupsRef.get();

      return snapshot.docs.map((doc) {
        // Combina o ID do documento com os campos do mapa
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return StartupDetail.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception('Erro ao buscar startups do Firestore: $e');
    }
  }

  // ────────────────────────────────────────────────────────────────────
  // getStartupDetails(id)
  // Busca um único documento pelo ID para a tela de detalhes, caso
  // seja necessário um refresh isolado no futuro.
  // ────────────────────────────────────────────────────────────────────
  Future<StartupDetail> getStartupDetails(String id) async {
    try {
      final DocumentSnapshot doc = await _startupsRef.doc(id).get();

      if (!doc.exists) {
        throw Exception('Startup com id "$id" não encontrada.');
      }

      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return StartupDetail.fromJson(data);
    } catch (e) {
      throw Exception('Erro ao buscar detalhes da startup: $e');
    }
  }

  // ────────────────────────────────────────────────────────────────────
  // createStartupQuestion(startupId, text)
  // Adiciona uma nova pergunta na subcoleção "questions".
  // ────────────────────────────────────────────────────────────────────
  Future<void> createStartupQuestion(String startupId, String text) async {
    try {
      await _startupsRef.doc(startupId).collection('questions').add({
        'text': text,
        'visibility': 'publica',
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erro ao enviar pergunta: $e');
    }
  }
}
