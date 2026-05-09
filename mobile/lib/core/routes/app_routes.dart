import 'package:flutter/material.dart';
import 'package:mobile/features/auth/presentation/email_sent_confirmation_screen.dart';
import 'package:mobile/features/auth/presentation/forgot_password_screen.dart';
import 'package:mobile/features/auth/presentation/login_screen.dart';
import 'package:mobile/features/auth/presentation/signup_screen.dart';
import 'package:mobile/features/auth/presentation/mfa_verification_screen.dart';
import 'package:mobile/features/startups/presentation/screen/list/catalogo_de_startups.dart';
import 'package:mobile/features/wallet/presentation/depositar_screen.dart';
import 'package:mobile/features/wallet/presentation/sacar_screen.dart';
import 'package:mobile/features/wallet/presentation/trade_market.dart';
import 'package:mobile/features/dashboard/main_wrapper_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String mainRoute = '/main';
  static const String login = '/login';
  static const String cadastro = '/cadastro';
  static const String recuperarSenha = '/recuperarsenha';
  static const String emailEnviado = '/emailenviado';
  static const String catalogo = '/catalogo';
  static const String mfa = '/mfa';
  static const String profileSecurity = '/profile-security';
  static const String startupDetalhes = '/startup-detalhes';
  static const String balcao = '/balcao';
  static const String carteira = '/carteira';
  static const String dashboard = '/dashboard';
  static const String investir = '/investir';
  static const String comprar = '/comprar';
  static const String vender = '/vender';
  static const String depositar = '/depositar';
  static const String enviar = '/enviar';
  static const String sacar = '/sacar';
  static const String receber = '/receber';
  static const String notificacoes = '/notificacoes';

  static Map<String, WidgetBuilder> get routes => {
    mainRoute: (_) => const MainWrapperScreen(),
    login: (_) => const LoginPage(),
    cadastro: (_) => const SignUpPage(),
    recuperarSenha: (_) => const RecuperarSenha(),
    emailEnviado: (_) => const EmailEnviado(),
    catalogo: (_) => const CatalogoStartupsPage(),
    startupDetalhes: (_) => const RoutePlaceholderPage(
      title: 'Detalhes da startup',
      subtitle: 'Use a lista para abrir uma startup real.',
      icon: Icons.business,
    ),
    balcao: (_) => const BalcaoNegociacaoPage(),
    investir: (_) => const BalcaoNegociacaoPage(),
    comprar: (_) => const BalcaoNegociacaoPage(),
    vender: (_) => const BalcaoNegociacaoPage(),
    carteira: (_) => const BalcaoNegociacaoPage(),
    dashboard: (_) => const BalcaoNegociacaoPage(),
    depositar: (_) => const DepositarScreen(),
    enviar: (_) => const RoutePlaceholderPage(
      title: 'Depositar',
      subtitle: 'Rota legada apontando para a funcao de deposito.',
      icon: Icons.arrow_upward,
    ),
    sacar: (_) => const SacarScreen(),
    receber: (_) => const RoutePlaceholderPage(
      title: 'Sacar',
      subtitle: 'Rota legada apontando para a funcao de saque.',
      icon: Icons.arrow_downward,
    ),
    notificacoes: (_) => const RoutePlaceholderPage(
      title: 'Notificacoes',
      subtitle: 'Rota pronta para integrar a central de notificacoes.',
      icon: Icons.notifications_none,
    ),
    mfa: (context) {
      final code = ModalRoute.of(context)?.settings.arguments as String? ?? '';
      return MfaVerificationScreen(expectedCode: code);
    },
  };
}

class RoutePlaceholderPage extends StatelessWidget {
  const RoutePlaceholderPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFF5A2D91);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
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
        backgroundColor: Colors.white,
        foregroundColor: primaryPurple,
        elevation: 0,
        centerTitle: true,
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: primaryPurple, size: 42),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 14,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
