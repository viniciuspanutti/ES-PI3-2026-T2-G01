import 'package:flutter/material.dart';
import 'features/startups/presentation/screen/catalogo_de_startups.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      // A tela inicial deve ser o catálogo. 
      // O catálogo não recebe parâmetros no construtor.
      home: const CatalogoStartupsPage(),
    );
  }
}
