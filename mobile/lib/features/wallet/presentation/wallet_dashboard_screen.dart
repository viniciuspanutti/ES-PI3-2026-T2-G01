import 'dart:async';
// GUILHERME PREVENTI CORREIA
// =============================================================================
// SECAO: IMPORTACOES
// =============================================================================
// Analise da Linha: import 'dart:async';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'dart:async' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Encerra a diretiva de importacao.
import 'dart:async';

// Analise da Linha: import 'package:firebase_auth/firebase_auth.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:firebase_auth/firebase_auth.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Encerra a diretiva de importacao.
import 'package:firebase_auth/firebase_auth.dart';
// Analise da Linha: import 'package:firebase_core/firebase_core.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:firebase_core/firebase_core.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Encerra a diretiva de importacao.
import 'package:firebase_core/firebase_core.dart';
// Analise da Linha: import 'package:flutter/material.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:flutter/material.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Encerra a diretiva de importacao.
import 'package:flutter/material.dart';
// Analise da Linha: import 'package:flutter/services.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:flutter/services.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Encerra a diretiva de importacao.
import 'package:flutter/services.dart';
// Analise da Linha: import 'package:mobile/core/routes/app_routes.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:mobile/core/routes/app_routes.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Encerra a diretiva de importacao.
import 'package:mobile/core/routes/app_routes.dart';
// Analise da Linha: import 'package:mobile/features/dashboard/widgets/home_investiment_sections.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:mobile/features/dashboard/widgets/home_investiment_sections.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Encerra a diretiva de importacao.
import 'package:mobile/features/dashboard/widgets/home_investiment_sections.dart';
// Analise da Linha: import 'package:mobile/features/dashboard/widgets/home_navigation_widgets.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:mobile/features/dashboard/widgets/home_navigation_widgets.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Encerra a diretiva de importacao.
import 'package:mobile/features/dashboard/widgets/home_navigation_widgets.dart';
// Analise da Linha: import 'package:mobile/features/startups/domain/startup.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:mobile/features/startups/domain/startup.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Encerra a diretiva de importacao.
import 'package:mobile/features/startups/domain/startup.dart';
// Analise da Linha: import 'package:mobile/features/startups/presentation/screen/list/startup_detail_screen.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:mobile/features/startups/presentation/screen/list/startup_detail_screen.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Encerra a diretiva de importacao.
import 'package:mobile/features/startups/presentation/screen/list/startup_detail_screen.dart';

// =============================================================================
// SECAO: FUNCAO/METODO: _initializeFirebaseIfConfigured
// =============================================================================
// Analise da Linha: Future<bool> _initializeFirebaseIfConfigured() async {
// Future<bool> = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
// _initializeFirebaseIfConfigured = Identificador da Funcao/Metodo. Nome usado para chamar este bloco de comportamento.
// ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
// async = Modificador Assincrono. Permite usar await e retornar uma operacao futura.
// { = Abertura de Bloco. Inicia o corpo executavel.
Future<bool> _initializeFirebaseIfConfigured() async {
  // Analise da Linha: try {
  // try = Bloco de Tentativa. Executa codigo que pode gerar erro.
  // { = Abertura de Bloco Protegido. Inicia as instrucoes monitoradas pelo try.
  try {
    // Analise da Linha: if (Firebase.apps.isEmpty) {
    // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
    // (Firebase.apps.isEmpty) = Expressao Condicional. Teste logico avaliado antes de executar o bloco.
    // { = Abertura de Bloco Condicional. Inicia as instrucoes do if.
    if (Firebase.apps.isEmpty) {
      // Analise da Linha: await Firebase.initializeApp();
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
      await Firebase.initializeApp();
      // Analise da Linha: }
      // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
    }
    // Analise da Linha: return Firebase.apps.isNotEmpty;
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // Firebase.apps.isNotEmpty = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    // ; = Finalizador de Instrucao. Encerra o retorno.
    return Firebase.apps.isNotEmpty;
    // Analise da Linha: } catch (_) {
    // } = Fechamento de Bloco. Encerra o bloco try anterior.
    // catch = Captura de Erro. Executa quando o try gera uma excecao.
    // (_) = Parametro da Excecao. Recebe ou ignora o erro capturado.
    // { = Abertura de Bloco. Inicia o tratamento do erro.
  } catch (_) {
    // Analise da Linha: return false;
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // false = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    // ; = Finalizador de Instrucao. Encerra o retorno.
    return false;
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: FUNCAO/METODO: _firstString
// =============================================================================
// Analise da Linha: String? _firstString(Map<dynamic, dynamic> values, List<String> keys) {
// String? = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
// _firstString = Identificador da Funcao/Metodo. Nome usado para chamar este bloco de comportamento.
// ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
// { = Abertura de Bloco. Inicia o corpo executavel.
String? _firstString(Map<dynamic, dynamic> values, List<String> keys) {
  // Analise da Linha: for (final key in keys) {
  // for = Estrutura de Repeticao. Percorre uma sequencia de valores ou indices.
  // (final key in keys) = Controle do Loop. Define como a repeticao percorre os dados.
  // { = Abertura de Bloco. Inicia as instrucoes repetidas.
  for (final key in keys) {
    // Analise da Linha: final value = values[key];
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // value = Identificador da Variavel. Rotulo usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // values[key] = Expressao de Valor. Resultado armazenado nesta variavel.
    // ; = Finalizador de Instrucao. Encerra a declaracao local.
    final value = values[key];
    // Analise da Linha: if (value is String && value.trim().isNotEmpty) return value.trim();
    // if = Estrutura Condicional em Linha. Testa uma condicao antes de retornar imediatamente.
    // (value is String && value.trim().isNotEmpty) = Expressao Condicional. Define quando o retorno antecipado acontece.
    // return = Instrucao de Retorno. Sai da funcao ou metodo com o valor informado.
    // ; = Finalizador de Instrucao. Encerra o retorno em linha.
    if (value is String && value.trim().isNotEmpty) return value.trim();
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }
  // Analise da Linha: return null;
  // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
  // null = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
  // ; = Finalizador de Instrucao. Encerra o retorno.
  return null;
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: FUNCAO/METODO: _normalizeUserName
// =============================================================================
// Analise da Linha: String? _normalizeUserName(String? value) {
// String? = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
// _normalizeUserName = Identificador da Funcao/Metodo. Nome usado para chamar este bloco de comportamento.
// ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
// { = Abertura de Bloco. Inicia o corpo executavel.
String? _normalizeUserName(String? value) {
  // Analise da Linha: final trimmed = value?.trim();
  // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
  // trimmed = Identificador da Variavel. Rotulo usado para acessar o resultado depois.
  // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
  // value?.trim() = Expressao de Valor. Resultado armazenado nesta variavel.
  // ; = Finalizador de Instrucao. Encerra a declaracao local.
  final trimmed = value?.trim();
  // Analise da Linha: if (trimmed == null || trimmed.isEmpty) return null;
  // if = Estrutura Condicional em Linha. Testa uma condicao antes de retornar imediatamente.
  // (trimmed == null || trimmed.isEmpty) = Expressao Condicional. Define quando o retorno antecipado acontece.
  // return = Instrucao de Retorno. Sai da funcao ou metodo com o valor informado.
  // ; = Finalizador de Instrucao. Encerra o retorno em linha.
  if (trimmed == null || trimmed.isEmpty) return null;
  // Analise da Linha: return trimmed;
  // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
  // trimmed = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
  // ; = Finalizador de Instrucao. Encerra o retorno.
  return trimmed;
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: FUNCAO/METODO: _nameFromEmail
// =============================================================================
// Analise da Linha: String? _nameFromEmail(String? email) {
// String? = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
// _nameFromEmail = Identificador da Funcao/Metodo. Nome usado para chamar este bloco de comportamento.
// ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
// { = Abertura de Bloco. Inicia o corpo executavel.
String? _nameFromEmail(String? email) {
  // Analise da Linha: final rawName = email?.split('@').first.trim();
  // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
  // rawName = Identificador da Variavel. Rotulo usado para acessar o resultado depois.
  // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
  // email?.split('@').first.trim() = Expressao de Valor. Resultado armazenado nesta variavel.
  // ; = Finalizador de Instrucao. Encerra a declaracao local.
  final rawName = email?.split('@').first.trim();
  // Analise da Linha: if (rawName == null || rawName.isEmpty) return null;
  // if = Estrutura Condicional em Linha. Testa uma condicao antes de retornar imediatamente.
  // (rawName == null || rawName.isEmpty) = Expressao Condicional. Define quando o retorno antecipado acontece.
  // return = Instrucao de Retorno. Sai da funcao ou metodo com o valor informado.
  // ; = Finalizador de Instrucao. Encerra o retorno em linha.
  if (rawName == null || rawName.isEmpty) return null;

  // Analise da Linha: return rawName
  // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
  // rawName = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
  return rawName
      // Analise da Linha: .replaceAll(RegExp(r'[._-]+'), ' ')
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      .replaceAll(RegExp(r'[._-]+'), ' ')
      // Analise da Linha: .split(RegExp(r'\s+'))
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      .split(RegExp(r'\s+'))
      // Analise da Linha: .where((word) => word.isNotEmpty)
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // => = Arrow Function. Retorna a expressao da direita de forma compacta.
      .where((word) => word.isNotEmpty)
      // Analise da Linha: .map((word) {
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // { = Abertura de Bloco. Inicia um novo escopo.
      .map((word) {
        // Analise da Linha: if (word.length == 1) return word.toUpperCase();
        // if = Estrutura Condicional em Linha. Testa uma condicao antes de retornar imediatamente.
        // (word.length == 1) = Expressao Condicional. Define quando o retorno antecipado acontece.
        // return = Instrucao de Retorno. Sai da funcao ou metodo com o valor informado.
        // ; = Finalizador de Instrucao. Encerra o retorno em linha.
        if (word.length == 1) return word.toUpperCase();
        // Analise da Linha: return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
        // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
        // '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
        // ; = Finalizador de Instrucao. Encerra o retorno.
        return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
        // Analise da Linha: })
        // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
      })
      // Analise da Linha: .join(' ');
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
      .join(' ');
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: CLASSE: WalletDashboardScreen
// =============================================================================
// Analise da Linha: class WalletDashboardScreen extends StatefulWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo do Dart.
// WalletDashboardScreen = Identificador da Classe. Nome usado para instanciar ou referenciar este widget/objeto.
// extends = Relacao de Heranca. Faz a classe receber comportamento base de StatefulWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class WalletDashboardScreen extends StatefulWidget {
  // =============================================================================
  // SECAO: CONSTRUTOR: WalletDashboardScreen
  // =============================================================================
  // Analise da Linha: const WalletDashboardScreen({super.key});
  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
  // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
  // { = Abertura de Bloco. Inicia um novo escopo.
  // } = Fechamento de Bloco. Encerra um escopo aberto anteriormente.
  const WalletDashboardScreen({super.key});

  // Analise da Linha: @override
  // @override = Anotacao de Sobrescrita. Informa que o metodo abaixo substitui um metodo herdado.
  @override
  // Analise da Linha: State<WalletDashboardScreen> createState() => _WalletDashboardScreenState();
  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
  // => = Arrow Function. Retorna a expressao da direita de forma compacta.
  // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
  State<WalletDashboardScreen> createState() => _WalletDashboardScreenState();
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: CLASSE: _WalletDashboardScreenState
// =============================================================================
// Analise da Linha: class _WalletDashboardScreenState extends State<WalletDashboardScreen> {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo do Dart.
// _WalletDashboardScreenState = Identificador da Classe. Nome usado para instanciar ou referenciar este widget/objeto.
// extends = Relacao de Heranca. Faz a classe receber comportamento base de State<WalletDashboardScreen>.
// { = Abertura de Bloco. Inicia o corpo da classe.
class _WalletDashboardScreenState extends State<WalletDashboardScreen> {
  // Analise da Linha: bool _showBalance = true;
  // bool = Tipo da Variavel. Define quais valores podem ser armazenados nesta propriedade.
  // _showBalance = Identificador da Variavel. Nome interno usado pelo estado do widget.
  // = = Operador de Atribuicao. Define o valor inicial da variavel.
  // ; = Finalizador de Instrucao. Encerra a declaracao da variavel.
  bool _showBalance = true;
  // Analise da Linha: bool _didReadRouteUser = false;
  // bool = Tipo da Variavel. Define quais valores podem ser armazenados nesta propriedade.
  // _didReadRouteUser = Identificador da Variavel. Nome interno usado pelo estado do widget.
  // = = Operador de Atribuicao. Define o valor inicial da variavel.
  // ; = Finalizador de Instrucao. Encerra a declaracao da variavel.
  bool _didReadRouteUser = false;
  // Analise da Linha: String _userName = 'Usu\u00e1rio';
  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
  // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
  String _userName = 'Usu\u00e1rio';
  // Analise da Linha: String? _userPhotoUrl;
  // String? = Tipo da Propriedade. Define qual categoria de dado pode ser guardada.
  // _userPhotoUrl = Identificador da Propriedade. Nome usado para acessar este campo.
  // ; = Finalizador de Instrucao. Encerra a declaracao do campo.
  String? _userPhotoUrl;

  // Analise da Linha: static const _screenBackground = Color(0xFFF5F5F5);
  // static = Modificador de Membro da Classe. Faz a constante pertencer a classe, nao a uma instancia.
  // const = Modificador de Constante. Define um valor fixo conhecido em tempo de compilacao.
  // _screenBackground = Identificador da Constante. Nome usado para reutilizar este valor no layout.
  // = = Operador de Atribuicao. Liga o nome da constante ao valor da direita.
  // ; = Finalizador de Instrucao. Encerra a declaracao da constante.
  static const _screenBackground = Color(0xFFF5F5F5);
  // Analise da Linha: static const _primaryPurple = Color(0xFF5A2D91);
  // static = Modificador de Membro da Classe. Faz a constante pertencer a classe, nao a uma instancia.
  // const = Modificador de Constante. Define um valor fixo conhecido em tempo de compilacao.
  // _primaryPurple = Identificador da Constante. Nome usado para reutilizar este valor no layout.
  // = = Operador de Atribuicao. Liga o nome da constante ao valor da direita.
  // ; = Finalizador de Instrucao. Encerra a declaracao da constante.
  static const _primaryPurple = Color(0xFF5A2D91);
  // Analise da Linha: static const _statusBlue = Color(0xFF4169FF);
  // static = Modificador de Membro da Classe. Faz a constante pertencer a classe, nao a uma instancia.
  // const = Modificador de Constante. Define um valor fixo conhecido em tempo de compilacao.
  // _statusBlue = Identificador da Constante. Nome usado para reutilizar este valor no layout.
  // = = Operador de Atribuicao. Liga o nome da constante ao valor da direita.
  // ; = Finalizador de Instrucao. Encerra a declaracao da constante.
  static const _statusBlue = Color(0xFF4169FF);
  // Analise da Linha: static const _positiveGreen = Color(0xFF18A71B);
  // static = Modificador de Membro da Classe. Faz a constante pertencer a classe, nao a uma instancia.
  // const = Modificador de Constante. Define um valor fixo conhecido em tempo de compilacao.
  // _positiveGreen = Identificador da Constante. Nome usado para reutilizar este valor no layout.
  // = = Operador de Atribuicao. Liga o nome da constante ao valor da direita.
  // ; = Finalizador de Instrucao. Encerra a declaracao da constante.
  static const _positiveGreen = Color(0xFF18A71B);
  // Analise da Linha: static const _softCard = Color(0xFFF7F7FA);
  // static = Modificador de Membro da Classe. Faz a constante pertencer a classe, nao a uma instancia.
  // const = Modificador de Constante. Define um valor fixo conhecido em tempo de compilacao.
  // _softCard = Identificador da Constante. Nome usado para reutilizar este valor no layout.
  // = = Operador de Atribuicao. Liga o nome da constante ao valor da direita.
  // ; = Finalizador de Instrucao. Encerra a declaracao da constante.
  static const _softCard = Color(0xFFF7F7FA);

  // Analise da Linha: @override
  // @override = Anotacao de Sobrescrita. Informa que o metodo abaixo substitui um metodo herdado.
  @override
  // =============================================================================
  // SECAO: FUNCAO/METODO: didChangeDependencies
  // =============================================================================
  // Analise da Linha: void didChangeDependencies() {
  // void = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // didChangeDependencies = Identificador da Funcao/Metodo. Nome usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  void didChangeDependencies() {
    // Analise da Linha: super.didChangeDependencies();
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    super.didChangeDependencies();
    // Analise da Linha: if (_didReadRouteUser) return;
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    if (_didReadRouteUser) return;

    // Analise da Linha: _didReadRouteUser = true;
    // _didReadRouteUser = Identificador Reatribuido. Variavel existente que recebera novo valor.
    // = = Operador de Atribuicao. Substitui o valor anterior pelo valor da direita.
    // true = Expressao de Valor. Resultado que passa a ser armazenado.
    // ; = Finalizador de Instrucao. Encerra a reatribuicao.
    _didReadRouteUser = true;
    // Analise da Linha: _applyRouteUserData(ModalRoute.of(context)?.settings.arguments);
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ?. = Acesso Seguro. Chama membro somente se o objeto da esquerda nao for null.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    _applyRouteUserData(ModalRoute.of(context)?.settings.arguments);
    // Analise da Linha: unawaited(_loadFirebaseUserData());
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    unawaited(_loadFirebaseUserData());
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // =============================================================================
  // SECAO: FUNCAO/METODO: _toggleBalanceVisibility
  // =============================================================================
  // Analise da Linha: void _toggleBalanceVisibility() {
  // void = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _toggleBalanceVisibility = Identificador da Funcao/Metodo. Nome usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  void _toggleBalanceVisibility() {
    // Analise da Linha: setState(() => _showBalance = !_showBalance);
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // => = Arrow Function. Retorna a expressao da direita de forma compacta.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    setState(() => _showBalance = !_showBalance);
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // =============================================================================
  // SECAO: FUNCAO/METODO: _showMessage
  // =============================================================================
  // Analise da Linha: void _showMessage(String message) {
  // void = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _showMessage = Identificador da Funcao/Metodo. Nome usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  void _showMessage(String message) {
    // Analise da Linha: ScaffoldMessenger.of(context)
    // ScaffoldMessenger.of = Chamada de Construtor/Funcao. Cria um widget/objeto ou executa um metodo.
    // ( ) = Delimitadores de Argumentos. Contem os valores enviados na chamada.
    ScaffoldMessenger.of(context)
      // Analise da Linha: ..clearSnackBars()
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      ..clearSnackBars()
      // Analise da Linha: ..showSnackBar(
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      ..showSnackBar(
        // Analise da Linha: SnackBar(
        // SnackBar = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
        // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
        SnackBar(
          // Analise da Linha: content: Text(message),
          // content = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // Text(message) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          content: Text(message),
          // Analise da Linha: behavior: SnackBarBehavior.floating,
          // behavior = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // SnackBarBehavior.floating = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          behavior: SnackBarBehavior.floating,
          // Analise da Linha: duration: const Duration(milliseconds: 1600),
          // duration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // const Duration(milliseconds: 1600) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          duration: const Duration(milliseconds: 1600),
          // Analise da Linha: shape: RoundedRectangleBorder(
          // shape = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // RoundedRectangleBorder( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          shape: RoundedRectangleBorder(
            // Analise da Linha: borderRadius: BorderRadius.circular(14),
            // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // BorderRadius.circular(14) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            borderRadius: BorderRadius.circular(14),
            // Analise da Linha: ),
            // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
            // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
          ),
          // Analise da Linha: ),
          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
          // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
        ),
        // Analise da Linha: );
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // ; = Finalizador de Instrucao. Encerra a expressao atual.
      );
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // =============================================================================
  // SECAO: FUNCAO/METODO: _openRoute
  // =============================================================================
  // Analise da Linha: void _openRoute(String routeName) {
  // void = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _openRoute = Identificador da Funcao/Metodo. Nome usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  void _openRoute(String routeName) {
    // Analise da Linha: Navigator.of(context).pushNamed(routeName);
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    Navigator.of(context).pushNamed(routeName);
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // =============================================================================
  // SECAO: FUNCAO/METODO: _openStartupDetails
  // =============================================================================
  // Analise da Linha: void _openStartupDetails(StartupDetail startup) {
  // void = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _openStartupDetails = Identificador da Funcao/Metodo. Nome usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  void _openStartupDetails(StartupDetail startup) {
    // Analise da Linha: Navigator.of(context).push(
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    Navigator.of(context).push(
      // Analise da Linha: MaterialPageRoute<void>(
      // MaterialPageRoute<void> = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
      // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
      MaterialPageRoute<void>(
        // Analise da Linha: builder: (_) => StartupDetailScreen(startup: startup),
        // builder = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // (_) => StartupDetailScreen(startup: startup) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        builder: (_) => StartupDetailScreen(startup: startup),
        // Analise da Linha: ),
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
      ),
      // Analise da Linha: );
      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
      // ; = Finalizador de Instrucao. Encerra a expressao atual.
    );
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // =============================================================================
  // SECAO: FUNCAO/METODO: _reloadInvestments
  // =============================================================================
  // Analise da Linha: void _reloadInvestments() {
  // void = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _reloadInvestments = Identificador da Funcao/Metodo. Nome usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  void _reloadInvestments() {
    // Analise da Linha: setState(() {});
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    // { = Abertura de Bloco. Inicia um novo escopo.
    // } = Fechamento de Bloco. Encerra um escopo aberto anteriormente.
    setState(() {});
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // =============================================================================
  // SECAO: FUNCAO/METODO: _applyRouteUserData
  // =============================================================================
  // Analise da Linha: void _applyRouteUserData(Object? arguments) {
  // void = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _applyRouteUserData = Identificador da Funcao/Metodo. Nome usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  void _applyRouteUserData(Object? arguments) {
    // Analise da Linha: if (arguments is! Map) return;
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    if (arguments is! Map) return;

    // Analise da Linha: final name = _firstString(arguments, const [
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // name = Identificador da Variavel. Rotulo usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // _firstString(arguments, const [ = Expressao de Valor. Resultado armazenado nesta variavel.
    final name = _firstString(arguments, const [
      // Analise da Linha: 'name',
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
      'name',
      // Analise da Linha: 'displayName',
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
      'displayName',
      // Analise da Linha: 'userName',
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
      'userName',
      // Analise da Linha: 'nome',
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
      'nome',
      // Analise da Linha: ]);
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    ]);
    // Analise da Linha: final photoUrl = _firstString(arguments, const [
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // photoUrl = Identificador da Variavel. Rotulo usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // _firstString(arguments, const [ = Expressao de Valor. Resultado armazenado nesta variavel.
    final photoUrl = _firstString(arguments, const [
      // Analise da Linha: 'photoUrl',
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
      'photoUrl',
      // Analise da Linha: 'photoURL',
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
      'photoURL',
      // Analise da Linha: 'avatarUrl',
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
      'avatarUrl',
      // Analise da Linha: 'profilePhotoUrl',
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
      'profilePhotoUrl',
      // Analise da Linha: 'foto',
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
      'foto',
      // Analise da Linha: ]);
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    ]);

    // Analise da Linha: if (name == null && photoUrl == null) return;
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    if (name == null && photoUrl == null) return;
    // Analise da Linha: _userName = _normalizeUserName(name) ?? _userName;
    // _userName = Identificador Reatribuido. Variavel existente que recebera novo valor.
    // = = Operador de Atribuicao. Substitui o valor anterior pelo valor da direita.
    // _normalizeUserName(name) ?? _userName = Expressao de Valor. Resultado que passa a ser armazenado.
    // ; = Finalizador de Instrucao. Encerra a reatribuicao.
    _userName = _normalizeUserName(name) ?? _userName;
    // Analise da Linha: _userPhotoUrl = photoUrl ?? _userPhotoUrl;
    // _userPhotoUrl = Identificador Reatribuido. Variavel existente que recebera novo valor.
    // = = Operador de Atribuicao. Substitui o valor anterior pelo valor da direita.
    // photoUrl ?? _userPhotoUrl = Expressao de Valor. Resultado que passa a ser armazenado.
    // ; = Finalizador de Instrucao. Encerra a reatribuicao.
    _userPhotoUrl = photoUrl ?? _userPhotoUrl;
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // =============================================================================
  // SECAO: FUNCAO/METODO: _loadFirebaseUserData
  // =============================================================================
  // Analise da Linha: Future<void> _loadFirebaseUserData() async {
  // Future<void> = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _loadFirebaseUserData = Identificador da Funcao/Metodo. Nome usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // async = Modificador Assincrono. Permite usar await e retornar uma operacao futura.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  Future<void> _loadFirebaseUserData() async {
    // Analise da Linha: final initialized = await _initializeFirebaseIfConfigured().timeout(
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // initialized = Identificador da Variavel. Rotulo usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // await _initializeFirebaseIfConfigured().timeout( = Expressao de Valor. Resultado armazenado nesta variavel.
    final initialized = await _initializeFirebaseIfConfigured().timeout(
      // =============================================================================
      // SECAO: CONSTRUTOR: Duration
      // =============================================================================
      // Analise da Linha: const Duration(seconds: 6),
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
      const Duration(seconds: 6),
      // Analise da Linha: onTimeout: () => false,
      // onTimeout = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // () => false = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      onTimeout: () => false,
      // Analise da Linha: );
      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
      // ; = Finalizador de Instrucao. Encerra a expressao atual.
    );
    // Analise da Linha: if (!initialized) return;
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    if (!initialized) return;

    // Analise da Linha: final user = FirebaseAuth.instance.currentUser;
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // user = Identificador da Variavel. Rotulo usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // FirebaseAuth.instance.currentUser = Expressao de Valor. Resultado armazenado nesta variavel.
    // ; = Finalizador de Instrucao. Encerra a declaracao local.
    final user = FirebaseAuth.instance.currentUser;
    // Analise da Linha: if (user == null) return;
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    if (user == null) return;

    // Analise da Linha: final resolvedName =
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // resolvedName = Identificador da Variavel. Rotulo usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // expressao seguinte = Valor Continuado. A expressao atribuida continua nas proximas linhas.
    final resolvedName =
        // Analise da Linha: _normalizeUserName(user.displayName) ??
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        // ?? = Operador de Coalescencia Nula. Usa o valor da direita se o da esquerda for null.
        _normalizeUserName(user.displayName) ??
        // Analise da Linha: _nameFromEmail(user.email) ??
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        // ?? = Operador de Coalescencia Nula. Usa o valor da direita se o da esquerda for null.
        _nameFromEmail(user.email) ??
        // Analise da Linha: _normalizeUserName(user.email);
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
        _normalizeUserName(user.email);

    // Analise da Linha: if (!mounted) return;
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    if (!mounted) return;
    // Analise da Linha: setState(() {
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // { = Abertura de Bloco. Inicia um novo escopo.
    setState(() {
      // Analise da Linha: _userName = resolvedName ?? _userName;
      // _userName = Identificador Reatribuido. Variavel existente que recebera novo valor.
      // = = Operador de Atribuicao. Substitui o valor anterior pelo valor da direita.
      // resolvedName ?? _userName = Expressao de Valor. Resultado que passa a ser armazenado.
      // ; = Finalizador de Instrucao. Encerra a reatribuicao.
      _userName = resolvedName ?? _userName;
      // Analise da Linha: _userPhotoUrl = user.photoURL ?? _userPhotoUrl;
      // _userPhotoUrl = Identificador Reatribuido. Variavel existente que recebera novo valor.
      // = = Operador de Atribuicao. Substitui o valor anterior pelo valor da direita.
      // user.photoURL ?? _userPhotoUrl = Expressao de Valor. Resultado que passa a ser armazenado.
      // ; = Finalizador de Instrucao. Encerra a reatribuicao.
      _userPhotoUrl = user.photoURL ?? _userPhotoUrl;
      // Analise da Linha: });
      // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
      // ; = Finalizador de Instrucao. Encerra a expressao atual.
    });
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // Analise da Linha: @override
  // @override = Anotacao de Sobrescrita. Informa que o metodo abaixo substitui um metodo herdado.
  @override
  // =============================================================================
  // SECAO: METODO: build
  // =============================================================================
  // Analise da Linha: Widget build(BuildContext context) {
  // Widget = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // build = Identificador da Funcao/Metodo. Nome usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  Widget build(BuildContext context) {
    // Analise da Linha: return AnnotatedRegion<SystemUiOverlayStyle>(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // AnnotatedRegion<SystemUiOverlayStyle>( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Analise da Linha: value: SystemUiOverlayStyle.dark,
      // value = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // SystemUiOverlayStyle.dark = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      value: SystemUiOverlayStyle.dark,
      // Analise da Linha: child: Scaffold(
      // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // Scaffold( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      child: Scaffold(
        // Analise da Linha: backgroundColor: _screenBackground,
        // backgroundColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // _screenBackground = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        backgroundColor: _screenBackground,
        // Analise da Linha: body: SafeArea(
        // body = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // SafeArea( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        body: SafeArea(
          // Analise da Linha: child: LayoutBuilder(
          // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // LayoutBuilder( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          child: LayoutBuilder(
            // Analise da Linha: builder: (context, constraints) {
            // builder = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // (context, constraints) { = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            builder: (context, constraints) {
              // Analise da Linha: final screenWidth = constraints.maxWidth < 390
              // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
              // screenWidth = Identificador da Variavel. Rotulo usado para acessar o resultado depois.
              // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
              // constraints.maxWidth < 390 = Expressao de Valor. Resultado armazenado nesta variavel.
              final screenWidth = constraints.maxWidth < 390
                  // Analise da Linha: ? constraints.maxWidth
                  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                  ? constraints.maxWidth
                  // Analise da Linha: : 390.0;
                  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                  // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
                  : 390.0;

              // Analise da Linha: return Align(
              // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
              // Align( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
              return Align(
                // Analise da Linha: alignment: Alignment.topCenter,
                // alignment = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // Alignment.topCenter = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                alignment: Alignment.topCenter,
                // Analise da Linha: child: SizedBox(
                // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // SizedBox( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                child: SizedBox(
                  // Analise da Linha: width: screenWidth,
                  // width = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // screenWidth = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  width: screenWidth,
                  // Analise da Linha: height: constraints.maxHeight,
                  // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // constraints.maxHeight = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  height: constraints.maxHeight,
                  // Analise da Linha: child: SingleChildScrollView(
                  // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // SingleChildScrollView( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  child: SingleChildScrollView(
                    // Analise da Linha: physics: const BouncingScrollPhysics(),
                    // physics = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // const BouncingScrollPhysics() = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    physics: const BouncingScrollPhysics(),
                    // Analise da Linha: padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                    // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // const EdgeInsets.fromLTRB(18, 18, 18, 24) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                    // Analise da Linha: child: Column(
                    // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // Column( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    child: Column(
                      // Analise da Linha: crossAxisAlignment: CrossAxisAlignment.stretch,
                      // crossAxisAlignment = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                      // CrossAxisAlignment.stretch = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                      // , = Separador de Argumento. Permite informar outro argumento depois.
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      // Analise da Linha: children: [
                      // children = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                      // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                      children: [
                        // Analise da Linha: HomeHeader(
                        // HomeHeader = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
                        // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
                        HomeHeader(
                          // Analise da Linha: primaryPurple: _primaryPurple,
                          // primaryPurple = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // _primaryPurple = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          // , = Separador de Argumento. Permite informar outro argumento depois.
                          primaryPurple: _primaryPurple,
                          // Analise da Linha: userName: _userName,
                          // userName = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // _userName = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          // , = Separador de Argumento. Permite informar outro argumento depois.
                          userName: _userName,
                          // Analise da Linha: userPhotoUrl: _userPhotoUrl,
                          // userPhotoUrl = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // _userPhotoUrl = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          // , = Separador de Argumento. Permite informar outro argumento depois.
                          userPhotoUrl: _userPhotoUrl,
                          // Analise da Linha: showBalance: _showBalance,
                          // showBalance = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // _showBalance = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          // , = Separador de Argumento. Permite informar outro argumento depois.
                          showBalance: _showBalance,
                          // Analise da Linha: onToggleVisibility: _toggleBalanceVisibility,
                          // onToggleVisibility = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // _toggleBalanceVisibility = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          // , = Separador de Argumento. Permite informar outro argumento depois.
                          onToggleVisibility: _toggleBalanceVisibility,
                          // Analise da Linha: onNotificationsTap: () =>
                          // onNotificationsTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // () => = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          onNotificationsTap: () =>
                              // Analise da Linha: _openRoute(AppRoutes.notificacoes),
                              // _openRoute = Chamada de Construtor/Funcao. Cria um widget/objeto ou executa um metodo.
                              // ( ) = Delimitadores de Argumentos. Contem os valores enviados na chamada.
                              // , = Separador de Argumento. Mantem a lista externa em continuidade.
                              _openRoute(AppRoutes.notificacoes),
                          // Analise da Linha: ),
                          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                          // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                        ),

                        // =============================================================================
                        // SECAO: CONSTRUTOR: SizedBox
                        // =============================================================================
                        // Analise da Linha: const SizedBox(height: 24),
                        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                        // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                        const SizedBox(height: 24),
                        // Analise da Linha: WalletCard(
                        // WalletCard = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
                        // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
                        WalletCard(
                          // Analise da Linha: primaryPurple: _primaryPurple,
                          // primaryPurple = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // _primaryPurple = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          // , = Separador de Argumento. Permite informar outro argumento depois.
                          primaryPurple: _primaryPurple,
                          // Analise da Linha: showBalance: _showBalance,
                          // showBalance = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // _showBalance = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          // , = Separador de Argumento. Permite informar outro argumento depois.
                          showBalance: _showBalance,
                          // Analise da Linha: onCardTap: () => _openRoute(AppRoutes.carteira),
                          // onCardTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // () => _openRoute(AppRoutes.carteira) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          // , = Separador de Argumento. Permite informar outro argumento depois.
                          onCardTap: () => _openRoute(AppRoutes.carteira),
                          // Analise da Linha: onMoreTap: () => _showMessage(
                          // onMoreTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // () => _showMessage( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          onMoreTap: () => _showMessage(
                            // Analise da Linha: 'Op\u00e7\u00f5es da carteira',
                            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                            // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                            'Op\u00e7\u00f5es da carteira',
                            // Analise da Linha: ),
                            // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                            // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                          ),
                          // Analise da Linha: ),
                          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                          // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                        ),
                        // Analise da Linha: const SizedBox(height: 26),
                        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                        // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                        const SizedBox(height: 26),
                        // Analise da Linha: QuickActions(onRouteTap: _openRoute),
                        // QuickActions = Chamada de Construtor/Funcao. Cria um widget/objeto ou executa um metodo.
                        // ( ) = Delimitadores de Argumentos. Contem os valores enviados na chamada.
                        // , = Separador de Argumento. Mantem a lista externa em continuidade.
                        QuickActions(onRouteTap: _openRoute),
                        // Analise da Linha: const SizedBox(height: 24),
                        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                        // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                        const SizedBox(height: 24),
                        // Analise da Linha: FirestoreInvestmentSections(
                        // FirestoreInvestmentSections = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
                        // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
                        FirestoreInvestmentSections(
                          // Analise da Linha: userId: FirebaseAuth.instance.currentUser?.uid,
                          // userId = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // FirebaseAuth.instance.currentUser?.uid = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          // , = Separador de Argumento. Permite informar outro argumento depois.
                          userId: FirebaseAuth.instance.currentUser?.uid,
                          // Analise da Linha: backgroundColor: _softCard,
                          // backgroundColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // _softCard = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          // , = Separador de Argumento. Permite informar outro argumento depois.
                          backgroundColor: _softCard,
                          // Analise da Linha: statusColor: _statusBlue,
                          // statusColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // _statusBlue = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          // , = Separador de Argumento. Permite informar outro argumento depois.
                          statusColor: _statusBlue,
                          // Analise da Linha: growthColor: _positiveGreen,
                          // growthColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // _positiveGreen = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          // , = Separador de Argumento. Permite informar outro argumento depois.
                          growthColor: _positiveGreen,
                          // Analise da Linha: onRetry: _reloadInvestments,
                          // onRetry = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // _reloadInvestments = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          // , = Separador de Argumento. Permite informar outro argumento depois.
                          onRetry: _reloadInvestments,
                          // Analise da Linha: onViewAllTap: () =>
                          // onViewAllTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // () => = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          onViewAllTap: () =>
                              // Analise da Linha: _openRoute(AppRoutes.catalogo),
                              // _openRoute = Chamada de Construtor/Funcao. Cria um widget/objeto ou executa um metodo.
                              // ( ) = Delimitadores de Argumentos. Contem os valores enviados na chamada.
                              // , = Separador de Argumento. Mantem a lista externa em continuidade.
                              _openRoute(AppRoutes.catalogo),
                          // Analise da Linha: onStartupTap: _openStartupDetails,
                          // onStartupTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // _openStartupDetails = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          // , = Separador de Argumento. Permite informar outro argumento depois.
                          onStartupTap: _openStartupDetails,
                          // Analise da Linha: onMoreTap: () => _showMessage(
                          // onMoreTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // () => _showMessage( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          onMoreTap: () => _showMessage(
                            // Analise da Linha: 'Op\u00e7\u00f5es dos investimentos',
                            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                            // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                            'Op\u00e7\u00f5es dos investimentos',
                            // Analise da Linha: ),
                            // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                            // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                          ),
                          // Analise da Linha: ),
                          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                          // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                        ),
                        // Analise da Linha: ],
                        // ] = Fechamento de Lista. Encerra uma colecao ou lista de widgets.
                        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                      ],
                      // Analise da Linha: ),
                      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                      // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                    ),
                    // Analise da Linha: ),
                    // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                    // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                  ),
                  // Analise da Linha: ),
                  // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                  // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                ),
                // Analise da Linha: );
                // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                // ; = Finalizador de Instrucao. Encerra a expressao atual.
              );
              // Analise da Linha: },
              // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
              // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
            },
            // Analise da Linha: ),
            // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
            // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
          ),
          // Analise da Linha: ),
          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
          // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
        ),
        // Analise da Linha: ),
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
      ),
      // Analise da Linha: );
      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
      // ; = Finalizador de Instrucao. Encerra a expressao atual.
    );
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

```
