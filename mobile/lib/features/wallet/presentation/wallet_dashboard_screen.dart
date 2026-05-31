// GUILHERME PREVENTI CORREIA

// =============================================================================
// SECAO: IMPORTACOES
// =============================================================================
// Analise da Linha: import 'dart:async';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'dart:async' = URI da Biblioteca. Indica que recursos assincronos, como Future e unawaited, serao usados.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'dart:async';

// Analise da Linha: import 'package:firebase_auth/firebase_auth.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:firebase_auth/firebase_auth.dart' = URI da Biblioteca. Disponibiliza os recursos de autenticacao do Firebase.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:firebase_auth/firebase_auth.dart';
// Analise da Linha: import 'package:firebase_core/firebase_core.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:firebase_core/firebase_core.dart' = URI da Biblioteca. Disponibiliza a inicializacao base do Firebase.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:firebase_core/firebase_core.dart';
// Analise da Linha: import 'package:flutter/material.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:flutter/material.dart' = URI da Biblioteca. Disponibiliza widgets e estilos do Material Design.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:flutter/material.dart';
// Analise da Linha: import 'package:flutter/services.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:flutter/services.dart' = URI da Biblioteca. Disponibiliza controle de servicos do sistema, como barra de status.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:flutter/services.dart';
// Analise da Linha: import 'package:mobile/core/routes/app_routes.dart';
// import = Diretiva de Importacao. Traz uma biblioteca interna do projeto para este arquivo Dart.
// 'package:mobile/core/routes/app_routes.dart' = URI da Biblioteca. Disponibiliza os nomes das rotas do aplicativo.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:mobile/core/routes/app_routes.dart';
// Analise da Linha: import 'package:mobile/features/dashboard/widgets/home_investiment_sections.dart';
// import = Diretiva de Importacao. Traz uma biblioteca interna do projeto para este arquivo Dart.
// 'package:mobile/features/dashboard/widgets/home_investiment_sections.dart' = URI da Biblioteca. Disponibiliza as secoes de investimentos da tela inicial.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:mobile/features/dashboard/widgets/home_investiment_sections.dart';
// Analise da Linha: import 'package:mobile/features/dashboard/widgets/home_navigation_widgets.dart';
// import = Diretiva de Importacao. Traz uma biblioteca interna do projeto para este arquivo Dart.
// 'package:mobile/features/dashboard/widgets/home_navigation_widgets.dart' = URI da Biblioteca. Disponibiliza widgets de navegacao e cabecalho da home.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:mobile/features/dashboard/widgets/home_navigation_widgets.dart';
// Analise da Linha: import 'package:mobile/features/startups/domain/startup.dart';
// import = Diretiva de Importacao. Traz uma biblioteca interna do projeto para este arquivo Dart.
// 'package:mobile/features/startups/domain/startup.dart' = URI da Biblioteca. Disponibiliza o modelo de dominio StartupDetail.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:mobile/features/startups/domain/startup.dart';
// Analise da Linha: import 'package:mobile/features/startups/presentation/screen/list/startup_detail_screen.dart';
// import = Diretiva de Importacao. Traz uma biblioteca interna do projeto para este arquivo Dart.
// 'package:mobile/features/startups/presentation/screen/list/startup_detail_screen.dart' = URI da Biblioteca. Disponibiliza a tela de detalhes de startup.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:mobile/features/startups/presentation/screen/list/startup_detail_screen.dart';

// =============================================================================
// SECAO: FUNCAO: _initializeFirebaseIfConfigured
// =============================================================================
// Analise da Linha: Future<bool> _initializeFirebaseIfConfigured() async {
// Future<bool> = Tipo de Retorno Assincrono. Indica que a funcao entregara um bool no futuro.
// _initializeFirebaseIfConfigured = Identificador da Funcao Privada. O underline restringe o acesso ao arquivo atual.
// async = Modificador Assincrono. Permite usar await dentro do corpo da funcao.
// { = Abertura de Bloco. Inicia o corpo da funcao.
Future<bool> _initializeFirebaseIfConfigured() async {
  // Analise da Linha: try {
  // try = Palavra-chave de Tentativa. Inicia um bloco cujo erro pode ser capturado.
  // { = Abertura de Bloco. Inicia o escopo protegido contra excecoes.
  try {
    // Analise da Linha: if (Firebase.apps.isEmpty) {
    // if = Estrutura Condicional. Executa o bloco apenas se a condicao for verdadeira.
    // Firebase.apps.isEmpty = Expressao Booleana. Verifica se ainda nao existe app Firebase inicializado.
    // { = Abertura de Bloco. Inicia o corpo da condicao.
    if (Firebase.apps.isEmpty) {
      // Analise da Linha: await Firebase.initializeApp();
      // await = Operador de Espera Assincrona. Aguarda a conclusao da inicializacao.
      // Firebase.initializeApp() = Chamada de Metodo. Inicializa o Firebase padrao do aplicativo.
      // ; = Finalizador de Instrucao. Operador que indica o fim da chamada.
      await Firebase.initializeApp();
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o corpo da condicao if.
    }
    // Analise da Linha: return Firebase.apps.isNotEmpty;
    // return = Palavra-chave de Retorno. Entrega um valor como resultado da funcao.
    // Firebase.apps.isNotEmpty = Expressao Booleana. Confirma se existe ao menos um app Firebase inicializado.
    // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
    return Firebase.apps.isNotEmpty;
  // Analise da Linha: } catch (_) {
  // catch = Captura de Excecao. Executa o bloco quando o try dispara erro.
  // _ = Identificador Descartavel. Recebe o erro sem usa-lo dentro do bloco.
  // { = Abertura de Bloco. Inicia o tratamento da falha.
  } catch (_) {
    // Analise da Linha: return false;
    // return = Palavra-chave de Retorno. Entrega um valor como resultado da funcao.
    // false = Literal Booleano. Indica que a inicializacao nao foi concluida.
    // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
    return false;
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o bloco catch.
  }
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o corpo da funcao.
}

// =============================================================================
// SECAO: FUNCAO: _firstString
// =============================================================================
// Analise da Linha: String? _firstString(Map<dynamic, dynamic> values, List<String> keys) {
// String? = Tipo de Retorno Nulavel. Indica que a funcao pode retornar texto ou null.
// _firstString = Identificador da Funcao Privada. O underline restringe o acesso ao arquivo atual.
// Map<dynamic, dynamic> e List<String> = Tipos dos Parametros. Recebem o mapa de valores e a lista de chaves buscadas.
// { = Abertura de Bloco. Inicia o corpo da funcao.
String? _firstString(Map<dynamic, dynamic> values, List<String> keys) {
  // Analise da Linha: for (final key in keys) {
  // for = Estrutura de Repeticao. Percorre cada item da lista.
  // final key in keys = Declaracao de Iteracao. Cria uma chave imutavel para cada elemento de keys.
  // { = Abertura de Bloco. Inicia o corpo do loop.
  for (final key in keys) {
    // Analise da Linha: final value = values[key];
    // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
    // value = Identificador da Variavel. Guarda o conteudo encontrado no mapa para a chave atual.
    // values[key] = Acesso por Chave. Busca o valor correspondente dentro do Map.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
    final value = values[key];
    // Analise da Linha: if (value is String && value.trim().isNotEmpty) return value.trim();
    // if = Estrutura Condicional. Executa o retorno apenas se a condicao for verdadeira.
    // value is String = Verificacao de Tipo. Confirma que o valor encontrado e texto.
    // && = Operador Logico E. Exige que as duas condicoes sejam verdadeiras.
    // return value.trim(); = Retorno Condicional. Entrega o texto sem espacos nas pontas.
    if (value is String && value.trim().isNotEmpty) return value.trim();
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o corpo do loop for.
  }
  // Analise da Linha: return null;
  // return = Palavra-chave de Retorno. Entrega um valor como resultado da funcao.
  // null = Literal Nulo. Indica que nenhuma string valida foi encontrada.
  // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
  return null;
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o corpo da funcao.
}

// =============================================================================
// SECAO: FUNCAO: _normalizeUserName
// =============================================================================
// Analise da Linha: String? _normalizeUserName(String? value) {
// String? = Tipo de Retorno Nulavel. Indica que a funcao pode retornar texto ou null.
// _normalizeUserName = Identificador da Funcao Privada. Normaliza o nome recebido.
// String? value = Parametro Nulavel. Aceita um texto ou null como entrada.
// { = Abertura de Bloco. Inicia o corpo da funcao.
String? _normalizeUserName(String? value) {
  // Analise da Linha: final trimmed = value?.trim();
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // trimmed = Identificador da Variavel. Guarda o texto sem espacos nas extremidades.
  // value?.trim() = Chamada Condicional Nula. Executa trim apenas se value nao for null.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final trimmed = value?.trim();
  // Analise da Linha: if (trimmed == null || trimmed.isEmpty) return null;
  // if = Estrutura Condicional. Executa o retorno apenas se a condicao for verdadeira.
  // trimmed == null = Comparacao com Nulo. Verifica se nao existe texto.
  // || = Operador Logico OU. Aceita qualquer uma das condicoes como suficiente.
  // return null; = Retorno Nulo. Informa que o nome nao e valido.
  if (trimmed == null || trimmed.isEmpty) return null;
  // Analise da Linha: return trimmed;
  // return = Palavra-chave de Retorno. Entrega um valor como resultado da funcao.
  // trimmed = Valor Normalizado. Texto ja limpo e validado.
  // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
  return trimmed;
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o corpo da funcao.
}

// =============================================================================
// SECAO: FUNCAO: _nameFromEmail
// =============================================================================
// Analise da Linha: String? _nameFromEmail(String? email) {
// String? = Tipo de Retorno Nulavel. Indica que a funcao pode retornar texto ou null.
// _nameFromEmail = Identificador da Funcao Privada. Tenta derivar um nome a partir do e-mail.
// String? email = Parametro Nulavel. Aceita um e-mail em texto ou null.
// { = Abertura de Bloco. Inicia o corpo da funcao.
String? _nameFromEmail(String? email) {
  // Analise da Linha: final rawName = email?.split('@').first.trim();
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // rawName = Identificador da Variavel. Guarda a parte do e-mail antes do arroba.
  // email?.split('@').first.trim() = Cadeia de Transformacao. Divide o e-mail, pega a primeira parte e remove espacos.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final rawName = email?.split('@').first.trim();
  // Analise da Linha: if (rawName == null || rawName.isEmpty) return null;
  // if = Estrutura Condicional. Executa o retorno apenas se a condicao for verdadeira.
  // rawName == null = Comparacao com Nulo. Verifica se nao ha nome base.
  // || = Operador Logico OU. Aceita qualquer uma das condicoes como suficiente.
  // return null; = Retorno Nulo. Informa que nao foi possivel criar nome pelo e-mail.
  if (rawName == null || rawName.isEmpty) return null;

  // Analise da Linha: return rawName
  // return = Palavra-chave de Retorno. Entrega o resultado da cadeia de transformacoes.
  // rawName = Valor Base. Texto inicial usado para montar o nome exibivel.
  // linha seguinte = Continuacao Sintatica. A expressao continua nas proximas linhas encadeadas.
  return rawName
      // Analise da Linha: .replaceAll(RegExp(r'[._-]+'), ' ')
      // .replaceAll = Metodo de Substituicao. Troca padroes encontrados dentro do texto.
      // RegExp(r'[._-]+') = Expressao Regular. Encontra pontos, underlines e hifens repetidos.
      // ' ' = Literal de String. Define espaco como substituto.
      // linha seguinte = Continuacao Sintatica. A cadeia de metodos continua abaixo.
      .replaceAll(RegExp(r'[._-]+'), ' ')
      // Analise da Linha: .split(RegExp(r'\s+'))
      // .split = Metodo de Separacao. Divide o texto em partes.
      // RegExp(r'\s+') = Expressao Regular. Encontra um ou mais espacos em branco.
      // linha seguinte = Continuacao Sintatica. A cadeia de metodos continua abaixo.
      .split(RegExp(r'\s+'))
      // Analise da Linha: .where((word) => word.isNotEmpty)
      // .where = Metodo de Filtro. Mantem apenas elementos que passam na condicao.
      // (word) => word.isNotEmpty = Funcao Anonima. Aceita somente palavras nao vazias.
      // linha seguinte = Continuacao Sintatica. A cadeia de metodos continua abaixo.
      .where((word) => word.isNotEmpty)
      // Analise da Linha: .map((word) {
      // .map = Metodo de Transformacao. Converte cada palavra em outro formato.
      // (word) = Parametro da Funcao Anonima. Representa a palavra atual.
      // { = Abertura de Bloco. Inicia o corpo da transformacao.
      .map((word) {
        // Analise da Linha: if (word.length == 1) return word.toUpperCase();
        // if = Estrutura Condicional. Executa o retorno apenas se a palavra tiver uma letra.
        // word.length == 1 = Expressao Booleana. Verifica o tamanho da palavra.
        // return word.toUpperCase(); = Retorno Condicional. Converte a letra unica para maiuscula.
        // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
        if (word.length == 1) return word.toUpperCase();
        // Analise da Linha: return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
        // return = Palavra-chave de Retorno. Entrega a palavra capitalizada.
        // '${...}${...}' = Interpolacao de String. Junta a primeira letra maiuscula com o restante minusculo.
        // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
        return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
      // Analise da Linha: })
      // }) = Fechamento de Funcao e Metodo. Encerra o bloco do map.
      // linha seguinte = Continuacao Sintatica. A cadeia de metodos continua abaixo.
      })
      // Analise da Linha: .join(' ');
      // .join = Metodo de Juncao. Une os itens da lista em uma unica string.
      // ' ' = Literal de String. Define espaco como separador entre palavras.
      // ; = Finalizador de Instrucao. Operador que indica o fim do retorno encadeado.
      .join(' ');
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o corpo da funcao.
}

// =============================================================================
// SECAO: CLASSE: WalletDashboardScreen
// =============================================================================
// Analise da Linha: class WalletDashboardScreen extends StatefulWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// WalletDashboardScreen = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa tela.
// extends = Relacao de Heranca. Indica que a classe recebe comportamento base de StatefulWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class WalletDashboardScreen extends StatefulWidget {
  // =============================================================================
  // SECAO: CONSTRUTOR: WalletDashboardScreen
  // =============================================================================
  // Analise da Linha: const WalletDashboardScreen({super.key});
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // WalletDashboardScreen = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // {super.key} = Parametro Nomeado Encaminhado. Repassa a chave para a classe pai do widget.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao do construtor.
  const WalletDashboardScreen({super.key});

  // Analise da Linha: @override
  // @override = Anotacao de Sobrescrita. Informa que o metodo abaixo substitui um metodo herdado.
  @override
  // Analise da Linha: State<WalletDashboardScreen> createState() => _WalletDashboardScreenState();
  // State<WalletDashboardScreen> = Tipo de Retorno. Indica o objeto de estado associado a este widget.
  // createState = Identificador do Metodo. Metodo chamado pelo Flutter para criar o estado da tela.
  // => = Arrow Function. Retorna a expressao da direita de forma compacta.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao do metodo.
  State<WalletDashboardScreen> createState() => _WalletDashboardScreenState();
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o corpo da classe WalletDashboardScreen.
}

// =============================================================================
// SECAO: CLASSE: _WalletDashboardScreenState
// =============================================================================
// Analise da Linha: class _WalletDashboardScreenState extends State<WalletDashboardScreen> {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// _WalletDashboardScreenState = Identificador da Classe Privada. O underline restringe o acesso ao arquivo atual.
// extends = Relacao de Heranca. Indica que a classe recebe comportamento de State para WalletDashboardScreen.
// { = Abertura de Bloco. Inicia o corpo da classe de estado.
class _WalletDashboardScreenState extends State<WalletDashboardScreen> {
  // Analise da Linha: bool _showBalance = true;
  // bool = Tipo Booleano. Aceita apenas verdadeiro ou falso.
  // _showBalance = Identificador da Variavel Privada. Controla se os valores da carteira aparecem na tela.
  // true = Literal Booleano. Define que o saldo aparece inicialmente.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  bool _showBalance = true;
  // Analise da Linha: bool _didReadRouteUser = false;
  // bool = Tipo Booleano. Aceita apenas verdadeiro ou falso.
  // _didReadRouteUser = Identificador da Variavel Privada. Registra se os dados da rota ja foram lidos.
  // false = Literal Booleano. Define que a leitura ainda nao aconteceu.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  bool _didReadRouteUser = false;
  // Analise da Linha: String _userName = 'Usu\u00e1rio';
  // String = Tipo de Texto. Armazena uma sequencia de caracteres.
  // _userName = Identificador da Variavel Privada. Guarda o nome mostrado no cabecalho.
  // 'Usu\u00e1rio' = Literal de String. Define o texto padrao para usuario sem nome resolvido.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  String _userName = 'Usu\u00e1rio';
  // Analise da Linha: String? _userPhotoUrl;
  // String? = Tipo de Texto Nulavel. Permite guardar uma URL ou null.
  // _userPhotoUrl = Identificador da Variavel Privada. Guarda a foto do usuario quando existir.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  String? _userPhotoUrl;

  // =============================================================================
  // SECAO: CONSTANTES VISUAIS
  // =============================================================================
  // Analise da Linha: static const _screenBackground = Color(0xFFF5F5F5);
  // static = Modificador de Membro de Classe. Liga a constante a classe, nao a instancia.
  // const = Modificador de Constante. Define valor conhecido e imutavel em tempo de compilacao.
  // _screenBackground = Identificador da Constante Privada. Guarda a cor de fundo da tela.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  static const _screenBackground = Color(0xFFF5F5F5);
  // Analise da Linha: static const _primaryPurple = Color(0xFF5A2D91);
  // static = Modificador de Membro de Classe. Liga a constante a classe, nao a instancia.
  // const = Modificador de Constante. Define valor conhecido e imutavel em tempo de compilacao.
  // _primaryPurple = Identificador da Constante Privada. Guarda a cor roxa principal da interface.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  static const _primaryPurple = Color(0xFF5A2D91);
  // Analise da Linha: static const _statusBlue = Color(0xFF4169FF);
  // static = Modificador de Membro de Classe. Liga a constante a classe, nao a instancia.
  // const = Modificador de Constante. Define valor conhecido e imutavel em tempo de compilacao.
  // _statusBlue = Identificador da Constante Privada. Guarda a cor azul usada em status.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  static const _statusBlue = Color(0xFF4169FF);
  // Analise da Linha: static const _positiveGreen = Color(0xFF18A71B);
  // static = Modificador de Membro de Classe. Liga a constante a classe, nao a instancia.
  // const = Modificador de Constante. Define valor conhecido e imutavel em tempo de compilacao.
  // _positiveGreen = Identificador da Constante Privada. Guarda a cor verde usada para valores positivos.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  static const _positiveGreen = Color(0xFF18A71B);
  // Analise da Linha: static const _softCard = Color(0xFFF7F7FA);
  // static = Modificador de Membro de Classe. Liga a constante a classe, nao a instancia.
  // const = Modificador de Constante. Define valor conhecido e imutavel em tempo de compilacao.
  // _softCard = Identificador da Constante Privada. Guarda a cor suave usada em cards.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  static const _softCard = Color(0xFFF7F7FA);

  // =============================================================================
  // SECAO: CICLO DE VIDA: didChangeDependencies
  // =============================================================================
  // Analise da Linha: @override
  // @override = Anotacao de Sobrescrita. Informa que o metodo abaixo substitui um metodo herdado.
  @override
  // Analise da Linha: void didChangeDependencies() {
  // void = Tipo de Retorno Vazio. Indica que o metodo nao entrega valor.
  // didChangeDependencies = Identificador do Metodo. Metodo do ciclo de vida chamado quando dependencias mudam.
  // () = Lista de Parametros Vazia. Indica que o metodo nao recebe argumentos.
  // { = Abertura de Bloco. Inicia o corpo do metodo.
  void didChangeDependencies() {
    // Analise da Linha: super.didChangeDependencies();
    // super = Referencia a Classe Pai. Acessa a implementacao herdada de State.
    // didChangeDependencies() = Chamada de Metodo. Mantem o comportamento padrao do ciclo de vida.
    // ; = Finalizador de Instrucao. Operador que indica o fim da chamada.
    super.didChangeDependencies();
    // Analise da Linha: if (_didReadRouteUser) return;
    // if = Estrutura Condicional. Executa o retorno apenas se a condicao for verdadeira.
    // _didReadRouteUser = Variavel de Controle. Indica se os argumentos da rota ja foram lidos.
    // return = Saida Antecipada. Encerra o metodo para evitar leitura duplicada.
    // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
    if (_didReadRouteUser) return;

    // Analise da Linha: _didReadRouteUser = true;
    // _didReadRouteUser = Variavel de Controle. Marca que a leitura dos dados da rota aconteceu.
    // = = Operador de Atribuicao. Coloca o valor da direita dentro da variavel da esquerda.
    // true = Literal Booleano. Define estado verdadeiro.
    // ; = Finalizador de Instrucao. Operador que indica o fim da atribuicao.
    _didReadRouteUser = true;
    // Analise da Linha: _applyRouteUserData(ModalRoute.of(context)?.settings.arguments);
    // _applyRouteUserData = Chamada de Metodo Privado. Aplica os dados recebidos pela rota.
    // ModalRoute.of(context)?.settings.arguments = Acesso Condicional. Busca argumentos da rota atual quando existirem.
    // ; = Finalizador de Instrucao. Operador que indica o fim da chamada.
    _applyRouteUserData(ModalRoute.of(context)?.settings.arguments);
    // Analise da Linha: unawaited(_loadFirebaseUserData());
    // unawaited = Funcao de Execucao Sem Espera. Dispara o Future sem bloquear o metodo atual.
    // _loadFirebaseUserData() = Chamada de Metodo Privado. Carrega dados do usuario autenticado.
    // ; = Finalizador de Instrucao. Operador que indica o fim da chamada.
    unawaited(_loadFirebaseUserData());
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o corpo do metodo didChangeDependencies.
  }

  // =============================================================================
  // SECAO: METODO: _toggleBalanceVisibility
  // =============================================================================
  // Analise da Linha: void _toggleBalanceVisibility() {
  // void = Tipo de Retorno Vazio. Indica que o metodo nao entrega valor.
  // _toggleBalanceVisibility = Identificador do Metodo Privado. Alterna a visibilidade do saldo.
  // () = Lista de Parametros Vazia. Indica que o metodo nao recebe argumentos.
  // { = Abertura de Bloco. Inicia o corpo do metodo.
  void _toggleBalanceVisibility() {
    // Analise da Linha: setState(() => _showBalance = !_showBalance);
    // setState = Metodo de Atualizacao Visual. Avisa ao Flutter que o estado mudou.
    // () => _showBalance = !_showBalance = Funcao Anonima Compacta. Inverte o valor booleano atual.
    // ! = Operador de Negacao. Transforma true em false e false em true.
    // ; = Finalizador de Instrucao. Operador que indica o fim da chamada.
    setState(() => _showBalance = !_showBalance);
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o corpo do metodo _toggleBalanceVisibility.
  }

  // =============================================================================
  // SECAO: METODO: _showMessage
  // =============================================================================
  // Analise da Linha: void _showMessage(String message) {
  // void = Tipo de Retorno Vazio. Indica que o metodo nao entrega valor.
  // _showMessage = Identificador do Metodo Privado. Exibe uma mensagem temporaria na tela.
  // String message = Parametro Tipado. Recebe o texto que sera mostrado no SnackBar.
  // { = Abertura de Bloco. Inicia o corpo do metodo.
  void _showMessage(String message) {
    // Analise da Linha: ScaffoldMessenger.of(context)
    // ScaffoldMessenger.of = Acesso ao Mensageiro da Tela. Obtém o controlador de SnackBars pelo context.
    // context = Contexto do Widget. Localiza a posicao atual na arvore de widgets.
    // linha seguinte = Continuacao Sintatica. A chamada usa operadores em cascata nas linhas seguintes.
    ScaffoldMessenger.of(context)
      // Analise da Linha: ..clearSnackBars()
      // .. = Operador de Cascata. Chama metodo no mesmo objeto retornado anteriormente.
      // clearSnackBars() = Chamada de Metodo. Remove mensagens anteriores da fila.
      // linha seguinte = Continuacao Sintatica. A cascata continua abaixo.
      ..clearSnackBars()
      // Analise da Linha: ..showSnackBar(
      // .. = Operador de Cascata. Chama metodo no mesmo ScaffoldMessenger.
      // showSnackBar = Metodo de Exibicao. Mostra uma barra de mensagem temporaria.
      // ( = Delimitador de Argumentos. Inicia os parametros da chamada.
      ..showSnackBar(
        // Analise da Linha: SnackBar(
        // SnackBar = Construtor de Widget. Cria a mensagem visual temporaria.
        // ( = Delimitador de Argumentos. Inicia a configuracao do SnackBar.
        SnackBar(
          // Analise da Linha: content: Text(message),
          // content = Parametro Nomeado. Define o conteudo textual do SnackBar.
          // Text(message) = Widget de Texto. Renderiza a mensagem recebida.
          // , = Separador de Argumento. Indica que outros parametros seguem.
          content: Text(message),
          // Analise da Linha: behavior: SnackBarBehavior.floating,
          // behavior = Parametro Nomeado. Define o comportamento visual do SnackBar.
          // SnackBarBehavior.floating = Valor Enumerado. Faz o SnackBar flutuar sobre o conteudo.
          // , = Separador de Argumento. Indica que outros parametros seguem.
          behavior: SnackBarBehavior.floating,
          // Analise da Linha: duration: const Duration(milliseconds: 1600),
          // duration = Parametro Nomeado. Define por quanto tempo a mensagem aparece.
          // const Duration(milliseconds: 1600) = Objeto de Duracao. Configura 1600 milissegundos.
          // , = Separador de Argumento. Indica que outros parametros seguem.
          duration: const Duration(milliseconds: 1600),
          // Analise da Linha: shape: RoundedRectangleBorder(
          // shape = Parametro Nomeado. Define o formato externo do SnackBar.
          // RoundedRectangleBorder = Construtor de Borda. Cria uma borda retangular arredondada.
          // ( = Delimitador de Argumentos. Inicia a configuracao do formato.
          shape: RoundedRectangleBorder(
            // Analise da Linha: borderRadius: BorderRadius.circular(14),
            // borderRadius = Parametro Nomeado. Define o arredondamento da borda.
            // BorderRadius.circular(14) = Construtor de Raio. Aplica 14 pixels de arredondamento.
            // , = Separador de Argumento. Indica fim deste parametro.
            borderRadius: BorderRadius.circular(14),
          // Analise da Linha: ),
          // ) = Fechamento de Chamada. Encerra o construtor RoundedRectangleBorder.
          // , = Separador de Argumento. Indica fim do parametro shape.
          ),
        // Analise da Linha: ),
        // ) = Fechamento de Chamada. Encerra o construtor SnackBar.
        // , = Separador de Argumento. Indica fim do argumento de showSnackBar.
        ),
      // Analise da Linha: );
      // ) = Fechamento de Chamada. Encerra o metodo showSnackBar.
      // ; = Finalizador de Instrucao. Encerra toda a cadeia de cascata.
      );
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o corpo do metodo _showMessage.
  }

  // =============================================================================
  // SECAO: METODO: _openRoute
  // =============================================================================
  // Analise da Linha: void _openRoute(String routeName) {
  // void = Tipo de Retorno Vazio. Indica que o metodo nao entrega valor.
  // _openRoute = Identificador do Metodo Privado. Abre uma rota nomeada no aplicativo.
  // String routeName = Parametro Tipado. Recebe o nome tecnico da rota.
  // { = Abertura de Bloco. Inicia o corpo do metodo.
  void _openRoute(String routeName) {
    // Analise da Linha: Navigator.of(context).pushNamed(routeName);
    // Navigator.of(context) = Acesso ao Navegador. Obtém o gerenciador de rotas pelo contexto atual.
    // pushNamed(routeName) = Chamada de Metodo. Empilha a rota identificada pelo nome recebido.
    // ; = Finalizador de Instrucao. Operador que indica o fim da chamada.
    Navigator.of(context).pushNamed(routeName);
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o corpo do metodo _openRoute.
  }

  // =============================================================================
  // SECAO: METODO: _openStartupDetails
  // =============================================================================
  // Analise da Linha: void _openStartupDetails(StartupDetail startup) {
  // void = Tipo de Retorno Vazio. Indica que o metodo nao entrega valor.
  // _openStartupDetails = Identificador do Metodo Privado. Abre a tela de detalhes da startup.
  // StartupDetail startup = Parametro Tipado. Recebe a startup que sera detalhada.
  // { = Abertura de Bloco. Inicia o corpo do metodo.
  void _openStartupDetails(StartupDetail startup) {
    // Analise da Linha: Navigator.of(context).push(
    // Navigator.of(context) = Acesso ao Navegador. Obtém o gerenciador de telas pelo contexto atual.
    // push = Metodo de Navegacao. Empilha uma nova rota customizada.
    // ( = Delimitador de Argumentos. Inicia os parametros da chamada.
    Navigator.of(context).push(
      // Analise da Linha: MaterialPageRoute<void>(
      // MaterialPageRoute<void> = Construtor de Rota Material. Cria transicao de pagina com retorno vazio.
      // <void> = Tipo Generico. Indica que a rota nao retorna dado significativo.
      // ( = Delimitador de Argumentos. Inicia a configuracao da rota.
      MaterialPageRoute<void>(
        // Analise da Linha: builder: (_) => StartupDetailScreen(startup: startup),
        // builder = Parametro Nomeado. Define como construir a tela da rota.
        // _ = Parametro Descartado. Recebe o BuildContext sem usa-lo.
        // => = Arrow Function. Retorna a tela de detalhes de forma compacta.
        // , = Separador de Argumento. Indica fim do parametro builder.
        builder: (_) => StartupDetailScreen(startup: startup),
      // Analise da Linha: ),
      // ) = Fechamento de Chamada. Encerra o construtor MaterialPageRoute.
      // , = Separador de Argumento. Indica fim do argumento de push.
      ),
    // Analise da Linha: );
    // ) = Fechamento de Chamada. Encerra o metodo push.
    // ; = Finalizador de Instrucao. Operador que indica o fim da chamada.
    );
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o corpo do metodo _openStartupDetails.
  }

  // =============================================================================
  // SECAO: METODO: _reloadInvestments
  // =============================================================================
  // Analise da Linha: void _reloadInvestments() {
  // void = Tipo de Retorno Vazio. Indica que o metodo nao entrega valor.
  // _reloadInvestments = Identificador do Metodo Privado. Forca a reconstrucao das secoes de investimento.
  // () = Lista de Parametros Vazia. Indica que o metodo nao recebe argumentos.
  // { = Abertura de Bloco. Inicia o corpo do metodo.
  void _reloadInvestments() {
    // Analise da Linha: setState(() {});
    // setState = Metodo de Atualizacao Visual. Avisa ao Flutter que o estado deve ser reconstruido.
    // () {} = Funcao Anonima Vazia. Dispara rebuild sem alterar variaveis diretamente.
    // ; = Finalizador de Instrucao. Operador que indica o fim da chamada.
    setState(() {});
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o corpo do metodo _reloadInvestments.
  }

  // =============================================================================
  // SECAO: METODO: _applyRouteUserData
  // =============================================================================
  // Analise da Linha: void _applyRouteUserData(Object? arguments) {
  // void = Tipo de Retorno Vazio. Indica que o metodo nao entrega valor.
  // _applyRouteUserData = Identificador do Metodo Privado. Extrai dados de usuario vindos da rota.
  // Object? arguments = Parametro Nulavel. Aceita qualquer objeto ou null como argumento de rota.
  // { = Abertura de Bloco. Inicia o corpo do metodo.
  void _applyRouteUserData(Object? arguments) {
    // Analise da Linha: if (arguments is! Map) return;
    // if = Estrutura Condicional. Executa o retorno apenas se a condicao for verdadeira.
    // arguments is! Map = Verificacao Negativa de Tipo. Confirma que o argumento nao e um mapa.
    // return = Saida Antecipada. Encerra o metodo quando nao ha dados legiveis.
    // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
    if (arguments is! Map) return;

    // Analise da Linha: final name = _firstString(arguments, const [
    // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
    // name = Identificador da Variavel. Guarda o primeiro nome valido encontrado no mapa.
    // _firstString(arguments, const [ = Chamada de Funcao. Procura uma string nas chaves informadas.
    // linha seguinte = Continuacao Sintatica. A lista constante de chaves continua abaixo.
    final name = _firstString(arguments, const [
      // Analise da Linha: 'name',
      // 'name' = Literal de String. Chave possivel para nome em ingles.
      // , = Separador de Item. Indica que outros itens seguem na lista.
      'name',
      // Analise da Linha: 'displayName',
      // 'displayName' = Literal de String. Chave possivel para nome de exibicao.
      // , = Separador de Item. Indica que outros itens seguem na lista.
      'displayName',
      // Analise da Linha: 'userName',
      // 'userName' = Literal de String. Chave possivel para nome de usuario.
      // , = Separador de Item. Indica que outros itens seguem na lista.
      'userName',
      // Analise da Linha: 'nome',
      // 'nome' = Literal de String. Chave possivel para nome em portugues.
      // , = Separador de Item. Indica fim deste item da lista.
      'nome',
    // Analise da Linha: ]);
    // ] = Fechamento de Lista. Encerra a lista constante de chaves.
    // ) = Fechamento de Chamada. Encerra a chamada de _firstString.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
    ]);
    // Analise da Linha: final photoUrl = _firstString(arguments, const [
    // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
    // photoUrl = Identificador da Variavel. Guarda a primeira URL de foto valida encontrada.
    // _firstString(arguments, const [ = Chamada de Funcao. Procura uma string nas chaves informadas.
    // linha seguinte = Continuacao Sintatica. A lista constante de chaves continua abaixo.
    final photoUrl = _firstString(arguments, const [
      // Analise da Linha: 'photoUrl',
      // 'photoUrl' = Literal de String. Chave possivel para URL da foto.
      // , = Separador de Item. Indica que outros itens seguem na lista.
      'photoUrl',
      // Analise da Linha: 'photoURL',
      // 'photoURL' = Literal de String. Variante de chave para URL da foto.
      // , = Separador de Item. Indica que outros itens seguem na lista.
      'photoURL',
      // Analise da Linha: 'avatarUrl',
      // 'avatarUrl' = Literal de String. Chave possivel para avatar do usuario.
      // , = Separador de Item. Indica que outros itens seguem na lista.
      'avatarUrl',
      // Analise da Linha: 'profilePhotoUrl',
      // 'profilePhotoUrl' = Literal de String. Chave possivel para foto de perfil.
      // , = Separador de Item. Indica que outros itens seguem na lista.
      'profilePhotoUrl',
      // Analise da Linha: 'foto',
      // 'foto' = Literal de String. Chave possivel para foto em portugues.
      // , = Separador de Item. Indica fim deste item da lista.
      'foto',
    // Analise da Linha: ]);
    // ] = Fechamento de Lista. Encerra a lista constante de chaves.
    // ) = Fechamento de Chamada. Encerra a chamada de _firstString.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
    ]);

    // Analise da Linha: if (name == null && photoUrl == null) return;
    // if = Estrutura Condicional. Executa o retorno apenas se a condicao for verdadeira.
    // name == null && photoUrl == null = Expressao Booleana. Verifica ausencia simultanea de nome e foto.
    // return = Saida Antecipada. Encerra o metodo quando nao ha dados para aplicar.
    // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
    if (name == null && photoUrl == null) return;
    // Analise da Linha: _userName = _normalizeUserName(name) ?? _userName;
    // _userName = Variavel de Estado. Guarda o nome exibido no cabecalho.
    // = = Operador de Atribuicao. Coloca o resultado da direita na variavel da esquerda.
    // ?? = Operador de Coalescencia Nula. Mantem o nome anterior se a normalizacao retornar null.
    // ; = Finalizador de Instrucao. Operador que indica o fim da atribuicao.
    _userName = _normalizeUserName(name) ?? _userName;
    // Analise da Linha: _userPhotoUrl = photoUrl ?? _userPhotoUrl;
    // _userPhotoUrl = Variavel de Estado Nulavel. Guarda a URL da foto exibida no cabecalho.
    // = = Operador de Atribuicao. Coloca o resultado da direita na variavel da esquerda.
    // ?? = Operador de Coalescencia Nula. Mantem a foto anterior se photoUrl for null.
    // ; = Finalizador de Instrucao. Operador que indica o fim da atribuicao.
    _userPhotoUrl = photoUrl ?? _userPhotoUrl;
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o corpo do metodo _applyRouteUserData.
  }

  // =============================================================================
  // SECAO: METODO: _loadFirebaseUserData
  // =============================================================================
  // Analise da Linha: Future<void> _loadFirebaseUserData() async {
  // Future<void> = Tipo de Retorno Assincrono Vazio. Indica uma operacao futura sem valor de retorno.
  // _loadFirebaseUserData = Identificador do Metodo Privado. Carrega dados do usuario autenticado no Firebase.
  // async = Modificador Assincrono. Permite usar await dentro do corpo do metodo.
  // { = Abertura de Bloco. Inicia o corpo do metodo.
  Future<void> _loadFirebaseUserData() async {
    // Analise da Linha: final initialized = await _initializeFirebaseIfConfigured().timeout(
    // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
    // initialized = Identificador da Variavel. Guarda se o Firebase foi inicializado.
    // await = Operador de Espera Assincrona. Aguarda o Future antes de continuar.
    // timeout( = Metodo de Limite de Tempo. Evita esperar indefinidamente pela inicializacao.
    final initialized = await _initializeFirebaseIfConfigured().timeout(
      // Analise da Linha: const Duration(seconds: 6),
      // const = Modificador de Constante. Cria o objeto de duracao como constante.
      // Duration(seconds: 6) = Construtor de Duracao. Define limite de seis segundos.
      // , = Separador de Argumento. Indica que outros parametros seguem.
      const Duration(seconds: 6),
      // Analise da Linha: onTimeout: () => false,
      // onTimeout = Parametro Nomeado. Define o que retornar quando o tempo limite estoura.
      // () => false = Funcao Anonima Compacta. Retorna false em caso de timeout.
      // , = Separador de Argumento. Indica fim deste parametro.
      onTimeout: () => false,
    // Analise da Linha: );
    // ) = Fechamento de Chamada. Encerra o metodo timeout.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
    );
    // Analise da Linha: if (!initialized) return;
    // if = Estrutura Condicional. Executa o retorno apenas se a condicao for verdadeira.
    // !initialized = Negacao Booleana. Verifica se a inicializacao falhou.
    // return = Saida Antecipada. Encerra o metodo quando o Firebase nao esta disponivel.
    // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
    if (!initialized) return;

    // Analise da Linha: final user = FirebaseAuth.instance.currentUser;
    // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
    // user = Identificador da Variavel. Guarda o usuario autenticado atual.
    // FirebaseAuth.instance.currentUser = Acesso ao Firebase Auth. Busca o usuario logado no momento.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
    final user = FirebaseAuth.instance.currentUser;
    // Analise da Linha: if (user == null) return;
    // if = Estrutura Condicional. Executa o retorno apenas se a condicao for verdadeira.
    // user == null = Comparacao com Nulo. Verifica se nao ha usuario autenticado.
    // return = Saida Antecipada. Encerra o metodo sem usuario para carregar.
    // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
    if (user == null) return;

    // Analise da Linha: final resolvedName =
    // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
    // resolvedName = Identificador da Variavel. Guarda o melhor nome resolvido para exibicao.
    // = = Operador de Atribuicao. Recebe a expressao encadeada das proximas linhas.
    // linha seguinte = Continuacao Sintatica. A expressao continua abaixo.
    final resolvedName =
        // Analise da Linha: _normalizeUserName(user.displayName) ??
        // _normalizeUserName = Chamada de Funcao Privada. Normaliza o displayName do usuario.
        // user.displayName = Propriedade do Usuario. Nome de exibicao vindo do Firebase.
        // ?? = Operador de Coalescencia Nula. Tenta a proxima alternativa se o valor for null.
        // linha seguinte = Continuacao Sintatica. A cadeia de fallback continua abaixo.
        _normalizeUserName(user.displayName) ??
        // Analise da Linha: _nameFromEmail(user.email) ??
        // _nameFromEmail = Chamada de Funcao Privada. Tenta criar nome pela parte inicial do e-mail.
        // user.email = Propriedade do Usuario. E-mail vindo do Firebase.
        // ?? = Operador de Coalescencia Nula. Tenta a proxima alternativa se o valor for null.
        // linha seguinte = Continuacao Sintatica. A cadeia de fallback continua abaixo.
        _nameFromEmail(user.email) ??
        // Analise da Linha: _normalizeUserName(user.email);
        // _normalizeUserName = Chamada de Funcao Privada. Usa o e-mail normalizado como ultimo recurso.
        // user.email = Propriedade do Usuario. Texto de e-mail vindo do Firebase.
        // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
        _normalizeUserName(user.email);

    // Analise da Linha: if (!mounted) return;
    // if = Estrutura Condicional. Executa o retorno apenas se a condicao for verdadeira.
    // !mounted = Negacao Booleana. Verifica se o State nao esta mais conectado a arvore.
    // return = Saida Antecipada. Evita setState depois que a tela foi descartada.
    // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
    if (!mounted) return;
    // Analise da Linha: setState(() {
    // setState = Metodo de Atualizacao Visual. Avisa ao Flutter que variaveis de estado mudaram.
    // () { = Funcao Anonima. Inicia o bloco de alteracoes de estado.
    // { = Abertura de Bloco. Inicia o corpo da funcao anonima.
    setState(() {
      // Analise da Linha: _userName = resolvedName ?? _userName;
      // _userName = Variavel de Estado. Guarda o nome exibido no cabecalho.
      // resolvedName ?? _userName = Fallback Nulo. Usa o nome resolvido ou preserva o atual.
      // ; = Finalizador de Instrucao. Operador que indica o fim da atribuicao.
      _userName = resolvedName ?? _userName;
      // Analise da Linha: _userPhotoUrl = user.photoURL ?? _userPhotoUrl;
      // _userPhotoUrl = Variavel de Estado Nulavel. Guarda a URL da foto exibida no cabecalho.
      // user.photoURL ?? _userPhotoUrl = Fallback Nulo. Usa a foto do Firebase ou preserva a atual.
      // ; = Finalizador de Instrucao. Operador que indica o fim da atribuicao.
      _userPhotoUrl = user.photoURL ?? _userPhotoUrl;
    // Analise da Linha: });
    // }) = Fechamento da Funcao Anonima. Encerra o bloco passado para setState.
    // ; = Finalizador de Instrucao. Operador que indica o fim da chamada.
    });
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o corpo do metodo _loadFirebaseUserData.
  }



  // =============================================================================
  // SECAO: METODO: build
  // =============================================================================
  // Analise da Linha: @override
  // @override = Anotacao de Sobrescrita. Informa que o metodo abaixo substitui um metodo herdado.
  @override
  // Analise da Linha: Widget build(BuildContext context) {
  // Widget = Tipo de Retorno. Indica que o metodo devolve uma arvore visual do Flutter.
  // build = Identificador do Metodo. Metodo chamado pelo Flutter para desenhar a tela.
  // BuildContext context = Parametro de Contexto. Localiza este widget na arvore.
  // { = Abertura de Bloco. Inicia o corpo do metodo.
  Widget build(BuildContext context) {
    // Analise da Linha: return AnnotatedRegion<SystemUiOverlayStyle>(
    // return = Palavra-chave de Retorno. Entrega a arvore de widgets da tela.
    // AnnotatedRegion<SystemUiOverlayStyle> = Widget Generico. Aplica estilo de overlay do sistema aos filhos.
    // <SystemUiOverlayStyle> = Tipo Generico. Define o tipo de anotacao usada.
    // ( = Delimitador de Argumentos. Inicia a configuracao do widget.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Analise da Linha: value: SystemUiOverlayStyle.dark,
      // value = Parametro Nomeado. Define o estilo aplicado a regiao.
      // SystemUiOverlayStyle.dark = Constante de Estilo. Configura icones escuros na area do sistema.
      // , = Separador de Argumento. Indica que outros parametros seguem.
      value: SystemUiOverlayStyle.dark,
      // Analise da Linha: child: Scaffold(
      // child = Parametro Nomeado. Define o widget filho da regiao anotada.
      // Scaffold = Construtor de Layout. Cria a estrutura base de tela Material.
      // ( = Delimitador de Argumentos. Inicia a configuracao do Scaffold.
      child: Scaffold(
        // Analise da Linha: backgroundColor: _screenBackground,
        // backgroundColor = Parametro Nomeado. Define a cor de fundo do Scaffold.
        // _screenBackground = Constante Privada. Cor cinza clara definida no estado.
        // , = Separador de Argumento. Indica que outros parametros seguem.
        backgroundColor: _screenBackground,
        // Analise da Linha: body: SafeArea(
        // body = Parametro Nomeado. Define o conteudo principal da tela.
        // SafeArea = Widget de Area Segura. Evita sobreposicao com barras e recortes do sistema.
        // ( = Delimitador de Argumentos. Inicia a configuracao do SafeArea.
        body: SafeArea(
          // Analise da Linha: child: LayoutBuilder(
          // child = Parametro Nomeado. Define o widget filho da area segura.
          // LayoutBuilder = Widget de Layout Responsivo. Expoe restricoes de tamanho ao builder.
          // ( = Delimitador de Argumentos. Inicia a configuracao do LayoutBuilder.
          child: LayoutBuilder(
            // Analise da Linha: builder: (context, constraints) {
            // builder = Parametro Nomeado. Define a funcao que monta a interface com base nas restricoes.
            // (context, constraints) = Parametros da Funcao. Recebem contexto e limites de layout.
            // { = Abertura de Bloco. Inicia o corpo do builder.
            builder: (context, constraints) {
              // Analise da Linha: final screenWidth = constraints.maxWidth < 390
              // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
              // screenWidth = Identificador da Variavel. Guarda a largura maxima usada pela tela centralizada.
              // constraints.maxWidth < 390 = Expressao Condicional. Verifica se a tela e menor que 390 pixels.
              // linha seguinte = Continuacao Sintatica. O operador ternario continua abaixo.
              final screenWidth = constraints.maxWidth < 390
                  // Analise da Linha: ? constraints.maxWidth
                  // ? = Operador Ternario. Escolhe este valor quando a condicao anterior e verdadeira.
                  // constraints.maxWidth = Largura Disponivel. Usa toda a largura em telas menores.
                  // linha seguinte = Continuacao Sintatica. O operador ternario continua abaixo.
                  ? constraints.maxWidth
                  // Analise da Linha: : 390.0;
                  // : = Separador do Operador Ternario. Escolhe este valor quando a condicao e falsa.
                  // 390.0 = Literal Numerico Decimal. Limita a largura maxima visual da tela.
                  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
                  : 390.0;

              // Analise da Linha: return Align(
              // return = Palavra-chave de Retorno. Entrega o widget criado pelo builder.
              // Align = Construtor de Widget. Posiciona o filho dentro do espaco disponivel.
              // ( = Delimitador de Argumentos. Inicia a configuracao do Align.
              return Align(
                // Analise da Linha: alignment: Alignment.topCenter,
                // alignment = Parametro Nomeado. Define a posicao do filho.
                // Alignment.topCenter = Constante de Alinhamento. Centraliza no topo.
                // , = Separador de Argumento. Indica que outros parametros seguem.
                alignment: Alignment.topCenter,
                // Analise da Linha: child: SizedBox(
                // child = Parametro Nomeado. Define o widget filho do Align.
                // SizedBox = Construtor de Caixa. Impoe largura e altura especificas ao filho.
                // ( = Delimitador de Argumentos. Inicia a configuracao do SizedBox.
                child: SizedBox(
                  // Analise da Linha: width: screenWidth,
                  // width = Parametro Nomeado. Define a largura da caixa.
                  // screenWidth = Variavel Local. Usa a largura calculada pelo LayoutBuilder.
                  // , = Separador de Argumento. Indica que outros parametros seguem.
                  width: screenWidth,
                  // Analise da Linha: height: constraints.maxHeight,
                  // height = Parametro Nomeado. Define a altura da caixa.
                  // constraints.maxHeight = Altura Disponivel. Usa toda a altura permitida pelo layout.
                  // , = Separador de Argumento. Indica que outros parametros seguem.
                  height: constraints.maxHeight,
                  // Analise da Linha: child: SingleChildScrollView(
                  // child = Parametro Nomeado. Define o widget filho da caixa.
                  // SingleChildScrollView = Widget de Rolagem. Permite rolar o conteudo verticalmente.
                  // ( = Delimitador de Argumentos. Inicia a configuracao da rolagem.
                  child: SingleChildScrollView(
                    // Analise da Linha: physics: const BouncingScrollPhysics(),
                    // physics = Parametro Nomeado. Define o comportamento fisico da rolagem.
                    // const BouncingScrollPhysics() = Objeto de Fisica. Aplica efeito elastico na rolagem.
                    // , = Separador de Argumento. Indica que outros parametros seguem.
                    physics: const BouncingScrollPhysics(),
                    // Analise da Linha: padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                    // padding = Parametro Nomeado. Define espacamento interno da rolagem.
                    // const EdgeInsets.fromLTRB(18, 18, 18, 24) = Objeto de Espacamento. Configura esquerda, topo, direita e baixo.
                    // , = Separador de Argumento. Indica que outros parametros seguem.
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                    // Analise da Linha: child: Column(
                    // child = Parametro Nomeado. Define o conteudo unico da rolagem.
                    // Column = Construtor de Widget. Organiza os filhos em coluna vertical.
                    // ( = Delimitador de Argumentos. Inicia a configuracao da coluna.
                    child: Column(
                      // Analise da Linha: crossAxisAlignment: CrossAxisAlignment.stretch,
                      // crossAxisAlignment = Parametro Nomeado. Define alinhamento no eixo horizontal da coluna.
                      // CrossAxisAlignment.stretch = Valor Enumerado. Faz os filhos ocuparem a largura disponivel.
                      // , = Separador de Argumento. Indica que outros parametros seguem.
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      // Analise da Linha: children: [
                      // children = Parametro Nomeado. Define a lista de widgets filhos.
                      // [ = Abertura de Lista. Inicia a colecao ordenada de widgets.
                      children: [
                        // Analise da Linha: HomeHeader(
                        // HomeHeader = Construtor de Widget. Cria o cabecalho da tela inicial/carteira.
                        // ( = Delimitador de Argumentos. Inicia a configuracao do cabecalho.
                        HomeHeader(
                          // Analise da Linha: primaryPurple: _primaryPurple,
                          // primaryPurple = Parametro Nomeado. Envia a cor roxa principal ao cabecalho.
                          // _primaryPurple = Constante Privada. Cor definida no estado da tela.
                          // , = Separador de Argumento. Indica que outros parametros seguem.
                          primaryPurple: _primaryPurple,
                          // Analise da Linha: userName: _userName,
                          // userName = Parametro Nomeado. Envia o nome do usuario ao cabecalho.
                          // _userName = Variavel de Estado. Texto exibido para identificar o usuario.
                          // , = Separador de Argumento. Indica que outros parametros seguem.
                          userName: _userName,
                          // Analise da Linha: userPhotoUrl: _userPhotoUrl,
                          // userPhotoUrl = Parametro Nomeado. Envia a URL da foto do usuario ao cabecalho.
                          // _userPhotoUrl = Variavel de Estado Nulavel. Pode conter foto ou null.
                          // , = Separador de Argumento. Indica que outros parametros seguem.
                          userPhotoUrl: _userPhotoUrl,
                          // Analise da Linha: showBalance: _showBalance,
                          // showBalance = Parametro Nomeado. Informa se valores financeiros devem aparecer.
                          // _showBalance = Variavel de Estado. Controla visibilidade do saldo.
                          // , = Separador de Argumento. Indica que outros parametros seguem.
                          showBalance: _showBalance,
                          // Analise da Linha: onToggleVisibility: _toggleBalanceVisibility,
                          // onToggleVisibility = Parametro Nomeado. Define a acao de alternar visibilidade.
                          // _toggleBalanceVisibility = Referencia de Metodo. Sera chamada pelo widget filho.
                          // , = Separador de Argumento. Indica que outros parametros seguem.
                          onToggleVisibility: _toggleBalanceVisibility,
                          // Analise da Linha: onNotificationsTap: () =>
                          // onNotificationsTap = Parametro Nomeado. Define a acao ao tocar em notificacoes.
                          // () => = Funcao Anonima Compacta. Executa navegacao quando chamada.
                          // linha seguinte = Continuacao Sintatica. A chamada de rota continua abaixo.
                          onNotificationsTap: () =>
                              // Analise da Linha: _openRoute(AppRoutes.notificacoes),
                              // _openRoute = Chamada de Metodo Privado. Abre uma rota nomeada.
                              // AppRoutes.notificacoes = Constante de Rota. Indica a tela de notificacoes.
                              // , = Separador de Argumento. Indica fim deste parametro.
                              _openRoute(AppRoutes.notificacoes),
                        // Analise da Linha: ),
                        // ) = Fechamento de Chamada. Encerra o construtor HomeHeader.
                        // , = Separador de Item. Indica que outro widget segue na lista.
                        ),
                        // Analise da Linha: const SizedBox(height: 24),
                        // const = Modificador de Constante. Cria o widget com valor fixo em tempo de compilacao.
                        // SizedBox(height: 24) = Widget de Espacamento. Adiciona 24 pixels de altura.
                        // , = Separador de Item. Indica que outro widget segue na lista.
                        const SizedBox(height: 24),
                        // Analise da Linha: WalletCard(
                        // WalletCard = Construtor de Widget. Cria o card principal da carteira.
                        // ( = Delimitador de Argumentos. Inicia a configuracao do card.
                        WalletCard(
                          // Analise da Linha: primaryPurple: _primaryPurple,
                          // primaryPurple = Parametro Nomeado. Envia a cor roxa principal ao card.
                          // _primaryPurple = Constante Privada. Cor definida no estado da tela.
                          // , = Separador de Argumento. Indica que outros parametros seguem.
                          primaryPurple: _primaryPurple,
                          // Analise da Linha: showBalance: _showBalance,
                          // showBalance = Parametro Nomeado. Informa se valores financeiros devem aparecer.
                          // _showBalance = Variavel de Estado. Controla visibilidade do saldo.
                          // , = Separador de Argumento. Indica que outros parametros seguem.
                          showBalance: _showBalance,
                          // Analise da Linha: onCardTap: () => _openRoute(AppRoutes.carteira),
                          // onCardTap = Parametro Nomeado. Define a acao ao tocar no card.
                          // () => _openRoute(AppRoutes.carteira) = Funcao Anonima Compacta. Navega para a carteira.
                          // , = Separador de Argumento. Indica que outros parametros seguem.
                          onCardTap: () => _openRoute(AppRoutes.carteira),
                          // Analise da Linha: onMoreTap: () => _showMessage(
                          // onMoreTap = Parametro Nomeado. Define a acao ao tocar no menu de mais opcoes.
                          // () => _showMessage( = Funcao Anonima Compacta. Exibe mensagem informativa.
                          // linha seguinte = Continuacao Sintatica. O texto da mensagem continua abaixo.
                          onMoreTap: () => _showMessage(
                            // Analise da Linha: 'Op\u00e7\u00f5es da carteira',
                            // 'Op\u00e7\u00f5es da carteira' = Literal de String. Texto exibido no SnackBar.
                            // , = Separador de Argumento. Indica fim do texto enviado.
                            'Op\u00e7\u00f5es da carteira',
                          // Analise da Linha: ),
                          // ) = Fechamento de Chamada. Encerra _showMessage.
                          // , = Separador de Argumento. Indica fim do parametro onMoreTap.
                          ),
                        // Analise da Linha: ),
                        // ) = Fechamento de Chamada. Encerra o construtor WalletCard.
                        // , = Separador de Item. Indica que outro widget segue na lista.
                        ),
                        // Analise da Linha: const SizedBox(height: 26),
                        // const = Modificador de Constante. Cria o widget com valor fixo em tempo de compilacao.
                        // SizedBox(height: 26) = Widget de Espacamento. Adiciona 26 pixels de altura.
                        // , = Separador de Item. Indica que outro widget segue na lista.
                        const SizedBox(height: 26),
                        // Analise da Linha: QuickActions(onRouteTap: _openRoute),
                        // QuickActions = Construtor de Widget. Cria os atalhos de navegacao rapida.
                        // onRouteTap: _openRoute = Parametro Nomeado. Entrega o metodo de abertura de rotas ao widget filho.
                        // , = Separador de Item. Indica que outro widget segue na lista.
                        QuickActions(onRouteTap: _openRoute),
                        // Analise da Linha: const SizedBox(height: 24),
                        // const = Modificador de Constante. Cria o widget com valor fixo em tempo de compilacao.
                        // SizedBox(height: 24) = Widget de Espacamento. Adiciona 24 pixels de altura.
                        // , = Separador de Item. Indica que outro widget segue na lista.
                        const SizedBox(height: 24),
                        // Analise da Linha: FirestoreInvestmentSections(
                        // FirestoreInvestmentSections = Construtor de Widget. Cria as secoes de investimentos vindas do Firestore.
                        // ( = Delimitador de Argumentos. Inicia a configuracao das secoes.
                        FirestoreInvestmentSections(
                          // Analise da Linha: userId: FirebaseAuth.instance.currentUser?.uid,
                          // userId = Parametro Nomeado. Envia o identificador do usuario autenticado.
                          // FirebaseAuth.instance.currentUser?.uid = Acesso Condicional. Pega o uid somente se houver usuario logado.
                          // , = Separador de Argumento. Indica que outros parametros seguem.
                          userId: FirebaseAuth.instance.currentUser?.uid,
                          // Analise da Linha: backgroundColor: _softCard,
                          // backgroundColor = Parametro Nomeado. Envia a cor de fundo dos cards de investimento.
                          // _softCard = Constante Privada. Cor suave definida no estado da tela.
                          // , = Separador de Argumento. Indica que outros parametros seguem.
                          backgroundColor: _softCard,
                          // Analise da Linha: statusColor: _statusBlue,
                          // statusColor = Parametro Nomeado. Envia a cor usada para status.
                          // _statusBlue = Constante Privada. Cor azul definida no estado da tela.
                          // , = Separador de Argumento. Indica que outros parametros seguem.
                          statusColor: _statusBlue,
                          // Analise da Linha: growthColor: _positiveGreen,
                          // growthColor = Parametro Nomeado. Envia a cor usada para crescimento positivo.
                          // _positiveGreen = Constante Privada. Cor verde definida no estado da tela.
                          // , = Separador de Argumento. Indica que outros parametros seguem.
                          growthColor: _positiveGreen,
                          // Analise da Linha: onRetry: _reloadInvestments,
                          // onRetry = Parametro Nomeado. Define a acao para tentar carregar novamente.
                          // _reloadInvestments = Referencia de Metodo. Forca reconstrucao das secoes.
                          // , = Separador de Argumento. Indica que outros parametros seguem.
                          onRetry: _reloadInvestments,
                          // Analise da Linha: onViewAllTap: () =>
                          // onViewAllTap = Parametro Nomeado. Define a acao para ver todos os investimentos/startups.
                          // () => = Funcao Anonima Compacta. Executa navegacao quando chamada.
                          // linha seguinte = Continuacao Sintatica. A chamada de rota continua abaixo.
                          onViewAllTap: () =>
                              // Analise da Linha: _openRoute(AppRoutes.catalogo),
                              // _openRoute = Chamada de Metodo Privado. Abre uma rota nomeada.
                              // AppRoutes.catalogo = Constante de Rota. Indica a tela de catalogo.
                              // , = Separador de Argumento. Indica fim deste parametro.
                              _openRoute(AppRoutes.catalogo),
                          // Analise da Linha: onStartupTap: _openStartupDetails,
                          // onStartupTap = Parametro Nomeado. Define a acao ao selecionar uma startup.
                          // _openStartupDetails = Referencia de Metodo. Abre a tela de detalhes da startup.
                          // , = Separador de Argumento. Indica que outros parametros seguem.
                          onStartupTap: _openStartupDetails,
                          // Analise da Linha: onMoreTap: () => _showMessage(
                          // onMoreTap = Parametro Nomeado. Define a acao ao tocar no menu de mais opcoes.
                          // () => _showMessage( = Funcao Anonima Compacta. Exibe mensagem informativa.
                          // linha seguinte = Continuacao Sintatica. O texto da mensagem continua abaixo.
                          onMoreTap: () => _showMessage(
                            // Analise da Linha: 'Op\u00e7\u00f5es dos investimentos',
                            // 'Op\u00e7\u00f5es dos investimentos' = Literal de String. Texto exibido no SnackBar.
                            // , = Separador de Argumento. Indica fim do texto enviado.
                            'Op\u00e7\u00f5es dos investimentos',
                          // Analise da Linha: ),
                          // ) = Fechamento de Chamada. Encerra _showMessage.
                          // , = Separador de Argumento. Indica fim do parametro onMoreTap.
                          ),
                        // Analise da Linha: ),
                        // ) = Fechamento de Chamada. Encerra FirestoreInvestmentSections.
                        // , = Separador de Item. Indica fim deste widget dentro da lista.
                        ),
                      // Analise da Linha: ],
                      // ] = Fechamento de Lista. Encerra a lista de widgets filhos da Column.
                      // , = Separador de Argumento. Indica fim do parametro children.
                      ],
                    // Analise da Linha: ),
                    // ) = Fechamento de Chamada. Encerra o construtor Column.
                    // , = Separador de Argumento. Indica fim do parametro child do SingleChildScrollView.
                    ),
                  // Analise da Linha: ),
                  // ) = Fechamento de Chamada. Encerra o construtor SingleChildScrollView.
                  // , = Separador de Argumento. Indica fim do parametro child do SizedBox.
                  ),
                // Analise da Linha: ),
                // ) = Fechamento de Chamada. Encerra o construtor SizedBox.
                // , = Separador de Argumento. Indica fim do parametro child do Align.
                ),
              // Analise da Linha: );
              // ) = Fechamento de Chamada. Encerra o construtor Align.
              // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
              );
            // Analise da Linha: },
            // } = Fechamento de Bloco. Encerra o corpo da funcao builder.
            // , = Separador de Argumento. Indica fim do parametro builder.
            },
          // Analise da Linha: ),
          // ) = Fechamento de Chamada. Encerra o construtor LayoutBuilder.
          // , = Separador de Argumento. Indica fim do parametro child do SafeArea.
          ),
        // Analise da Linha: ),
        // ) = Fechamento de Chamada. Encerra o construtor SafeArea.
        // , = Separador de Argumento. Indica fim do parametro body do Scaffold.
        ),
      // Analise da Linha: ),
      // ) = Fechamento de Chamada. Encerra o construtor Scaffold.
      // , = Separador de Argumento. Indica fim do parametro child do AnnotatedRegion.
      ),
    // Analise da Linha: );
    // ) = Fechamento de Chamada. Encerra o construtor AnnotatedRegion.
    // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
    );
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o corpo do metodo build.
  }
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o corpo da classe _WalletDashboardScreenState.
}
