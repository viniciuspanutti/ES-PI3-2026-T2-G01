import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/routes/app_routes.dart';
import 'package:mobile/features/auth/presentation/home_screen.dart';
import 'package:mobile/features/dashboard/main_wrapper_screen.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';
//testing
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('pt_BR', null);
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
      // Ponto de entrada da navegação
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return const MainWrapperScreen();
          }
          return const HomeScreen();
        },
      ),
      // Todas as rotas nomeadas centralizadas em AppRoutes
      routes: AppRoutes.routes,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context, 
                    AppRoutes.mainRoute, 
                    (route) => false,
                  );
                },
              ),
              title: const Text('Em Desenvolvimento'),
            ),
            body: const Center(
              child: Text('Esta funcionalidade ainda não foi implementada pela equipe.'),
            ),
          ),
        );
      },
    );
  }
}
