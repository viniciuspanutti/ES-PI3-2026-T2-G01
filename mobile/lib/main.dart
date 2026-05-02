import 'package:flutter/material.dart';
import 'package:mobile/core/routes/app_routes.dart';
import 'package:mobile/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MesclaInvestApp());
}

class MesclaInvestApp extends StatelessWidget {
  const MesclaInvestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'SF Pro Text',
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5A2D91),
          brightness: Brightness.light,
        ),
      ),
      home: const HomeScreen(),
      routes: {
        ...AppRoutes.routes,
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.menu: (_) => const HomeScreen(),
      },
    );
  }
}
