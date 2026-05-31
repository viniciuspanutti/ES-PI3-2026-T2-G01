// GUILHERME PREVENTI CORREIA

// =============================================================================
// SECAO: IMPORTACOES
// =============================================================================
// Analise da Linha: import 'package:flutter/material.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:flutter/material.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:flutter/material.dart';
// Analise da Linha: import 'package:mobile/core/theme/app_colors.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:mobile/core/theme/app_colors.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:mobile/core/theme/app_colors.dart';
// Analise da Linha: import 'package:mobile/features/startups/domain/startup.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:mobile/features/startups/domain/startup.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:mobile/features/startups/domain/startup.dart';

// =============================================================================
// SECAO: CLASSE: PrivateQuestionsChatScreen
// =============================================================================
// Analise da Linha: class PrivateQuestionsChatScreen extends StatefulWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// PrivateQuestionsChatScreen = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatefulWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class PrivateQuestionsChatScreen extends StatefulWidget {
  // Analise da Linha: final StartupDetail startup;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // StartupDetail = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // startup = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final StartupDetail startup;

  // =============================================================================
  // SECAO: CONSTRUTOR: PrivateQuestionsChatScreen
  // =============================================================================
  // Analise da Linha: const PrivateQuestionsChatScreen({super.key, required this.startup});
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // PrivateQuestionsChatScreen = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // { } = Delimitadores de Parametros Nomeados. Agrupam argumentos opcionais ou obrigatorios por nome.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao do construtor.
  const PrivateQuestionsChatScreen({super.key, required this.startup});

  // Analise da Linha: @override
  // @override = Anotacao de Sobrescrita. Informa que o metodo abaixo substitui um metodo herdado.
  @override

  // =============================================================================
  // SECAO: FUNCAO/METODO: createState
  // =============================================================================
  // Analise da Linha: State<PrivateQuestionsChatScreen> createState() =>
  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
  // => = Arrow Function. Retorna a expressao da direita de forma compacta.
  State<PrivateQuestionsChatScreen> createState() =>
      // Analise da Linha: _PrivateQuestionsChatScreenState();
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
      _PrivateQuestionsChatScreenState();
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: CLASSE: _PrivateQuestionsChatScreenState
// =============================================================================
// Analise da Linha: class _PrivateQuestionsChatScreenState
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// _PrivateQuestionsChatScreenState = Identificador da Classe. Nome tecnico usado para referenciar essa estrutura.
// linha seguinte = Continuacao Sintatica. A heranca e o corpo da classe continuam abaixo.
class _PrivateQuestionsChatScreenState
    // Analise da Linha: extends State<PrivateQuestionsChatScreen> {
    // extends = Relacao de Heranca. Continua a declaracao da classe iniciada na linha anterior.
    // State<PrivateQuestionsChatScreen> = Classe Base. Tipo pai que fornece comportamento para esta classe.
    // { = Abertura de Bloco. Inicia o corpo da classe.
    extends State<PrivateQuestionsChatScreen> {
  // Analise da Linha: final TextEditingController _messageController = TextEditingController();
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // TextEditingController = Tipo Declarado. Define a categoria de dado aceita por esta variavel.
  // _messageController = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // = = Operador de Atribuicao. Liga a variavel ao valor da direita.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final TextEditingController _messageController = TextEditingController();
  // Analise da Linha: final ScrollController _scrollController = ScrollController();
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // ScrollController = Tipo Declarado. Define a categoria de dado aceita por esta variavel.
  // _scrollController = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // = = Operador de Atribuicao. Liga a variavel ao valor da direita.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final ScrollController _scrollController = ScrollController();

  // Analise da Linha: final List<_PrivateChatMessage> _messages = [];
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // List<_PrivateChatMessage> = Tipo Declarado. Define a categoria de dado aceita por esta variavel.
  // _messages = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // = = Operador de Atribuicao. Liga a variavel ao valor da direita.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final List<_PrivateChatMessage> _messages = [];

  // Analise da Linha: @override
  // @override = Anotacao de Sobrescrita. Informa que o metodo abaixo substitui um metodo herdado.
  @override

  // =============================================================================
  // SECAO: FUNCAO/METODO: dispose
  // =============================================================================
  // Analise da Linha: void dispose() {
  // void = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // dispose = Identificador da Funcao/Metodo. Nome tecnico usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  void dispose() {
    // Analise da Linha: _messageController.dispose();
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    _messageController.dispose();
    // Analise da Linha: _scrollController.dispose();
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    _scrollController.dispose();
    // Analise da Linha: super.dispose();
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    super.dispose();
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
  // build = Identificador da Funcao/Metodo. Nome tecnico usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  Widget build(BuildContext context) {
    // Analise da Linha: return Scaffold(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // Scaffold( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return Scaffold(
      // Analise da Linha: backgroundColor: const Color(0xFFFAFAFC),
      // backgroundColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // const Color(0xFFFAFAFC) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      backgroundColor: const Color(0xFFFAFAFC),
      // Analise da Linha: appBar: AppBar(
      // appBar = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // AppBar( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      appBar: AppBar(
        // Analise da Linha: backgroundColor: AppColors.background,
        // backgroundColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // AppColors.background = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        backgroundColor: AppColors.background,
        // Analise da Linha: elevation: 0,
        // elevation = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // 0 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        elevation: 0,
        // Analise da Linha: leading: IconButton(
        // leading = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // IconButton( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        leading: IconButton(
          // Analise da Linha: icon: const Icon(Icons.arrow_back, color: Color(0xFF4B5563)),
          // icon = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // const Icon(Icons.arrow_back, color: Color(0xFF4B5563)) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4B5563)),
          // Analise da Linha: onPressed: () => Navigator.pop(context),
          // onPressed = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // () => Navigator.pop(context) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          onPressed: () => Navigator.pop(context),
        // Analise da Linha: ),
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
        ),
        // Analise da Linha: title: const Text(
        // title = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // const Text( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        title: const Text(
          // Analise da Linha: 'Perguntas privadas',
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
          'Perguntas privadas',
          // Analise da Linha: style: TextStyle(
          // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          style: TextStyle(
            // Analise da Linha: color: AppColors.textPrimary,
            // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // AppColors.textPrimary = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            color: AppColors.textPrimary,
            // Analise da Linha: fontSize: 22,
            // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // 22 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            fontSize: 22,
            // Analise da Linha: fontWeight: FontWeight.w800,
            // fontWeight = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // FontWeight.w800 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            fontWeight: FontWeight.w800,
          // Analise da Linha: ),
          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
          // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
          ),
        // Analise da Linha: ),
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
        ),
        // Analise da Linha: centerTitle: true,
        // centerTitle = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // true = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        centerTitle: true,
      // Analise da Linha: ),
      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
      // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
      ),
      // Analise da Linha: body: Column(
      // body = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // Column( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      body: Column(
        // Analise da Linha: children: [
        // children = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        children: [
          // Analise da Linha: _buildStartupHeader(),
          // _buildStartupHeader = Chamada de Construtor/Funcao. Cria um widget/objeto ou executa um metodo.
          // ( ) = Delimitadores de Argumentos. Contem os valores enviados na chamada.
          // , = Separador de Argumento. Mantem a lista externa em continuidade.
          _buildStartupHeader(),
          // Analise da Linha: Expanded(
          // Expanded = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
          // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
          Expanded(
            // Analise da Linha: child: _messages.isEmpty
            // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // _messages.isEmpty = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            child: _messages.isEmpty
                // Analise da Linha: ? _buildEmptyState()
                // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                ? _buildEmptyState()
                // Analise da Linha: : ListView.separated(
                // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                : ListView.separated(
                    // Analise da Linha: controller: _scrollController,
                    // controller = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // _scrollController = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    controller: _scrollController,
                    // Analise da Linha: padding: const EdgeInsets.fromLTRB(30, 26, 24, 24),
                    // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // const EdgeInsets.fromLTRB(30, 26, 24, 24) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    padding: const EdgeInsets.fromLTRB(30, 26, 24, 24),
                    // Analise da Linha: itemCount: _messages.length,
                    // itemCount = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // _messages.length = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    itemCount: _messages.length,
                    // Analise da Linha: separatorBuilder: (_, index) => const SizedBox(height: 22),
                    // separatorBuilder = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // (_, index) => const SizedBox(height: 22) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    separatorBuilder: (_, index) => const SizedBox(height: 22),
                    // Analise da Linha: itemBuilder: (context, index) {
                    // itemBuilder = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // (context, index) { = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    itemBuilder: (context, index) {
                      // Analise da Linha: return _buildMessageBubble(_messages[index]);
                      // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
                      // _buildMessageBubble(_messages[index]) = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
                      // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
                      return _buildMessageBubble(_messages[index]);
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
          // Analise da Linha: _buildMessageComposer(),
          // _buildMessageComposer = Chamada de Construtor/Funcao. Cria um widget/objeto ou executa um metodo.
          // ( ) = Delimitadores de Argumentos. Contem os valores enviados na chamada.
          // , = Separador de Argumento. Mantem a lista externa em continuidade.
          _buildMessageComposer(),
        // Analise da Linha: ],
        // ] = Fechamento de Lista. Encerra uma colecao ou lista de widgets.
        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
        ],
      // Analise da Linha: ),
      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
      // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
      ),
    // Analise da Linha: );
    // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
    // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
    );
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // =============================================================================
  // SECAO: FUNCAO/METODO: _buildStartupHeader
  // =============================================================================
  // Analise da Linha: Widget _buildStartupHeader() {
  // Widget = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _buildStartupHeader = Identificador da Funcao/Metodo. Nome tecnico usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  Widget _buildStartupHeader() {
    // Analise da Linha: final startupName = widget.startup.name.trim();
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // startupName = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // widget.startup.name.trim() = Expressao de Valor. Resultado armazenado nesta variavel.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
    final startupName = widget.startup.name.trim();

    // Analise da Linha: return Container(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // Container( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return Container(
      // Analise da Linha: width: double.infinity,
      // width = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // double.infinity = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      width: double.infinity,
      // Analise da Linha: padding: const EdgeInsets.fromLTRB(30, 18, 30, 18),
      // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // const EdgeInsets.fromLTRB(30, 18, 30, 18) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      padding: const EdgeInsets.fromLTRB(30, 18, 30, 18),
      // Analise da Linha: decoration: const BoxDecoration(
      // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // const BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      decoration: const BoxDecoration(
        // Analise da Linha: color: Color(0xFFFFFBFF),
        // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // Color(0xFFFFFBFF) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        color: Color(0xFFFFFBFF),
        // Analise da Linha: border: Border(bottom: BorderSide(color: Color(0xFFEDE7F6), width: 1)),
        // border = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // Border(bottom: BorderSide(color: Color(0xFFEDE7F6), width: 1)) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        border: Border(bottom: BorderSide(color: Color(0xFFEDE7F6), width: 1)),
      // Analise da Linha: ),
      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
      // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
      ),
      // Analise da Linha: child: Row(
      // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // Row( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      child: Row(
        // Analise da Linha: children: [
        // children = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        children: [
          // Analise da Linha: Container(
          // Container = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
          // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
          Container(
            // Analise da Linha: width: 44,
            // width = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // 44 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            width: 44,
            // Analise da Linha: height: 44,
            // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // 44 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            height: 44,
            // Analise da Linha: decoration: BoxDecoration(
            // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            decoration: BoxDecoration(
              // Analise da Linha: color: AppColors.white,
              // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // AppColors.white = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              color: AppColors.white,
              // Analise da Linha: shape: BoxShape.circle,
              // shape = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // BoxShape.circle = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              shape: BoxShape.circle,
              // Analise da Linha: boxShadow: [
              // boxShadow = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              boxShadow: [
                // Analise da Linha: BoxShadow(
                // BoxShadow = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
                // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
                BoxShadow(
                  // Analise da Linha: color: Colors.black.withValues(alpha: 0.05),
                  // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // Colors.black.withValues(alpha: 0.05) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  color: Colors.black.withValues(alpha: 0.05),
                  // Analise da Linha: blurRadius: 12,
                  // blurRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // 12 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  blurRadius: 12,
                  // Analise da Linha: offset: const Offset(0, 4),
                  // offset = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // const Offset(0, 4) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  offset: const Offset(0, 4),
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
            // Analise da Linha: child: const Icon(
            // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // const Icon( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            child: const Icon(
              // Analise da Linha: Icons.lock_outline,
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              Icons.lock_outline,
              // Analise da Linha: color: AppColors.primary,
              // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // AppColors.primary = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              color: AppColors.primary,
              // Analise da Linha: size: 24,
              // size = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // 24 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              size: 24,
            // Analise da Linha: ),
            // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
            // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
            ),
          // Analise da Linha: ),
          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
          // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
          ),

          // =============================================================================
          // SECAO: CONSTRUTOR: SizedBox
          // =============================================================================
          // Analise da Linha: const SizedBox(width: 16),
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
          const SizedBox(width: 16),
          // Analise da Linha: Expanded(
          // Expanded = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
          // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
          Expanded(
            // Analise da Linha: child: Column(
            // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // Column( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            child: Column(
              // Analise da Linha: crossAxisAlignment: CrossAxisAlignment.start,
              // crossAxisAlignment = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // CrossAxisAlignment.start = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              crossAxisAlignment: CrossAxisAlignment.start,
              // Analise da Linha: children: [
              // children = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              children: [
                // Analise da Linha: if (startupName.isNotEmpty) ...[
                // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                if (startupName.isNotEmpty) ...[
                  // Analise da Linha: Text(
                  // Text = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
                  // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
                  Text(
                    // Analise da Linha: startupName,
                    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                    // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                    startupName,
                    // Analise da Linha: maxLines: 1,
                    // maxLines = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // 1 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    maxLines: 1,
                    // Analise da Linha: overflow: TextOverflow.ellipsis,
                    // overflow = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // TextOverflow.ellipsis = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    overflow: TextOverflow.ellipsis,
                    // Analise da Linha: style: const TextStyle(
                    // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // const TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    style: const TextStyle(
                      // Analise da Linha: color: AppColors.textPrimary,
                      // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                      // AppColors.textPrimary = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                      // , = Separador de Argumento. Permite informar outro argumento depois.
                      color: AppColors.textPrimary,
                      // Analise da Linha: fontSize: 18,
                      // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                      // 18 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                      // , = Separador de Argumento. Permite informar outro argumento depois.
                      fontSize: 18,
                      // Analise da Linha: fontWeight: FontWeight.w800,
                      // fontWeight = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                      // FontWeight.w800 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                      // , = Separador de Argumento. Permite informar outro argumento depois.
                      fontWeight: FontWeight.w800,
                    // Analise da Linha: ),
                    // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                    // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                    ),
                  // Analise da Linha: ),
                  // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                  // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                  ),
                  // Analise da Linha: const SizedBox(height: 2),
                  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                  // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                  const SizedBox(height: 2),
                // Analise da Linha: ],
                // ] = Fechamento de Lista. Encerra uma colecao ou lista de widgets.
                // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                ],

                // =============================================================================
                // SECAO: CONSTRUTOR: Text
                // =============================================================================
                // Analise da Linha: const Text(
                // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
                // Text = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
                // ( = Delimitador de Parametros. Inicia a lista de argumentos recebidos pelo construtor.
                const Text(
                  // Analise da Linha: 'Chat restrito para investidores',
                  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                  // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                  'Chat restrito para investidores',
                  // Analise da Linha: style: TextStyle(
                  // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  style: TextStyle(
                    // Analise da Linha: color: Color(0xFF6200EE),
                    // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // Color(0xFF6200EE) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    color: Color(0xFF6200EE),
                    // Analise da Linha: fontSize: 15,
                    // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // 15 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    fontSize: 15,
                    // Analise da Linha: fontWeight: FontWeight.w600,
                    // fontWeight = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // FontWeight.w600 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    fontWeight: FontWeight.w600,
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
        // Analise da Linha: ],
        // ] = Fechamento de Lista. Encerra uma colecao ou lista de widgets.
        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
        ],
      // Analise da Linha: ),
      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
      // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
      ),
    // Analise da Linha: );
    // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
    // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
    );
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // =============================================================================
  // SECAO: FUNCAO/METODO: _buildEmptyState
  // =============================================================================
  // Analise da Linha: Widget _buildEmptyState() {
  // Widget = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _buildEmptyState = Identificador da Funcao/Metodo. Nome tecnico usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  Widget _buildEmptyState() {
    // Analise da Linha: return Center(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // Center( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return Center(
      // Analise da Linha: child: Padding(
      // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // Padding( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      child: Padding(
        // Analise da Linha: padding: const EdgeInsets.symmetric(horizontal: 36),
        // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // const EdgeInsets.symmetric(horizontal: 36) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        padding: const EdgeInsets.symmetric(horizontal: 36),
        // Analise da Linha: child: Column(
        // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // Column( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        child: Column(
          // Analise da Linha: mainAxisSize: MainAxisSize.min,
          // mainAxisSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // MainAxisSize.min = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          mainAxisSize: MainAxisSize.min,
          // Analise da Linha: children: [
          // children = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          children: [
            // Analise da Linha: Container(
            // Container = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
            // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
            Container(
              // Analise da Linha: width: 76,
              // width = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // 76 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              width: 76,
              // Analise da Linha: height: 76,
              // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // 76 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              height: 76,
              // Analise da Linha: decoration: const BoxDecoration(
              // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // const BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              decoration: const BoxDecoration(
                // Analise da Linha: color: Color(0xFFF8F0FF),
                // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // Color(0xFFF8F0FF) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                color: Color(0xFFF8F0FF),
                // Analise da Linha: shape: BoxShape.circle,
                // shape = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // BoxShape.circle = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                shape: BoxShape.circle,
              // Analise da Linha: ),
              // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
              // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
              ),
              // Analise da Linha: child: const Icon(
              // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // const Icon( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              child: const Icon(
                // Analise da Linha: Icons.chat_bubble_outline,
                // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                Icons.chat_bubble_outline,
                // Analise da Linha: color: AppColors.primary,
                // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // AppColors.primary = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                color: AppColors.primary,
                // Analise da Linha: size: 36,
                // size = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 36 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                size: 36,
              // Analise da Linha: ),
              // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
              // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
              ),
            // Analise da Linha: ),
            // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
            // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
            ),

            // =============================================================================
            // SECAO: CONSTRUTOR: SizedBox
            // =============================================================================
            // Analise da Linha: const SizedBox(height: 18),
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
            const SizedBox(height: 18),

            // =============================================================================
            // SECAO: CONSTRUTOR: Text
            // =============================================================================
            // Analise da Linha: const Text(
            // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
            // Text = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
            // ( = Delimitador de Parametros. Inicia a lista de argumentos recebidos pelo construtor.
            const Text(
              // Analise da Linha: 'Nenhuma pergunta privada ainda.',
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              'Nenhuma pergunta privada ainda.',
              // Analise da Linha: textAlign: TextAlign.center,
              // textAlign = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // TextAlign.center = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              textAlign: TextAlign.center,
              // Analise da Linha: style: TextStyle(
              // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              style: TextStyle(
                // Analise da Linha: color: AppColors.textPrimary,
                // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // AppColors.textPrimary = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                color: AppColors.textPrimary,
                // Analise da Linha: fontSize: 18,
                // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 18 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                fontSize: 18,
                // Analise da Linha: fontWeight: FontWeight.w800,
                // fontWeight = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // FontWeight.w800 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                fontWeight: FontWeight.w800,
              // Analise da Linha: ),
              // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
              // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
              ),
            // Analise da Linha: ),
            // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
            // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
            ),

            // =============================================================================
            // SECAO: CONSTRUTOR: SizedBox
            // =============================================================================
            // Analise da Linha: const SizedBox(height: 8),
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
            const SizedBox(height: 8),

            // =============================================================================
            // SECAO: CONSTRUTOR: Text
            // =============================================================================
            // Analise da Linha: const Text(
            // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
            // Text = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
            // ( = Delimitador de Parametros. Inicia a lista de argumentos recebidos pelo construtor.
            const Text(
              // Analise da Linha: 'As perguntas enviadas por investidores aparecer\u00e3o aqui.',
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              'As perguntas enviadas por investidores aparecer\u00e3o aqui.',
              // Analise da Linha: textAlign: TextAlign.center,
              // textAlign = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // TextAlign.center = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              textAlign: TextAlign.center,
              // Analise da Linha: style: TextStyle(
              // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              style: TextStyle(
                // Analise da Linha: color: Color(0xFF697386),
                // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // Color(0xFF697386) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                color: Color(0xFF697386),
                // Analise da Linha: fontSize: 15,
                // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 15 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                fontSize: 15,
                // Analise da Linha: height: 1.4,
                // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 1.4 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                height: 1.4,
                // Analise da Linha: fontWeight: FontWeight.w500,
                // fontWeight = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // FontWeight.w500 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                fontWeight: FontWeight.w500,
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
    // Analise da Linha: );
    // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
    // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
    );
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // =============================================================================
  // SECAO: FUNCAO/METODO: _buildMessageBubble
  // =============================================================================
  // Analise da Linha: Widget _buildMessageBubble(_PrivateChatMessage message) {
  // Widget = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _buildMessageBubble = Identificador da Funcao/Metodo. Nome tecnico usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  Widget _buildMessageBubble(_PrivateChatMessage message) {
    // Analise da Linha: final screenWidth = MediaQuery.of(context).size.width;
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // screenWidth = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // MediaQuery.of(context).size.width = Expressao de Valor. Resultado armazenado nesta variavel.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
    final screenWidth = MediaQuery.of(context).size.width;
    // Analise da Linha: final bubbleColor = message.isMine ? AppColors.primary : AppColors.white;
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // bubbleColor = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // message.isMine ? AppColors.primary : AppColors.white = Expressao de Valor. Resultado armazenado nesta variavel.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
    final bubbleColor = message.isMine ? AppColors.primary : AppColors.white;
    // Analise da Linha: final textColor = message.isMine ? AppColors.white : AppColors.textPrimary;
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // textColor = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // message.isMine ? AppColors.white : AppColors.textPrimary = Expressao de Valor. Resultado armazenado nesta variavel.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
    final textColor = message.isMine ? AppColors.white : AppColors.textPrimary;

    // Analise da Linha: return Align(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // Align( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return Align(
      // Analise da Linha: alignment: message.isMine ? Alignment.centerRight : Alignment.centerLeft,
      // alignment = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // message.isMine ? Alignment.centerRight : Alignment.centerLeft = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      alignment: message.isMine ? Alignment.centerRight : Alignment.centerLeft,
      // Analise da Linha: child: Column(
      // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // Column( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      child: Column(
        // Analise da Linha: crossAxisAlignment: message.isMine
        // crossAxisAlignment = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // message.isMine = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        crossAxisAlignment: message.isMine
            // Analise da Linha: ? CrossAxisAlignment.end
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            ? CrossAxisAlignment.end
            // Analise da Linha: : CrossAxisAlignment.start,
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
            : CrossAxisAlignment.start,
        // Analise da Linha: children: [
        // children = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        children: [
          // Analise da Linha: Container(
          // Container = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
          // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
          Container(
            // Analise da Linha: constraints: BoxConstraints(maxWidth: screenWidth * 0.72),
            // constraints = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // BoxConstraints(maxWidth: screenWidth * 0.72) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            constraints: BoxConstraints(maxWidth: screenWidth * 0.72),
            // Analise da Linha: padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // const EdgeInsets.symmetric(horizontal: 20, vertical: 16) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            // Analise da Linha: decoration: BoxDecoration(
            // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            decoration: BoxDecoration(
              // Analise da Linha: color: bubbleColor,
              // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // bubbleColor = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              color: bubbleColor,
              // Analise da Linha: borderRadius: BorderRadius.circular(18),
              // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // BorderRadius.circular(18) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              borderRadius: BorderRadius.circular(18),
              // Analise da Linha: boxShadow: message.isMine
              // boxShadow = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // message.isMine = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              boxShadow: message.isMine
                  // Analise da Linha: ? null
                  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                  ? null
                  // Analise da Linha: : [
                  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                  : [
                      // Analise da Linha: BoxShadow(
                      // BoxShadow = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
                      // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
                      BoxShadow(
                        // Analise da Linha: color: Colors.black.withValues(alpha: 0.08),
                        // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                        // Colors.black.withValues(alpha: 0.08) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                        // , = Separador de Argumento. Permite informar outro argumento depois.
                        color: Colors.black.withValues(alpha: 0.08),
                        // Analise da Linha: blurRadius: 8,
                        // blurRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                        // 8 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                        // , = Separador de Argumento. Permite informar outro argumento depois.
                        blurRadius: 8,
                        // Analise da Linha: offset: const Offset(0, 2),
                        // offset = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                        // const Offset(0, 2) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                        // , = Separador de Argumento. Permite informar outro argumento depois.
                        offset: const Offset(0, 2),
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
            // Analise da Linha: child: Text(
            // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // Text( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            child: Text(
              // Analise da Linha: message.text,
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              message.text,
              // Analise da Linha: style: TextStyle(
              // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              style: TextStyle(
                // Analise da Linha: color: textColor,
                // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // textColor = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                color: textColor,
                // Analise da Linha: fontSize: 18,
                // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 18 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                fontSize: 18,
                // Analise da Linha: height: 1.35,
                // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 1.35 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                height: 1.35,
                // Analise da Linha: fontWeight: FontWeight.w500,
                // fontWeight = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // FontWeight.w500 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                fontWeight: FontWeight.w500,
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

          // =============================================================================
          // SECAO: CONSTRUTOR: SizedBox
          // =============================================================================
          // Analise da Linha: const SizedBox(height: 6),
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
          const SizedBox(height: 6),
          // Analise da Linha: Text(
          // Text = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
          // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
          Text(
            // Analise da Linha: message.time,
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
            message.time,
            // Analise da Linha: style: const TextStyle(
            // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // const TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            style: const TextStyle(
              // Analise da Linha: color: Color(0xFF8B95A7),
              // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // Color(0xFF8B95A7) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              color: Color(0xFF8B95A7),
              // Analise da Linha: fontSize: 14,
              // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // 14 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              fontSize: 14,
              // Analise da Linha: fontWeight: FontWeight.w500,
              // fontWeight = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // FontWeight.w500 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              fontWeight: FontWeight.w500,
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
    // Analise da Linha: );
    // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
    // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
    );
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // =============================================================================
  // SECAO: FUNCAO/METODO: _buildMessageComposer
  // =============================================================================
  // Analise da Linha: Widget _buildMessageComposer() {
  // Widget = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _buildMessageComposer = Identificador da Funcao/Metodo. Nome tecnico usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  Widget _buildMessageComposer() {
    // Analise da Linha: final hasText = _messageController.text.trim().isNotEmpty;
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // hasText = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // _messageController.text.trim().isNotEmpty = Expressao de Valor. Resultado armazenado nesta variavel.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
    final hasText = _messageController.text.trim().isNotEmpty;

    // Analise da Linha: return SafeArea(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // SafeArea( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return SafeArea(
      // Analise da Linha: top: false,
      // top = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // false = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      top: false,
      // Analise da Linha: child: Container(
      // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // Container( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      child: Container(
        // Analise da Linha: padding: const EdgeInsets.fromLTRB(24, 20, 20, 18),
        // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // const EdgeInsets.fromLTRB(24, 20, 20, 18) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        padding: const EdgeInsets.fromLTRB(24, 20, 20, 18),
        // Analise da Linha: decoration: const BoxDecoration(
        // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // const BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        decoration: const BoxDecoration(
          // Analise da Linha: color: AppColors.background,
          // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // AppColors.background = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          color: AppColors.background,
          // Analise da Linha: border: Border(top: BorderSide(color: Color(0xFFEDEFF3), width: 1)),
          // border = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // Border(top: BorderSide(color: Color(0xFFEDEFF3), width: 1)) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          border: Border(top: BorderSide(color: Color(0xFFEDEFF3), width: 1)),
        // Analise da Linha: ),
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
        ),
        // Analise da Linha: child: Row(
        // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // Row( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        child: Row(
          // Analise da Linha: children: [
          // children = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          children: [
            // Analise da Linha: Expanded(
            // Expanded = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
            // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
            Expanded(
              // Analise da Linha: child: Container(
              // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // Container( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              child: Container(
                // Analise da Linha: height: 62,
                // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 62 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                height: 62,
                // Analise da Linha: padding: const EdgeInsets.symmetric(horizontal: 24),
                // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // const EdgeInsets.symmetric(horizontal: 24) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                padding: const EdgeInsets.symmetric(horizontal: 24),
                // Analise da Linha: decoration: BoxDecoration(
                // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                decoration: BoxDecoration(
                  // Analise da Linha: color: const Color(0xFFF0F1F4),
                  // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // const Color(0xFFF0F1F4) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  color: const Color(0xFFF0F1F4),
                  // Analise da Linha: borderRadius: BorderRadius.circular(31),
                  // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // BorderRadius.circular(31) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  borderRadius: BorderRadius.circular(31),
                // Analise da Linha: ),
                // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                ),
                // Analise da Linha: alignment: Alignment.center,
                // alignment = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // Alignment.center = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                alignment: Alignment.center,
                // Analise da Linha: child: TextField(
                // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // TextField( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                child: TextField(
                  // Analise da Linha: controller: _messageController,
                  // controller = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // _messageController = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  controller: _messageController,
                  // Analise da Linha: onChanged: (_) => setState(() {}),
                  // onChanged = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // (_) => setState(() {}) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  onChanged: (_) => setState(() {}),
                  // Analise da Linha: decoration: const InputDecoration(
                  // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // const InputDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  decoration: const InputDecoration(
                    // Analise da Linha: isCollapsed: true,
                    // isCollapsed = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // true = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    isCollapsed: true,
                    // Analise da Linha: border: InputBorder.none,
                    // border = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // InputBorder.none = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    border: InputBorder.none,
                    // Analise da Linha: hintText: 'Escreva sua mensagem...',
                    // hintText = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // 'Escreva sua mensagem...' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    hintText: 'Escreva sua mensagem...',
                    // Analise da Linha: hintStyle: TextStyle(
                    // hintStyle = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    hintStyle: TextStyle(
                      // Analise da Linha: color: Color(0xFF697386),
                      // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                      // Color(0xFF697386) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                      // , = Separador de Argumento. Permite informar outro argumento depois.
                      color: Color(0xFF697386),
                      // Analise da Linha: fontSize: 18,
                      // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                      // 18 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                      // , = Separador de Argumento. Permite informar outro argumento depois.
                      fontSize: 18,
                      // Analise da Linha: fontWeight: FontWeight.w500,
                      // fontWeight = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                      // FontWeight.w500 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                      // , = Separador de Argumento. Permite informar outro argumento depois.
                      fontWeight: FontWeight.w500,
                    // Analise da Linha: ),
                    // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                    // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                    ),
                  // Analise da Linha: ),
                  // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                  // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                  ),
                  // Analise da Linha: style: const TextStyle(
                  // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // const TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  style: const TextStyle(
                    // Analise da Linha: color: AppColors.textPrimary,
                    // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // AppColors.textPrimary = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    color: AppColors.textPrimary,
                    // Analise da Linha: fontSize: 18,
                    // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // 18 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    fontSize: 18,
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
            // Analise da Linha: ),
            // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
            // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
            ),

            // =============================================================================
            // SECAO: CONSTRUTOR: SizedBox
            // =============================================================================
            // Analise da Linha: const SizedBox(width: 14),
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
            const SizedBox(width: 14),
            // Analise da Linha: SizedBox(
            // SizedBox = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
            // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
            SizedBox(
              // Analise da Linha: width: 58,
              // width = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // 58 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              width: 58,
              // Analise da Linha: height: 58,
              // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // 58 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              height: 58,
              // Analise da Linha: child: ElevatedButton(
              // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // ElevatedButton( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              child: ElevatedButton(
                // Analise da Linha: onPressed: hasText ? _sendMessage : null,
                // onPressed = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // hasText ? _sendMessage : null = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                onPressed: hasText ? _sendMessage : null,
                // Analise da Linha: style: ElevatedButton.styleFrom(
                // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // ElevatedButton.styleFrom( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                style: ElevatedButton.styleFrom(
                  // Analise da Linha: elevation: 0,
                  // elevation = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // 0 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  elevation: 0,
                  // Analise da Linha: backgroundColor: hasText
                  // backgroundColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // hasText = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  backgroundColor: hasText
                      // Analise da Linha: ? AppColors.primary
                      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                      ? AppColors.primary
                      // Analise da Linha: : const Color(0xFFD1D5DB),
                      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                      // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                      : const Color(0xFFD1D5DB),
                  // Analise da Linha: disabledBackgroundColor: const Color(0xFFD1D5DB),
                  // disabledBackgroundColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // const Color(0xFFD1D5DB) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  disabledBackgroundColor: const Color(0xFFD1D5DB),
                  // Analise da Linha: padding: EdgeInsets.zero,
                  // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // EdgeInsets.zero = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  padding: EdgeInsets.zero,
                  // Analise da Linha: shape: const CircleBorder(),
                  // shape = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // const CircleBorder() = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  shape: const CircleBorder(),
                // Analise da Linha: ),
                // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                ),
                // Analise da Linha: child: const Icon(
                // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // const Icon( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                child: const Icon(
                  // Analise da Linha: Icons.send_outlined,
                  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                  // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                  Icons.send_outlined,
                  // Analise da Linha: color: AppColors.white,
                  // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // AppColors.white = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  color: AppColors.white,
                  // Analise da Linha: size: 28,
                  // size = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // 28 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  size: 28,
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
    // Analise da Linha: );
    // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
    // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
    );
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // =============================================================================
  // SECAO: FUNCAO/METODO: _sendMessage
  // =============================================================================
  // Analise da Linha: void _sendMessage() {
  // void = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _sendMessage = Identificador da Funcao/Metodo. Nome tecnico usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  void _sendMessage() {
    // Analise da Linha: final text = _messageController.text.trim();
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // text = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // _messageController.text.trim() = Expressao de Valor. Resultado armazenado nesta variavel.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
    final text = _messageController.text.trim();
    // Analise da Linha: if (text.isEmpty) return;
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    if (text.isEmpty) return;

    // Analise da Linha: setState(() {
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // { = Abertura de Bloco. Inicia um novo escopo.
    setState(() {
      // Analise da Linha: _messages.add(
      // _messages.add = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
      // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
      _messages.add(
        // Analise da Linha: _PrivateChatMessage(
        // _PrivateChatMessage = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
        // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
        _PrivateChatMessage(
          // Analise da Linha: text: text,
          // text = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // text = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          text: text,
          // Analise da Linha: time: _formatTime(DateTime.now()),
          // time = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // _formatTime(DateTime.now()) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          time: _formatTime(DateTime.now()),
          // Analise da Linha: isMine: true,
          // isMine = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // true = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          isMine: true,
        // Analise da Linha: ),
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
        ),
      // Analise da Linha: );
      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
      // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
      );
      // Analise da Linha: _messageController.clear();
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
      _messageController.clear();
    // Analise da Linha: });
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
    // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
    // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
    });

    // Analise da Linha: WidgetsBinding.instance.addPostFrameCallback((_) {
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // { = Abertura de Bloco. Inicia um novo escopo.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Analise da Linha: if (!_scrollController.hasClients) return;
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
      if (!_scrollController.hasClients) return;
      // Analise da Linha: _scrollController.animateTo(
      // _scrollController.animateTo = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
      // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
      _scrollController.animateTo(
        // Analise da Linha: _scrollController.position.maxScrollExtent,
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
        _scrollController.position.maxScrollExtent,
        // Analise da Linha: duration: const Duration(milliseconds: 220),
        // duration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // const Duration(milliseconds: 220) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        duration: const Duration(milliseconds: 220),
        // Analise da Linha: curve: Curves.easeOut,
        // curve = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // Curves.easeOut = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        curve: Curves.easeOut,
      // Analise da Linha: );
      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
      // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
      );
    // Analise da Linha: });
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
    // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
    // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
    });
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // =============================================================================
  // SECAO: FUNCAO/METODO: _formatTime
  // =============================================================================
  // Analise da Linha: String _formatTime(DateTime dateTime) {
  // String = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _formatTime = Identificador da Funcao/Metodo. Nome tecnico usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  String _formatTime(DateTime dateTime) {
    // Analise da Linha: final hour = dateTime.hour.toString().padLeft(2, '0');
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // hour = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // dateTime.hour.toString().padLeft(2, '0') = Expressao de Valor. Resultado armazenado nesta variavel.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
    final hour = dateTime.hour.toString().padLeft(2, '0');
    // Analise da Linha: final minute = dateTime.minute.toString().padLeft(2, '0');
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // minute = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // dateTime.minute.toString().padLeft(2, '0') = Expressao de Valor. Resultado armazenado nesta variavel.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
    final minute = dateTime.minute.toString().padLeft(2, '0');
    // Analise da Linha: return '$hour:$minute';
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // '$hour:$minute' = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
    return '$hour:$minute';
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: CLASSE: _PrivateChatMessage
// =============================================================================
// Analise da Linha: class _PrivateChatMessage {
// Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
// { = Abertura de Bloco. Inicia um novo escopo.
class _PrivateChatMessage {
  // Analise da Linha: final String text;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // text = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String text;
  // Analise da Linha: final String time;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // time = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String time;
  // Analise da Linha: final bool isMine;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // bool = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // isMine = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final bool isMine;

  // =============================================================================
  // SECAO: CONSTRUTOR: _PrivateChatMessage
  // =============================================================================
  // Analise da Linha: const _PrivateChatMessage({
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // _PrivateChatMessage = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // ( = Delimitador de Parametros. Inicia a lista de argumentos recebidos pelo construtor.
  const _PrivateChatMessage({
    // Analise da Linha: required this.text,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.text = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.text,
    // Analise da Linha: required this.time,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.time = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.time,
    // Analise da Linha: this.isMine = false,
    // this.isMine = Parametro Opcional de Campo. Permite preencher esta propriedade ao construir o objeto.
    // = = Valor Padrao. Define o valor usado quando o argumento nao for informado.
    // , = Separador de Parametro. Continua a lista de parametros.
    this.isMine = false,
  // Analise da Linha: });
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
  // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
  });
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}
