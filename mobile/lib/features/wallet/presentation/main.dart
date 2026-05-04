import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/routes/app_routes.dart';
import 'package:mobile/features/wallet/presentation/temp_codigo.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MesclaInvest',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF512DA8)),
      ),
      // Ponto de entrada da navegação original (Login)
      home: const TokenDetailsScreen(),
      // Todas as rotas (incluindo as novas)
      routes: AppRoutes.routes,
    );
  }
}
