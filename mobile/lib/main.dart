import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/home/pages/login.dart';
import 'package:mobile/features/home/pages/rec_senha.dart';
import 'package:mobile/features/home/pages/email_enviado.dart';
import 'package:mobile/features/home/pages/cadastros_screen.dart';
import 'package:mobile/features/startups/presentation/screen/list/catalogo_de_startups.dart';
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
      // Iniciando diretamente na LoginPage conforme solicitado
      home: const LoginPage(),
      // Definindo as rotas para que os botões da LoginPage funcionem sem crashar
      routes: {
        '/login': (context) => const LoginPage(),
        '/cadastro': (context) => const SignUpPage(),
        '/recuperarsenha': (context) => const RecuperarSenha(),
        '/emailenviado': (context) => const EmailEnviado(),
        '/catalogo': (context) => const CatalogoStartupsPage(),
      },
    );
  }
}
