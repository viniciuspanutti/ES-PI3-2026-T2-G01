// Tom Bean
// importa o core do Flutter
import 'package:flutter/material.dart';
// importa rotas da aplicação
import 'package:mobile/core/routes/app_routes.dart';

// Widget wrapper que retorna a HomeScreen
class PaginaInicial extends StatelessWidget {
  // construtor
  const PaginaInicial({super.key});

  // build que delega para HomeScreen
  @override
  Widget build(BuildContext context) => const HomeScreen();
}

// Tela inicial com logo e botões de entrar/cadastrar
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // fundo branco
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2), // espaçamento superior
              Image.asset(
                'assets/images/MesclaInvest_logo.png', // logo do app
                height: 120,
              ),
              const SizedBox(height: 32),
              const Text(
                'Bem-vindo(a) ao\nMesclaInvest', // título
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF5A2D91),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Seu portal para as melhores\noportunidades em startups.', // subtítulo
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
              const Spacer(flex: 3), // espaço antes dos botões
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5A2D91),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                onPressed: () => Navigator.of(context).pushNamed(AppRoutes.login), // navega para login
                child: const Text(
                  'Entrar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF5A2D91),
                  side: const BorderSide(color: Color(0xFF5A2D91), width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.of(context).pushNamed(AppRoutes.cadastro), // navega para cadastro
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
