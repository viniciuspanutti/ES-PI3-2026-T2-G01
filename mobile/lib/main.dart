import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cloud_functions/cloud_functions.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'features/startups/presentation/screen/catalogo_de_startups.dart';
import 'features/exchange/presentation/screen/wallet_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // O comando comentado abaixo precisará ser configurado depois:
  // await Firebase.initializeApp();

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
      // A tela inicial agora aponta para o lugar correto
      //home: const CarteiraBalcaoScreen(),
      home: const CatalogoStartupsPage(),
    );
  }
}