import 'package:flutter/material.dart';
import 'package:mobile/features/auth/presentation/screen/mfa.dart';
import 'package:mobile/features/home/pages/email_enviado.dart';
import 'package:mobile/features/home/pages/login.dart';
import 'package:mobile/features/home/pages/rec_senha.dart';
import 'package:mobile/features/startups/presentation/screen/balcao.dart';
import 'package:mobile/features/startups/presentation/screen/list/cadastros_screen.dart';
import 'package:mobile/features/startups/presentation/screen/list/catalogo_de_startups.dart';
import 'package:mobile/features/startups/presentation/screen/profile_security.dart';
import 'package:mobile/features/startups/presentation/screen/wallet.dart';

class AppRoutes {
  static const String menu = '/menu';
  static const String login = '/login';
  static const String cadastro = '/cadastro';
  static const String recuperarSenha = '/recuperar-senha';
  static const String recuperarSenhaLegacy = '/recuperarsenha';
  static const String emailEnviado = '/emailenviado';
  static const String mfa = '/mfa';
  static const String home = '/home';
  static const String startupDetalhes = '/startup-detalhes';
  static const String balcao = '/balcao';
  static const String carteira = '/carteira';
  static const String dashboard = '/dashboard';
  static const String loja = '/loja';
  static const String investir = '/investir';
  static const String comprar = '/comprar';
  static const String vender = '/vender';
  static const String depositar = '/depositar';
  static const String enviar = '/enviar';
  static const String sacar = '/sacar';
  static const String receber = '/receber';
  static const String cartao = '/cartao';
  static const String notificacoes = '/notificacoes';
  static const String chat = '/chat';
  static const String perfil = '/perfil';

  static Map<String, WidgetBuilder> get routes => {
    login: (_) => const LoginPage(),
    cadastro: (_) => const SignUpPage(),
    recuperarSenha: (_) => const RecuperarSenha(),
    recuperarSenhaLegacy: (_) => const RecuperarSenha(),
    emailEnviado: (_) => const EmailEnviado(),
    mfa: (_) => const MfaScreen(),
    startupDetalhes: (_) => const RoutePlaceholderPage(
      title: 'Detalhes da startup',
      subtitle: 'Use a lista para abrir uma startup real.',
      icon: Icons.business,
    ),
    balcao: (_) => const BalcaoNegociacaoPage(),
    carteira: (_) => const WalletDashboardPage(),
    dashboard: (_) => const WalletDashboardPage(),
    loja: (_) => const CatalogoStartupsPage(),
    investir: (_) => const BalcaoNegociacaoPage(),
    comprar: (_) => const BalcaoNegociacaoPage(),
    vender: (_) => const BalcaoNegociacaoPage(),
    depositar: (_) => const RoutePlaceholderPage(
      title: 'Depositar',
      subtitle: 'Rota pronta para integrar a tela de deposito.',
      icon: Icons.arrow_upward,
    ),
    enviar: (_) => const RoutePlaceholderPage(
      title: 'Depositar',
      subtitle: 'Rota legada apontando para a funcao de deposito.',
      icon: Icons.arrow_upward,
    ),
    sacar: (_) => const RoutePlaceholderPage(
      title: 'Sacar',
      subtitle: 'Rota pronta para integrar a tela de saque.',
      icon: Icons.arrow_downward,
    ),
    receber: (_) => const RoutePlaceholderPage(
      title: 'Sacar',
      subtitle: 'Rota legada apontando para a funcao de saque.',
      icon: Icons.arrow_downward,
    ),
    cartao: (_) => const WalletDashboardPage(),
    notificacoes: (_) => const RoutePlaceholderPage(
      title: 'Notificacoes',
      subtitle: 'Rota pronta para integrar a central de notificacoes.',
      icon: Icons.notifications_none,
    ),
    chat: (_) => const RoutePlaceholderPage(
      title: 'Chat',
      subtitle: 'Rota pronta para integrar o atendimento.',
      icon: Icons.chat_bubble_outline,
    ),
    perfil: (_) => const ProfileSecurityScreen(),
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
