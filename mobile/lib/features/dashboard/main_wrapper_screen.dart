// GUILHERME PREVENTI CORREIA
// =============================================================================
// SECAO: IMPORTACOES
// =============================================================================
// Analise da Linha: import 'package:cloud_firestore/cloud_firestore.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:cloud_firestore/cloud_firestore.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Encerra a diretiva de importacao.
import 'package:cloud_firestore/cloud_firestore.dart';
// Analise da Linha: import 'package:firebase_auth/firebase_auth.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:firebase_auth/firebase_auth.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Encerra a diretiva de importacao.
import 'package:firebase_auth/firebase_auth.dart';
// Analise da Linha: import 'package:flutter/material.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:flutter/material.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Encerra a diretiva de importacao.
import 'package:flutter/material.dart';
// Analise da Linha: import 'package:mobile/features/startups/presentation/screen/list/catalogo_de_startups.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:mobile/features/startups/presentation/screen/list/catalogo_de_startups.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Encerra a diretiva de importacao.
import 'package:mobile/features/startups/presentation/screen/list/catalogo_de_startups.dart';
// Analise da Linha: import 'package:mobile/features/wallet/presentation/trade_market.dart'
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:mobile/features/wallet/presentation/trade_market.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
import 'package:mobile/features/wallet/presentation/trade_market.dart'
    // Analise da Linha: as camila_market;
    // as = Palavra-chave de Alias. Cria um apelido para acessar os membros do import sem conflito de nomes.
    // camila_market = Identificador do Alias. Nome usado para chamar classes e funcoes deste pacote importado.
    // ; = Finalizador de Instrucao. Encerra a diretiva de importacao com alias.
    as camila_market;
// Analise da Linha: import 'package:mobile/features/profile/presentation/profile_screen.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:mobile/features/profile/presentation/profile_screen.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Encerra a diretiva de importacao.
import 'package:mobile/features/profile/presentation/profile_screen.dart';
// Analise da Linha: import 'package:mobile/features/wallet/presentation/wallet_dashboard_screen.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:mobile/features/wallet/presentation/wallet_dashboard_screen.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Encerra a diretiva de importacao.
import 'package:mobile/features/wallet/presentation/wallet_dashboard_screen.dart';

// =============================================================================
// SECAO: CLASSE: MainWrapperScreen
// =============================================================================
// Analise da Linha: class MainWrapperScreen extends StatefulWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo do Dart.
// MainWrapperScreen = Identificador da Classe. Nome usado para instanciar ou referenciar este widget/objeto.
// extends = Relacao de Heranca. Faz a classe receber comportamento base de StatefulWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class MainWrapperScreen extends StatefulWidget {
  // =============================================================================
  // SECAO: CONSTRUTOR: MainWrapperScreen
  // =============================================================================
  // Analise da Linha: const MainWrapperScreen({super.key});
  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
  // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
  // { = Abertura de Bloco. Inicia um novo escopo.
  // } = Fechamento de Bloco. Encerra um escopo aberto anteriormente.
  const MainWrapperScreen({super.key});

  // Analise da Linha: @override
  // @override = Anotacao de Sobrescrita. Informa que o metodo abaixo substitui um metodo herdado.
  @override
  // =============================================================================
  // SECAO: FUNCAO/METODO: createState
  // =============================================================================
  // Analise da Linha: State<MainWrapperScreen> createState() => _MainWrapperScreenState();
  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
  // => = Arrow Function. Retorna a expressao da direita de forma compacta.
  // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: CLASSE: _MainWrapperScreenState
// =============================================================================
// Analise da Linha: class _MainWrapperScreenState extends State<MainWrapperScreen> {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo do Dart.
// _MainWrapperScreenState = Identificador da Classe. Nome usado para instanciar ou referenciar este widget/objeto.
// extends = Relacao de Heranca. Faz a classe receber comportamento base de State<MainWrapperScreen>.
// { = Abertura de Bloco. Inicia o corpo da classe.
class _MainWrapperScreenState extends State<MainWrapperScreen> {
  // Analise da Linha: int _currentIndex = 0;
  // int = Tipo da Variavel. Define quais valores podem ser armazenados nesta propriedade.
  // _currentIndex = Identificador da Variavel. Nome interno usado pelo estado do widget.
  // = = Operador de Atribuicao. Define o valor inicial da variavel.
  // 0 = Expressao de Valor. Valor inicial guardado na variavel.
  // ; = Finalizador de Instrucao. Encerra a declaracao da variavel.
  int _currentIndex = 0;

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
    // Analise da Linha: return Scaffold(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // Scaffold( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return Scaffold(
      // Analise da Linha: body: IndexedStack(
      // body = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // IndexedStack( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      body: IndexedStack(
        // Analise da Linha: index: _currentIndex,
        // index = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // _currentIndex = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        index: _currentIndex,
        // Analise da Linha: children: [
        // children = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        children: [
          // =============================================================================
          // SECAO: CONSTRUTOR: WalletDashboardScreen
          // =============================================================================
          // Analise da Linha: const WalletDashboardScreen(),
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
          const WalletDashboardScreen(),

          // =============================================================================
          // SECAO: CONSTRUTOR: CatalogoStartupsPage
          // =============================================================================
          // Analise da Linha: const CatalogoStartupsPage(),
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
          const CatalogoStartupsPage(),
          // Analise da Linha: _buildBalcaoComTrava(),
          // _buildBalcaoComTrava = Chamada de Construtor/Funcao. Cria um widget/objeto ou executa um metodo.
          // ( ) = Delimitadores de Argumentos. Contem os valores enviados na chamada.
          // , = Separador de Argumento. Mantem a lista externa em continuidade.
          _buildBalcaoComTrava(),

          // =============================================================================
          // SECAO: CONSTRUTOR: ProfileScreen
          // =============================================================================
          // Analise da Linha: const ProfileScreen(),
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
          const ProfileScreen(),
          // Analise da Linha: ],
          // ] = Fechamento de Lista. Encerra uma colecao ou lista de widgets.
          // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
        ],
        // Analise da Linha: ),
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
      ),
      // BARRA DE NAVEGACAO GLOBAL
      // Analise da Linha: bottomNavigationBar: Container(
      // bottomNavigationBar = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // Container( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      bottomNavigationBar: Container(
        // Analise da Linha: margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        // margin = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // const EdgeInsets.fromLTRB(20, 0, 20, 20) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        // Analise da Linha: height: 70,
        // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // 70 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        height: 70,
        // Analise da Linha: decoration: BoxDecoration(
        // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        decoration: BoxDecoration(
          // Analise da Linha: color: const Color(0xFF222222),
          // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // const Color(0xFF222222) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          color: const Color(0xFF222222),
          // Analise da Linha: borderRadius: BorderRadius.circular(35),
          // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // BorderRadius.circular(35) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          borderRadius: BorderRadius.circular(35),
          // Analise da Linha: ),
          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
          // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
        ),
        // Analise da Linha: child: Row(
        // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // Row( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        child: Row(
          // Analise da Linha: mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // mainAxisAlignment = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // MainAxisAlignment.spaceEvenly = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // Analise da Linha: children: [
          // children = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          children: [
            // Analise da Linha: GestureDetector(
            // GestureDetector = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
            // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
            GestureDetector(
              // Analise da Linha: onTap: () => setState(() => _currentIndex = 0),
              // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // () => setState(() => _currentIndex = 0) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              onTap: () => setState(() => _currentIndex = 0),
              // Analise da Linha: child: _buildNavItem(Icons.home_outlined, "Home", 0),
              // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // _buildNavItem(Icons.home_outlined, "Home", 0) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              child: _buildNavItem(Icons.home_outlined, "Home", 0),
              // Analise da Linha: ),
              // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
              // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
            ),
            // Analise da Linha: GestureDetector(
            // GestureDetector = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
            // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
            GestureDetector(
              // Analise da Linha: onTap: () => setState(() => _currentIndex = 1),
              // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // () => setState(() => _currentIndex = 1) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              onTap: () => setState(() => _currentIndex = 1),
              // Analise da Linha: child: _buildNavItem(Icons.search, "Explorar", 1),
              // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // _buildNavItem(Icons.search, "Explorar", 1) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              child: _buildNavItem(Icons.search, "Explorar", 1),
              // Analise da Linha: ),
              // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
              // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
            ),
            // Analise da Linha: GestureDetector(
            // GestureDetector = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
            // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
            GestureDetector(
              // Analise da Linha: onTap: () => setState(() => _currentIndex = 2),
              // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // () => setState(() => _currentIndex = 2) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              onTap: () => setState(() => _currentIndex = 2),
              // Analise da Linha: child: _buildNavItem(Icons.grid_view, "Balcão", 2),
              // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // _buildNavItem(Icons.grid_view, "Balcão", 2) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              child: _buildNavItem(Icons.grid_view, "Balcão", 2),
              // Analise da Linha: ),
              // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
              // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
            ),
            // Analise da Linha: GestureDetector(
            // GestureDetector = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
            // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
            GestureDetector(
              // Analise da Linha: onTap: () => setState(() => _currentIndex = 3),
              // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // () => setState(() => _currentIndex = 3) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              onTap: () => setState(() => _currentIndex = 3),
              // Analise da Linha: child: _buildNavItem(Icons.person_outline, "Perfil", 3),
              // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // _buildNavItem(Icons.person_outline, "Perfil", 3) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              child: _buildNavItem(Icons.person_outline, "Perfil", 3),
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
      // ; = Finalizador de Instrucao. Encerra a expressao atual.
    );
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // TRAVA DA REGRA DE INVESTIDOR PARA O BALCAO

  // =============================================================================
  // SECAO: FUNCAO/METODO: _buildBalcaoComTrava
  // =============================================================================
  // Analise da Linha: Widget _buildBalcaoComTrava() {
  // Widget = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _buildBalcaoComTrava = Identificador da Funcao/Metodo. Nome usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  Widget _buildBalcaoComTrava() {
    // Analise da Linha: final userId = FirebaseAuth.instance.currentUser?.uid;
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // userId = Identificador da Variavel. Rotulo usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // FirebaseAuth.instance.currentUser?.uid = Expressao de Valor. Resultado armazenado nesta variavel.
    // ; = Finalizador de Instrucao. Encerra a declaracao local.
    final userId = FirebaseAuth.instance.currentUser?.uid;
    // Analise da Linha: if (userId == null) return _buildBalcaoBloqueado();
    // if = Estrutura Condicional em Linha. Testa uma condicao antes de retornar imediatamente.
    // (userId == null) = Expressao Condicional. Define quando o retorno antecipado acontece.
    // return = Instrucao de Retorno. Sai da funcao ou metodo com o valor informado.
    // ; = Finalizador de Instrucao. Encerra o retorno em linha.
    if (userId == null) return _buildBalcaoBloqueado();

    // Analise da Linha: return StreamBuilder<QuerySnapshot>(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // StreamBuilder<QuerySnapshot>( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return StreamBuilder<QuerySnapshot>(
      // Analise da Linha: stream: FirebaseFirestore.instance
      // stream = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // FirebaseFirestore.instance = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      stream: FirebaseFirestore.instance
          // Analise da Linha: .collection('users')
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          .collection('users')
          // Analise da Linha: .doc(userId)
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          .doc(userId)
          // Analise da Linha: .collection('investimentos')
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          .collection('investimentos')
          // Analise da Linha: .snapshots(),
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
          .snapshots(),
      // Analise da Linha: builder: (context, snapshot) {
      // builder = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // (context, snapshot) { = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      builder: (context, snapshot) {
        // Analise da Linha: if (snapshot.connectionState == ConnectionState.waiting) {
        // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
        // (snapshot.connectionState == ConnectionState.waiting) = Expressao Condicional. Teste logico avaliado antes de executar o bloco.
        // { = Abertura de Bloco Condicional. Inicia as instrucoes do if.
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Analise da Linha: return const Center(child: CircularProgressIndicator());
          // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
          // const Center(child: CircularProgressIndicator()) = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
          // ; = Finalizador de Instrucao. Encerra o retorno.
          return const Center(child: CircularProgressIndicator());
          // Analise da Linha: }
          // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
        }

        // Analise da Linha: final docs = snapshot.data?.docs ?? [];
        // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
        // docs = Identificador da Variavel. Rotulo usado para acessar o resultado depois.
        // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
        // snapshot.data?.docs ?? [] = Expressao de Valor. Resultado armazenado nesta variavel.
        // ; = Finalizador de Instrucao. Encerra a declaracao local.
        final docs = snapshot.data?.docs ?? [];
        // Analise da Linha: final isInvestor = docs.any((doc) {
        // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
        // isInvestor = Identificador da Variavel. Rotulo usado para acessar o resultado depois.
        // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
        // docs.any((doc) { = Expressao de Valor. Resultado armazenado nesta variavel.
        final isInvestor = docs.any((doc) {
          // Analise da Linha: final data = doc.data() as Map<String, dynamic>;
          // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
          // data = Identificador da Variavel. Rotulo usado para acessar o resultado depois.
          // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
          // doc.data() as Map<String, dynamic> = Expressao de Valor. Resultado armazenado nesta variavel.
          // ; = Finalizador de Instrucao. Encerra a declaracao local.
          final data = doc.data() as Map<String, dynamic>;
          // Analise da Linha: return (data['tokensComprados'] ?? 0) > 0;
          // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
          // (data['tokensComprados'] ?? 0) > 0 = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
          // ; = Finalizador de Instrucao. Encerra o retorno.
          return (data['tokensComprados'] ?? 0) > 0;
          // Analise da Linha: });
          // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
          // ; = Finalizador de Instrucao. Encerra a expressao atual.
        });

        // Analise da Linha: if (isInvestor) {
        // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
        // (isInvestor) = Expressao Condicional. Teste logico avaliado antes de executar o bloco.
        // { = Abertura de Bloco Condicional. Inicia as instrucoes do if.
        if (isInvestor) {
          // Analise da Linha: return const camila_market.BalcaoNegociacaoPage();
          // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
          // const camila_market.BalcaoNegociacaoPage() = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
          // ; = Finalizador de Instrucao. Encerra o retorno.
          return const camila_market.BalcaoNegociacaoPage();
          // Analise da Linha: }
          // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
        }

        // Analise da Linha: return _buildBalcaoBloqueado();
        // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
        // _buildBalcaoBloqueado() = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
        // ; = Finalizador de Instrucao. Encerra o retorno.
        return _buildBalcaoBloqueado();
        // Analise da Linha: },
        // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
      },
      // Analise da Linha: );
      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
      // ; = Finalizador de Instrucao. Encerra a expressao atual.
    );
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // =============================================================================
  // SECAO: FUNCAO/METODO: _buildBalcaoBloqueado
  // =============================================================================
  // Analise da Linha: Widget _buildBalcaoBloqueado() {
  // Widget = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _buildBalcaoBloqueado = Identificador da Funcao/Metodo. Nome usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  Widget _buildBalcaoBloqueado() {
    // Analise da Linha: return Scaffold(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // Scaffold( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return Scaffold(
      // Analise da Linha: backgroundColor: const Color(0xFFF8F9FB),
      // backgroundColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // const Color(0xFFF8F9FB) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      backgroundColor: const Color(0xFFF8F9FB),
      // Analise da Linha: body: Center(
      // body = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // Center( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      body: Center(
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
                // Analise da Linha: width: 88,
                // width = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 88 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                width: 88,
                // Analise da Linha: height: 88,
                // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 88 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                height: 88,
                // Analise da Linha: decoration: BoxDecoration(
                // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                decoration: BoxDecoration(
                  // Analise da Linha: color: const Color(0xFFF3EDFF),
                  // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // const Color(0xFFF3EDFF) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  color: const Color(0xFFF3EDFF),
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
                      // Analise da Linha: color: const Color(0xFF512DA8).withValues(alpha: 0.10),
                      // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                      // const Color(0xFF512DA8).withValues(alpha: 0.10) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                      // , = Separador de Argumento. Permite informar outro argumento depois.
                      color: const Color(0xFF512DA8).withValues(alpha: 0.10),
                      // Analise da Linha: blurRadius: 24,
                      // blurRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                      // 24 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                      // , = Separador de Argumento. Permite informar outro argumento depois.
                      blurRadius: 24,
                      // Analise da Linha: offset: const Offset(0, 8),
                      // offset = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                      // const Offset(0, 8) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                      // , = Separador de Argumento. Permite informar outro argumento depois.
                      offset: const Offset(0, 8),
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
                  // Analise da Linha: color: Color(0xFF512DA8),
                  // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // Color(0xFF512DA8) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  color: Color(0xFF512DA8),
                  // Analise da Linha: size: 42,
                  // size = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // 42 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  size: 42,
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
              // Analise da Linha: const SizedBox(height: 28),
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              const SizedBox(height: 28),

              // =============================================================================
              // SECAO: CONSTRUTOR: Text
              // =============================================================================
              // Analise da Linha: const Text(
              // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando os argumentos tambem forem constantes.
              // Text = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
              // ({ = Abertura de Parametros Nomeados. Inicia a lista de argumentos recebidos pelo construtor.
              const Text(
                // Analise da Linha: 'Balcão Bloqueado',
                // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                'Balcão Bloqueado',
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
                  // Analise da Linha: color: Color(0xFF1D1D1F),
                  // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // Color(0xFF1D1D1F) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  color: Color(0xFF1D1D1F),
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

              // =============================================================================
              // SECAO: CONSTRUTOR: SizedBox
              // =============================================================================
              // Analise da Linha: const SizedBox(height: 14),
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              const SizedBox(height: 14),

              // =============================================================================
              // SECAO: CONSTRUTOR: Text
              // =============================================================================
              // Analise da Linha: const Text(
              // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando os argumentos tambem forem constantes.
              // Text = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
              // ({ = Abertura de Parametros Nomeados. Inicia a lista de argumentos recebidos pelo construtor.
              const Text(
                // Analise da Linha: 'Você precisa estudar uma startup e fazer seu '
                // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                'Você precisa estudar uma startup e fazer seu '
                // Analise da Linha: 'primeiro investimento através do Catálogo para '
                // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                'primeiro investimento através do Catálogo para '
                // Analise da Linha: 'desbloquear o Balcão Global.',
                // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                'desbloquear o Balcão Global.',
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
                  // Analise da Linha: color: Color(0xFF6B7280),
                  // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // Color(0xFF6B7280) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  color: Color(0xFF6B7280),
                  // Analise da Linha: fontSize: 15,
                  // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // 15 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  fontSize: 15,
                  // Analise da Linha: height: 1.45,
                  // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // 1.45 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  height: 1.45,
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
  // SECAO: FUNCAO/METODO: _buildNavItem
  // =============================================================================
  // Analise da Linha: Widget _buildNavItem(IconData icon, String label, int index) {
  // Widget = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _buildNavItem = Identificador da Funcao/Metodo. Nome usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  Widget _buildNavItem(IconData icon, String label, int index) {
    // Analise da Linha: final isSelected = _currentIndex == index;
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // isSelected = Identificador da Variavel. Rotulo usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // _currentIndex == index = Expressao de Valor. Resultado armazenado nesta variavel.
    // ; = Finalizador de Instrucao. Encerra a declaracao local.
    final isSelected = _currentIndex == index;
    // Analise da Linha: if (isSelected) {
    // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
    // (isSelected) = Expressao Condicional. Teste logico avaliado antes de executar o bloco.
    // { = Abertura de Bloco Condicional. Inicia as instrucoes do if.
    if (isSelected) {
      // Analise da Linha: return Container(
      // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
      // Container( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
      return Container(
        // Analise da Linha: padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // const EdgeInsets.symmetric(horizontal: 16, vertical: 8) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // Analise da Linha: decoration: BoxDecoration(
        // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        decoration: BoxDecoration(
          // Analise da Linha: color: const Color(0xFF512DA8),
          // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // const Color(0xFF512DA8) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          color: const Color(0xFF512DA8),
          // Analise da Linha: borderRadius: BorderRadius.circular(20),
          // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // BorderRadius.circular(20) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          borderRadius: BorderRadius.circular(20),
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
            // Analise da Linha: Icon(icon, color: Colors.white, size: 18),
            // Icon = Chamada de Construtor/Funcao. Cria um widget/objeto ou executa um metodo.
            // ( ) = Delimitadores de Argumentos. Contem os valores enviados na chamada.
            // , = Separador de Argumento. Mantem a lista externa em continuidade.
            Icon(icon, color: Colors.white, size: 18),

            // =============================================================================
            // SECAO: CONSTRUTOR: SizedBox
            // =============================================================================
            // Analise da Linha: const SizedBox(width: 8),
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
            const SizedBox(width: 8),
            // Analise da Linha: Text(
            // Text = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
            // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
            Text(
              // Analise da Linha: label,
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              label,
              // Analise da Linha: style: const TextStyle(
              // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // const TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              style: const TextStyle(
                // Analise da Linha: color: Colors.white,
                // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // Colors.white = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                color: Colors.white,
                // Analise da Linha: fontWeight: FontWeight.bold,
                // fontWeight = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // FontWeight.bold = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                fontWeight: FontWeight.bold,
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
        // ; = Finalizador de Instrucao. Encerra a expressao atual.
      );
      // Analise da Linha: } else {
      // } = Fechamento de Bloco. Encerra o if anterior.
      // else = Caminho Alternativo. Executa quando a condicao anterior nao foi atendida.
      // { = Abertura de Bloco Alternativo. Inicia as instrucoes do else.
    } else {
      // Analise da Linha: return Container(
      // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
      // Container( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
      return Container(
        // Analise da Linha: padding: const EdgeInsets.all(8),
        // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // const EdgeInsets.all(8) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        padding: const EdgeInsets.all(8),
        // Analise da Linha: color: Colors.transparent,
        // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // Colors.transparent = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        color: Colors.transparent,
        // Analise da Linha: child: Icon(icon, color: Colors.white),
        // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // Icon(icon, color: Colors.white) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        child: Icon(icon, color: Colors.white),
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

  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}
