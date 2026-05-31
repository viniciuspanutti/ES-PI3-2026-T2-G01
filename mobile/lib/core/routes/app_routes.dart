// Vinícius Panutti Salgado - 25007329
// ── app_routes.dart ────────────────────────────────────────────────────
// Camada Core — Mapa centralizado de todas as rotas nomeadas do app.
//
// Padrão de Arquitetura:
//   Todas as rotas nomeadas são definidas como constantes estáticas
//   dentro da classe AppRoutes. Isto evita strings mágicas espalhadas
//   pelo código e garante refatoração segura (trocar o valor da const
//   atualiza automaticamente todos os Navigator.pushNamed que a usam).
//
// O mapa `routes` é consumido diretamente pelo MaterialApp em main.dart.
// ──────────────────────────────────────────────────────────────────────

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

// ── AppRoutes — Classe utilitária com constantes de rota ─────────────
// Todas as rotas são strings constantes para evitar erros de digitação.
// Cada constante corresponde a um caminho único na árvore de navegação.
class AppRoutes {
  // Rota raiz (normalmente resolvida pelo Auth Gate em main.dart)
  static const String home = '/';
  // Rota do dashboard principal (MainWrapperScreen com BottomNavBar)
  static const String mainRoute = '/main';
  // Fluxo de autenticação
  static const String login = '/login';
  static const String cadastro = '/cadastro';
  static const String recuperarSenha = '/recuperarsenha';
  static const String emailEnviado = '/emailenviado';
  // Catálogo de startups — listagem com filtro por estágio
  static const String catalogo = '/catalogo';
  // Verificação MFA (Multi-Factor Authentication) via código OTP
  static const String mfa = '/mfa';
  // Segurança do perfil — configuração de PIN
  static const String profileSecurity = '/profile-security';
  // Tela de detalhes de uma startup específica
  static const String startupDetalhes = '/startup-detalhes';
  // Balcão de negociação (trade market) — compra/venda de tokens
  static const String balcao = '/balcao';
  // Rotas da carteira digital
  static const String carteira = '/carteira';
  static const String dashboard = '/dashboard';
  // Ações financeiras
  static const String investir = '/investir';
  static const String comprar = '/comprar';
  static const String vender = '/vender';
  static const String depositar = '/depositar';
  static const String enviar = '/enviar';
  static const String sacar = '/sacar';
  static const String receber = '/receber';
  // Central de notificações (placeholder para futuras versões)
  static const String notificacoes = '/notificacoes';

  // ── Mapa de Rotas ──────────────────────────────────────────────────
  // Getter que retorna o Map<String, WidgetBuilder> consumido pelo
  // parâmetro `routes:` do MaterialApp. Cada entrada mapeia uma string
  // de rota para uma função que constrói o widget correspondente.
  //
  // Nota: Várias rotas (balcao, investir, comprar, vender, carteira,
  // dashboard) apontam para o BalcaoNegociacaoPage (trade_market.dart),
  // pois no MVP acadêmico o balcão centraliza todas as operações de
  // negociação de tokens.
  static Map<String, WidgetBuilder> get routes => {
    // Dashboard principal — contém BottomNavigationBar com 4 abas
    mainRoute: (_) => const MainWrapperScreen(),
    // Tela de login com e-mail e senha
    login: (_) => const LoginPage(),
    // Tela de cadastro de novo usuário
    cadastro: (_) => const SignUpPage(),
    // Tela de recuperação de senha (envia e-mail via Firebase Auth)
    recuperarSenha: (_) => const RecuperarSenha(),
    // Tela de confirmação após envio do e-mail de recuperação
    emailEnviado: (_) => const EmailEnviado(),
    // Catálogo de startups com dados do Firestore
    catalogo: (_) => const CatalogoStartupsPage(),
    // Placeholder para rota de detalhes quando chamada sem argumento
    // (o fluxo normal usa Navigator.push com o objeto StartupDetail)
    startupDetalhes: (_) => const RoutePlaceholderPage(
      title: 'Detalhes da startup',
      subtitle: 'Use a lista para abrir uma startup real.',
      icon: Icons.business,
    ),
    // Todas estas rotas convergem para o BalcaoNegociacaoPage.
    // Isto simplifica a navegação no MVP: independente de onde o
    // utilizador clique (investir, comprar, vender), ele chega ao
    // mesmo ecrã de negociação unificado.
    balcao: (_) => const BalcaoNegociacaoPage(),
    investir: (_) => const BalcaoNegociacaoPage(),
    comprar: (_) => const BalcaoNegociacaoPage(),
    vender: (_) => const BalcaoNegociacaoPage(),
    carteira: (_) => const BalcaoNegociacaoPage(),
    dashboard: (_) => const BalcaoNegociacaoPage(),
    // Tela de depósito — chama Cloud Function `depositar`
    depositar: (_) => const DepositarScreen(),
    // Rota legada para depósito (mantida por compatibilidade de navegação)
    enviar: (_) => const RoutePlaceholderPage(
      title: 'Depositar',
      subtitle: 'Rota legada apontando para a funcao de deposito.',
      icon: Icons.arrow_upward,
    ),
    // Tela de saque — chama Cloud Function `sacar`
    sacar: (_) => const SacarScreen(),
    // Rota legada para saque (mantida por compatibilidade de navegação)
    receber: (_) => const RoutePlaceholderPage(
      title: 'Sacar',
      subtitle: 'Rota legada apontando para a funcao de saque.',
      icon: Icons.arrow_downward,
    ),
    // Placeholder para futura central de notificações push
    notificacoes: (_) => const RoutePlaceholderPage(
      title: 'Notificacoes',
      subtitle: 'Rota pronta para integrar a central de notificacoes.',
      icon: Icons.notifications_none,
    ),
    // ── Rota MFA — recebe o código OTP como argumento ────────────
    // Diferente das demais, esta rota precisa de um argumento
    // (o código esperado). Ele é passado via ModalRoute.settings.arguments
    // quando o Navigator.pushNamed é chamado com arguments: code.
    // Se o argumento for null (acesso direto à rota), usa string vazia
    // como fallback seguro para evitar crash.
    mfa: (context) {
      final code = ModalRoute.of(context)?.settings.arguments as String? ?? '';
      return MfaVerificationScreen(expectedCode: code);
    },
  };
}

// ── RoutePlaceholderPage — Página genérica para rotas não implementadas ─
// Widget reutilizável que exibe uma página de placeholder com ícone,
// título e subtítulo configuráveis. Utilizado para rotas que estão
// planejadas na arquitetura mas ainda não possuem tela dedicada no MVP.
//
// Parâmetros:
//   • title — texto principal exibido na AppBar e no corpo
//   • subtitle — descrição auxiliar do propósito da rota
//   • icon — ícone Material que representa visualmente a funcionalidade
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
    // Cor primária da marca utilizada nos elementos visuais do placeholder
    const primaryPurple = Color(0xFF5A2D91);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          // Ao clicar no botão voltar, reseta TODA a pilha de navegação
          // e redireciona para a rota principal (/main). Isto previne
          // que o utilizador fique preso num ciclo de placeholders.
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
              // Ícone representativo da funcionalidade
              Icon(icon, color: primaryPurple, size: 42),
              const SizedBox(height: 16),
              // Título principal da funcionalidade
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              // Descrição auxiliar com informação sobre o estado da rota
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

