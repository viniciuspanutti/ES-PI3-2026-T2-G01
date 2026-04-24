import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile/features/startups/presentation/screen/list/catalogo_de_startups.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa o Firebase. Se você ainda não configurou o google-services.json,
  // remova estas linhas ou configure o projeto no console do Firebase.
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Erro ao inicializar Firebase (pode ser falta de configuração): $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MesclaInvest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF512DA8)),
        useMaterial3: true,
      ),
      home: const CatalogoStartupsPage(),
    );
  }
}
