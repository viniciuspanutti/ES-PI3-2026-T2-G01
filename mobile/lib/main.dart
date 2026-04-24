import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile/features/home/pages/email_enviado.dart';
import 'package:mobile/features/home/pages/home.dart';
import 'package:mobile/features/home/pages/login.dart';
import 'package:mobile/features/home/pages/rec_senha.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

//lib/features/home/images/cartao.png
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PaginaInicial(),
      routes: {
        '/menu': (context) => const PaginaInicial(),
        '/login': (context) => const LoginPage(),
        '/recuperarsenha': (context) => const RecuperarSenha(),
        '/emailenviado': (context) => const EmailEnviado(),
      },
    );
  }
}
