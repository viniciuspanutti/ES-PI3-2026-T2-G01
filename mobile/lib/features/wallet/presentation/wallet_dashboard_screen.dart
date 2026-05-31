//feito por: Camila fernandes costacurta RA:25012949
// Importa a biblioteca para operações assíncronas como Future e Stream
import 'dart:async';

// Importa o sistema de autenticação de usuários do Firebase
import 'package:firebase_auth/firebase_auth.dart';
// Importa as classes base para inicialização do Firebase no aplicativo
import 'package:firebase_core/firebase_core.dart';
// Importa os widgets básicos e o framework Material Design do Flutter
import 'package:flutter/material.dart';
// Importa serviços do sistema como formatadores e estilos de interface
import 'package:flutter/services.dart';
// Importa as definições de rotas de navegação centralizadas do aplicativo
import 'package:mobile/core/routes/app_routes.dart';
// Importa os componentes visuais de seções de investimento da tela inicial
import 'package:mobile/features/dashboard/widgets/home_investiment_sections.dart';
// Importa widgets de navegação e cabeçalho da tela inicial
import 'package:mobile/features/dashboard/widgets/home_navigation_widgets.dart';
// Importa a definição do modelo de dados de detalhes de uma startup
import 'package:mobile/features/startups/domain/startup.dart';
// Importa a tela que exibe os detalhes completos de uma startup selecionada
import 'package:mobile/features/startups/presentation/screen/list/startup_detail_screen.dart';

// Função assíncrona para inicializar o Firebase se ainda não estiver configurado
Future<bool> _initializeFirebaseIfConfigured() async {
  try {
    // Verifica se a lista de aplicativos Firebase inicializados está vazia
    if (Firebase.apps.isEmpty) {
      // Executa a inicialização padrão do Firebase para a plataforma atual
      await Firebase.initializeApp();
    }
    // Retorna verdadeiro se existir pelo menos um aplicativo Firebase ativo
    return Firebase.apps.isNotEmpty;
  } catch (_) {
    // Retorna falso em caso de qualquer erro durante a inicialização
    return false;
  }
}

// Função auxiliar para extrair a primeira string válida de um mapa de valores
String? _firstString(Map<dynamic, dynamic> values, List<String> keys) {
  // Itera sobre a lista de chaves fornecidas em ordem de prioridade
  for (final key in keys) {
    // Obtém o valor associado à chave atual no mapa
    final value = values[key];
    // Retorna o valor se for uma string não vazia após remover espaços
    if (value is String && value.trim().isNotEmpty) return value.trim();
  }
  // Retorna nulo se nenhuma chave válida for encontrada com valor de string
  return null;
}
/**for (int i = 0; i < keys.length; i++) {
  // Pega a chave pela posição 'i'
  final key = keys[i];
  
  // Obtém o valor associado à chave
  final value = values[key];

  // Validação: se for String e não estiver vazia
  if (value is String && value.trim().isNotEmpty) {
    return value.trim();
  }
}
return null; */

// Função para normalizar e limpar espaços em branco de um nome de usuário
String? _normalizeUserName(String? value) {
  // Remove espaços extras do início e do fim da string
  final trimmed = value?.trim();
  // Retorna nulo se o resultado for nulo ou uma string vazia
  if (trimmed == null || trimmed.isEmpty) return null;
  // Retorna a string limpa e normalizada
  return trimmed;
}

// Função para gerar um nome de exibição a partir de um endereço de e-mail
String? _nameFromEmail(String? email) {
  // Extrai a parte do e-mail antes do símbolo '@' e remove espaços
  final rawName = email?.split('@').first.trim();
  // Retorna nulo se o nome extraído estiver vazio
  if (rawName == null || rawName.isEmpty) return null;

  // Formata o nome substituindo separadores por espaços e capitalizando palavras
  return rawName
      .replaceAll(RegExp(r'[._-]+'), ' ')
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .map((word) {
        // Capitaliza uma única letra se for o caso
        if (word.length == 1) return word.toUpperCase();
        // Capitaliza a primeira letra e torna o restante minúsculo
        return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
      })
      .join(' ');
}

// Define a tela principal da carteira como um widget que possui estado
class WalletDashboardScreen extends StatefulWidget {
  // Construtor da tela com suporte opcional a chaves de identificação
  const WalletDashboardScreen({super.key});

  // Cria o estado interno associado a este widget de dashboard
  @override
  State<WalletDashboardScreen> createState() => _WalletDashboardScreenState();
}

// Classe privada que gerencia o estado e a lógica da tela de dashboard
class _WalletDashboardScreenState extends State<WalletDashboardScreen> {
  // Booleano para alternar a visibilidade do saldo financeiro
  bool _showBalance = true;
  // Flag para garantir que os dados do usuário da rota sejam lidos apenas uma vez
  bool _didReadRouteUser = false;
  // Nome de exibição do usuário, com valor padrão 'Usuário'
  String _userName = 'Usu\u00e1rio';
  // URL da foto de perfil do usuário, opcional
  String? _userPhotoUrl;

  // Constantes de cores utilizadas para manter a identidade visual da tela
  static const _screenBackground = Color(0xFFF5F5F5);
  static const _primaryPurple = Color(0xFF5A2D91);
  static const _statusBlue = Color(0xFF4169FF);
  static const _positiveGreen = Color(0xFF18A71B);
  static const _softCard = Color(0xFFF7F7FA);

  // Método chamado automaticamente quando as dependências do widget mudam
  @override
  void didChangeDependencies() {
    // Chama a implementação original da classe pai
    super.didChangeDependencies();
    // Interrompe se os dados da rota já foram processados
    if (_didReadRouteUser) return;

    // Marca que a leitura dos dados da rota foi iniciada
    _didReadRouteUser = true;
    // Extrai dados do usuário passados como argumentos de navegação
    _applyRouteUserData(ModalRoute.of(context)?.settings.arguments);
    // Inicia o carregamento assíncrono dos dados do Firebase sem aguardar
    unawaited(_loadFirebaseUserData());
  }

  // Método para alternar o estado de visibilidade do saldo na tela
  void _toggleBalanceVisibility() {
    // Atualiza o estado interno e solicita a reconstrução da interface
    setState(() => _showBalance = !_showBalance);
  }

  // Método para exibir uma mensagem temporária na parte inferior da tela
  void _showMessage(String message) {
    // Acessa o gerenciador de mensagens da tela atual
    ScaffoldMessenger.of(context)
      // Remove notificações pendentes antes de mostrar a nova
      ..clearSnackBars()
      // Exibe a nova notificação com estilo flutuante e duração definida
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 1600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
  }

  // Método para navegar para uma rota específica definida pelo nome
  void _openRoute(String routeName) {
    // Utiliza o navegador para empurrar a nova rota na pilha de telas
    Navigator.of(context).pushNamed(routeName);
  }

  // Método para abrir a tela de detalhes de uma startup específica
  void _openStartupDetails(StartupDetail startup) {
    // Navega para a tela de detalhes passando o objeto da startup
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => StartupDetailScreen(startup: startup),
      ),
    );
  }

  // Método para forçar a recarga visual da seção de investimentos
  void _reloadInvestments() {
    // Simplesmente solicita a reconstrução do widget de estado
    setState(() {});
  }

  // Método para extrair e aplicar dados do usuário vindos de argumentos de rota
  void _applyRouteUserData(Object? arguments) {
    // Verifica se os argumentos são do tipo Mapa antes de prosseguir
    if (arguments is! Map) return;

    // Tenta encontrar um nome válido em várias chaves possíveis do mapa
    final name = _firstString(arguments, const [
      'name',
      'displayName',
      'userName',
      'nome',
    ]);
    // Tenta encontrar uma URL de foto em várias chaves possíveis do mapa
    final photoUrl = _firstString(arguments, const [
      'photoUrl',
      'photoURL',
      'avatarUrl',
      'profilePhotoUrl',
      'foto',
    ]);

    // Interrompe se nenhum dado útil for encontrado nos argumentos
    if (name == null && photoUrl == null) return;
    // Atualiza as variáveis de estado com os novos dados normalizados
    _userName = _normalizeUserName(name) ?? _userName;
    _userPhotoUrl = photoUrl ?? _userPhotoUrl;
  }

  // Método assíncrono para carregar dados do perfil diretamente do Firebase Auth
  Future<void> _loadFirebaseUserData() async {
    // Tenta inicializar o Firebase com um tempo limite de 6 segundos
    final initialized = await _initializeFirebaseIfConfigured().timeout(
      const Duration(seconds: 6),
      onTimeout: () => false,
    );
    // Interrompe se o Firebase não puder ser inicializado a tempo
    if (!initialized) return;

    // Obtém a instância do usuário autenticado no Firebase
    final user = FirebaseAuth.instance.currentUser;
    // Interrompe se não houver um usuário logado no momento
    if (user == null) return;

    // Resolve o nome de exibição priorizando dados do perfil, depois e-mail
    final resolvedName =
        _normalizeUserName(user.displayName) ??
        _nameFromEmail(user.email) ??
        _normalizeUserName(user.email);

    // Garante que o widget ainda está montado antes de atualizar o estado
    if (!mounted) return;
    // Atualiza as variáveis de exibição com os dados reais do Firebase
    setState(() {
      _userName = resolvedName ?? _userName;
      _userPhotoUrl = user.photoURL ?? _userPhotoUrl;
    });
  }



  // Método responsável por construir a estrutura visual da tela
  @override
  Widget build(BuildContext context) {
    // Configura os ícones da barra de status do sistema como escuros
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      // Retorna a estrutura básica de layout da página
      child: Scaffold(
        backgroundColor: _screenBackground,
        // Garante que o conteúdo não seja sobreposto por entalhes da tela
        body: SafeArea(
          // Fornece informações sobre as restrições de tamanho da tela
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Limita a largura máxima do conteúdo para 390 pixels (visual mobile)
              final screenWidth = constraints.maxWidth < 390
                  ? constraints.maxWidth
                  : 390.0;

              // Centraliza o conteúdo horizontalmente no topo da tela
              return Align(
                alignment: Alignment.topCenter,
                // Define as dimensões do container principal de conteúdo
                child: SizedBox(
                  width: screenWidth,
                  height: constraints.maxHeight,
                  // Permite a rolagem vertical do conteúdo com efeito de mola
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    // Adiciona preenchimento interno em toda a área rolável
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                    // Organiza os componentes principais em uma coluna vertical
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Widget de cabeçalho contendo perfil, nome e botão de saldo
                        HomeHeader(
                          primaryPurple: _primaryPurple,
                          userName: _userName,
                          userPhotoUrl: _userPhotoUrl,
                          showBalance: _showBalance,
                          onToggleVisibility: _toggleBalanceVisibility,
                          // Define a ação ao clicar no ícone de notificações
                          onNotificationsTap: () =>
                              _openRoute(AppRoutes.notificacoes),
                        ),
                        // Adiciona um espaçamento vertical de 24 pixels
                        const SizedBox(height: 24),
                        // Widget do cartão da carteira que exibe o saldo financeiro
                        WalletCard(
                          primaryPurple: _primaryPurple,
                          showBalance: _showBalance,
                          // Navega para a tela completa da carteira ao tocar no cartão
                          onCardTap: () => _openRoute(AppRoutes.carteira),
                          // Exibe mensagem de opções ao clicar no botão de "mais"
                          onMoreTap: () => _showMessage(
                            'Op\u00e7\u00f5es da carteira',
                          ),
                        ),
                        // Adiciona um espaçamento vertical de 26 pixels
                        const SizedBox(height: 26),
                        // Widget que exibe botões de ações rápidas de navegação
                        QuickActions(onRouteTap: _openRoute),
                        // Adiciona um espaçamento vertical de 24 pixels
                        const SizedBox(height: 24),
                        // Widget que exibe as seções de investimentos vindas do Firestore
                        FirestoreInvestmentSections(
                          userId: FirebaseAuth.instance.currentUser?.uid,
                          backgroundColor: _softCard,
                          statusColor: _statusBlue,
                          growthColor: _positiveGreen,
                          onRetry: _reloadInvestments,
                          // Navega para o catálogo completo ao clicar em "Ver todos"
                          onViewAllTap: () =>
                              _openRoute(AppRoutes.catalogo),
                          // Abre os detalhes da startup ao tocar em um investimento
                          onStartupTap: _openStartupDetails,
                          // Exibe mensagem de opções adicionais de investimentos
                          onMoreTap: () => _showMessage(
                            'Op\u00e7\u00f5es dos investimentos',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
