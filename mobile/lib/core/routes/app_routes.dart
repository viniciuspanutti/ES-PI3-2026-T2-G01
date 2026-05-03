import 'package:flutter/material.dart';
import 'package:mobile/features/profile/presentation/security_settings_screen.dart';
import 'package:mobile/features/auth/presentation/signup_screen.dart';
import 'package:mobile/features/auth/presentation/login_screen.dart';
import 'package:mobile/features/auth/presentation/forgot_password_screen.dart';
import 'package:mobile/features/auth/presentation/home_screen.dart';
import 'package:mobile/features/startups/presentation/screen/list/catalogo_de_startups.dart';
import 'package:mobile/features/wallet/presentation/wallet_dashboard_screen.dart';
import 'package:mobile/features/wallet/presentation/trading_market_screen.dart';
import 'package:mobile/features/dashboard/main_wrapper_screen.dart';

class AppRoutes {
  // CHAVE MESTRA: Garante controle total das abas de qualquer lugar
  static final GlobalKey<MainWrapperScreenState> mainWrapperKey = GlobalKey<MainWrapperScreenState>();

  /// SISTEMA SMART BACK ULTRA: NUNCA FECHA O APP
  /// 
  /// 1. Se houver algo para desempilhar (pop), ele desempilha.
  /// 2. Se falhar ou estiver na raiz, ele pula para a aba Home (Index 0).
  static void smartBack(BuildContext context) {
    try {
      final navigator = Navigator.of(context);
      if (navigator.canPop()) {
        navigator.pop();
      } else {
        mainWrapperKey.currentState?.setIndex(0);
      }
    } catch (e) {
      mainWrapperKey.currentState?.setIndex(0);
    }
  }

  // Constantes de rota
  static const String home = '/';
  static const String mainWrapper = '/main';
  static const String login = '/login';
  static const String cadastro = '/cadastro';
  static const String recuperarsenha = '/recuperarsenha';
  static const String catalogo = '/catalogo';
  static const String profileSecurity = '/profile-security';
  static const String investir = '/investir';
  static const String balcao = '/balcao';
  static const String dashboard = '/dashboard';
  static const String loja = '/loja';
  static const String depositar = '/depositar';
  static const String sacar = '/sacar';
  static const String cartao = '/cartao';
  static const String notificacoes = '/notificacoes';
  static const String perfil = '/perfil';

  static Map<String, WidgetBuilder> get routes => {
        mainWrapper: (_) => MainWrapperScreen(key: mainWrapperKey),
        login: (_) => const LoginPage(),
        menu: (_) => const PaginaInicial(),
        cadastro: (_) => const SignUpPage(),
        recuperarsenha: (_) => const RecuperarSenha(),
        catalogo: (_) => const CatalogoStartupsPage(),
        profileSecurity: (_) => const ProfileSecurityScreen(),
        balcao: (_) => const BalcaoNegociacaoPage(),
        investir: (_) => const BalcaoNegociacaoPage(),
        dashboard: (_) => const WalletDashboardPage(),
        loja: (_) => const CatalogoStartupsPage(),
        perfil: (_) => const ProfileSecurityScreen(),
        cartao: (_) => const WalletDashboardPage(),
        depositar: (_) => const RoutePlaceholderPage(title: 'Depositar', icon: Icons.arrow_upward),
        sacar: (_) => const RoutePlaceholderPage(title: 'Sacar', icon: Icons.arrow_downward),
        notificacoes: (_) => const RoutePlaceholderPage(title: 'Notificações', icon: Icons.notifications_none),
      };
}

// ── Widget de Tela Placeholder Totalmente Blindado ──────────────────
class RoutePlaceholderPage extends StatelessWidget {
  const RoutePlaceholderPage({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AppRoutes.smartBack(context);
        return false; // IMPEDE O FECHAMENTO DO APP PELO BOTÃO DO SISTEMA
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF5A2D91),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => AppRoutes.smartBack(context),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 80, color: const Color(0xFF5A2D91)),
              const SizedBox(height: 16),
              Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Text('Funcionalidade em desenvolvimento.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => AppRoutes.smartBack(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5A2D91),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Voltar para a Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
