import 'package:cloud_functions/cloud_functions.dart';
import '../domain/startup.dart';

class StartupService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  /// Busca a lista de startups no catálogo
  Future<List<StartupListItem>> listStartups({
    String? stage,
    String? search,
  }) async {
    try {
      final callable = _functions.httpsCallable('listStartups');
      final response = await callable.call({
        'stage': ?stage,
        'search': ?search,
      });

      final List<dynamic> data = response.data['data'];
      return data
          .map(
            (item) => StartupListItem.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();
    } on FirebaseFunctionsException catch (e) {
      throw Exception('Erro do Firebase [${e.code}]: ${e.message}');
    } catch (e) {
      throw Exception('Erro inesperado ao listar startups: $e');
    }
  }

  /// Busca os detalhes profundos de uma startup específica
  Future<StartupDetail> getStartupDetails(String id) async {
    try {
      final callable = _functions.httpsCallable('getStartupDetails');
      final response = await callable.call({'id': id});

      final Map<String, dynamic> data = Map<String, dynamic>.from(
        response.data['data'],
      );
      return StartupDetail.fromJson(data);
    } on FirebaseFunctionsException catch (e) {
      throw Exception('Erro do Firebase [${e.code}]: ${e.message}');
    } catch (e) {
      throw Exception('Erro inesperado ao buscar detalhes: $e');
    }
  }

  /// Envia uma pergunta para a startup
  Future<void> createStartupQuestion({
    required String startupId,
    required String text,
    required String visibility,
  }) async {
    try {
      final callable = _functions.httpsCallable('createStartupQuestion');
      await callable.call({
        'startupId': startupId,
        'text': text,
        'visibility': visibility,
      });
    } on FirebaseFunctionsException catch (e) {
      throw Exception('Erro do Firebase [${e.code}]: ${e.message}');
    } catch (e) {
      throw Exception('Erro ao enviar pergunta: $e');
    }
  }
}
