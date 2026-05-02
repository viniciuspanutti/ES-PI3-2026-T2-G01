import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../domain/startup.dart';

class StartupService {
  CollectionReference<Map<String, dynamic>> get _startupsRef {
    if (Firebase.apps.isEmpty) {
      throw StateError(
        'Firebase ainda nao foi inicializado. Configure o Firebase do app '
        'para carregar a colecao "startups".',
      );
    }

    return FirebaseFirestore.instance.collection('startups');
  }

  Future<List<StartupDetail>> getStartups() async {
    try {
      final snapshot = await _startupsRef.get();

      return snapshot.docs.map((doc) {
        final data = Map<String, dynamic>.from(doc.data());
        data['id'] = doc.id;
        return StartupDetail.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception('Erro ao buscar startups do Firestore: $e');
    }
  }

  Future<StartupDetail> getStartupDetails(String id) async {
    try {
      final doc = await _startupsRef.doc(id).get();

      if (!doc.exists) {
        throw Exception('Startup com id "$id" nao encontrada.');
      }

      final data = Map<String, dynamic>.from(doc.data() ?? {});
      data['id'] = doc.id;
      return StartupDetail.fromJson(data);
    } catch (e) {
      throw Exception('Erro ao buscar detalhes da startup: $e');
    }
  }
}
