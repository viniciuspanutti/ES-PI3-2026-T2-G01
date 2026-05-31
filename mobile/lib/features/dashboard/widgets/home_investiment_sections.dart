// GUILHERME PREVENTI CORREIA

// =============================================================================
// SECAO: IMPORTACOES
// =============================================================================
// Analise da Linha: import 'package:cloud_firestore/cloud_firestore.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:cloud_firestore/cloud_firestore.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:cloud_firestore/cloud_firestore.dart';
// Analise da Linha: import 'package:firebase_auth/firebase_auth.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:firebase_auth/firebase_auth.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:firebase_auth/firebase_auth.dart';
// Analise da Linha: import 'package:flutter/cupertino.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:flutter/cupertino.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:flutter/cupertino.dart';
// Analise da Linha: import 'package:flutter/material.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:flutter/material.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:flutter/material.dart';
// Analise da Linha: import 'package:mobile/features/startups/data/startup_service.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:mobile/features/startups/data/startup_service.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:mobile/features/startups/data/startup_service.dart';
// Analise da Linha: import 'package:mobile/features/startups/domain/startup.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:mobile/features/startups/domain/startup.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:mobile/features/startups/domain/startup.dart';

// =============================================================================
// SECAO: CLASSE: FirestoreInvestmentSections
// =============================================================================
// Analise da Linha: class FirestoreInvestmentSections extends StatelessWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// FirestoreInvestmentSections = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatelessWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class FirestoreInvestmentSections extends StatelessWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: FirestoreInvestmentSections
  // =============================================================================
  // Analise da Linha: const FirestoreInvestmentSections({
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // FirestoreInvestmentSections = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // ( = Delimitador de Parametros. Inicia a lista de argumentos recebidos pelo construtor.
  const FirestoreInvestmentSections({
    // Analise da Linha: super.key,
    // super.key = Encaminhamento de Chave. Repassa a Key para a classe pai do widget.
    // , = Separador de Argumento. Indica que outros parametros podem vir depois.
    super.key,
    // Analise da Linha: required this.userId,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.userId = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.userId,
    // Analise da Linha: required this.backgroundColor,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.backgroundColor = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.backgroundColor,
    // Analise da Linha: required this.statusColor,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.statusColor = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.statusColor,
    // Analise da Linha: required this.growthColor,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.growthColor = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.growthColor,
    // Analise da Linha: required this.onRetry,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.onRetry = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.onRetry,
    // Analise da Linha: required this.onViewAllTap,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.onViewAllTap = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.onViewAllTap,
    // Analise da Linha: required this.onStartupTap,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.onStartupTap = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.onStartupTap,
    // Analise da Linha: required this.onMoreTap,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.onMoreTap = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.onMoreTap,
  // Analise da Linha: });
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
  // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
  });

  // Analise da Linha: final String? userId;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String? = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // userId = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String? userId;
  // Analise da Linha: final Color backgroundColor;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // Color = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // backgroundColor = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final Color backgroundColor;
  // Analise da Linha: final Color statusColor;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // Color = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // statusColor = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final Color statusColor;
  // Analise da Linha: final Color growthColor;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // Color = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // growthColor = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final Color growthColor;
  // Analise da Linha: final VoidCallback onRetry;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // VoidCallback = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onRetry = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final VoidCallback onRetry;
  // Analise da Linha: final VoidCallback onViewAllTap;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // VoidCallback = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onViewAllTap = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final VoidCallback onViewAllTap;
  // Analise da Linha: final ValueChanged<StartupDetail> onStartupTap;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // ValueChanged<StartupDetail> = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onStartupTap = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final ValueChanged<StartupDetail> onStartupTap;
  // Analise da Linha: final VoidCallback onMoreTap;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // VoidCallback = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onMoreTap = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final VoidCallback onMoreTap;

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
    // Analise da Linha: if (userId == null) {
    // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
    // (userId == null) = Expressao Condicional. Teste logico avaliado antes do bloco.
    // { = Abertura de Bloco Condicional. Inicia as instrucoes do if.
    if (userId == null) {
      // Analise da Linha: return _buildSection(
      // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
      // _buildSection( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
      return _buildSection(
        // Analise da Linha: investments: const [],
        // investments = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // const [] = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        investments: const [],
        // Analise da Linha: message: 'Voc\u00ea ainda n\u00e3o possui investimentos em carteira. '
        // message = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // 'Voc\u00ea ainda n\u00e3o possui investimentos em carteira. ' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        message: 'Voc\u00ea ainda n\u00e3o possui investimentos em carteira. '
            // Analise da Linha: 'Explore o cat\u00e1logo!',
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
            'Explore o cat\u00e1logo!',
      // Analise da Linha: );
      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
      // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
      );
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
    }

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
        // (snapshot.connectionState == ConnectionState.waiting) = Expressao Condicional. Teste logico avaliado antes do bloco.
        // { = Abertura de Bloco Condicional. Inicia as instrucoes do if.
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Analise da Linha: return _buildSection(
          // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
          // _buildSection( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
          return _buildSection(
            // Analise da Linha: investments: const [],
            // investments = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // const [] = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            investments: const [],
            // Analise da Linha: message: 'Carregando investimentos...',
            // message = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // 'Carregando investimentos...' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            message: 'Carregando investimentos...',
          // Analise da Linha: );
          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
          // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
          );
        // Analise da Linha: }
        // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
        }

        // Analise da Linha: if (snapshot.hasError) {
        // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
        // (snapshot.hasError) = Expressao Condicional. Teste logico avaliado antes do bloco.
        // { = Abertura de Bloco Condicional. Inicia as instrucoes do if.
        if (snapshot.hasError) {
          // Analise da Linha: return Column(
          // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
          // Column( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
          return Column(
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
              // Analise da Linha: _buildSection(
              // _buildSection = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
              // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
              _buildSection(
                // Analise da Linha: investments: const [],
                // investments = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // const [] = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                investments: const [],
                // Analise da Linha: message: 'N\u00e3o foi poss\u00edvel carregar seus investimentos.',
                // message = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 'N\u00e3o foi poss\u00edvel carregar seus investimentos.' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                message: 'N\u00e3o foi poss\u00edvel carregar seus investimentos.',
              // Analise da Linha: ),
              // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
              // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
              ),

              // =============================================================================
              // SECAO: CONSTRUTOR: SizedBox
              // =============================================================================
              // Analise da Linha: const SizedBox(height: 10),
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              const SizedBox(height: 10),
              // Analise da Linha: Align(
              // Align = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
              // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
              Align(
                // Analise da Linha: alignment: Alignment.centerLeft,
                // alignment = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // Alignment.centerLeft = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                alignment: Alignment.centerLeft,
                // Analise da Linha: child: TextButton.icon(
                // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // TextButton.icon( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                child: TextButton.icon(
                  // Analise da Linha: onPressed: onRetry,
                  // onPressed = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // onRetry = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  onPressed: onRetry,
                  // Analise da Linha: icon: const Icon(Icons.refresh, size: 18),
                  // icon = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // const Icon(Icons.refresh, size: 18) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  icon: const Icon(Icons.refresh, size: 18),
                  // Analise da Linha: label: const Text('Tentar novamente'),
                  // label = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // const Text('Tentar novamente') = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  label: const Text('Tentar novamente'),
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
          // Analise da Linha: );
          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
          // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
          );
        // Analise da Linha: }
        // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
        }

        // Analise da Linha: if (FirebaseAuth.instance.currentUser == null) {
        // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
        // (FirebaseAuth.instance.currentUser == null) = Expressao Condicional. Teste logico avaliado antes do bloco.
        // { = Abertura de Bloco Condicional. Inicia as instrucoes do if.
        if (FirebaseAuth.instance.currentUser == null) {
          // Analise da Linha: return _buildSection(
          // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
          // _buildSection( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
          return _buildSection(
            // Analise da Linha: investments: const [],
            // investments = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // const [] = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            investments: const [],
            // Analise da Linha: message: 'Você ainda não possui investimentos em carteira. Explore o catálogo!',
            // message = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // 'Você ainda não possui investimentos em carteira. Explore o catálogo!' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            message: 'Você ainda não possui investimentos em carteira. Explore o catálogo!',
          // Analise da Linha: );
          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
          // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
          );
        // Analise da Linha: }
        // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
        }

        // Analise da Linha: final docs = snapshot.data?.docs ?? [];
        // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
        // docs = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
        // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
        // snapshot.data?.docs ?? [] = Expressao de Valor. Resultado armazenado nesta variavel.
        // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
        final docs = snapshot.data?.docs ?? [];
        // Analise da Linha: final investedIds = docs
        // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
        // investedIds = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
        // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
        // docs = Expressao de Valor. Resultado armazenado nesta variavel.
        final investedIds = docs
            // Analise da Linha: .where((doc) {
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            // { = Abertura de Bloco. Inicia um novo escopo.
            .where((doc) {
              // Analise da Linha: final data = doc.data() as Map<String, dynamic>;
              // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
              // data = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
              // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
              // doc.data() as Map<String, dynamic> = Expressao de Valor. Resultado armazenado nesta variavel.
              // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
              final data = doc.data() as Map<String, dynamic>;
              // Analise da Linha: return (data['tokensComprados'] ?? 0) > 0;
              // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
              // (data['tokensComprados'] ?? 0) > 0 = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
              // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
              return (data['tokensComprados'] ?? 0) > 0;
            // Analise da Linha: })
            // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
            // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
            })
            // Analise da Linha: .map((doc) => doc.id)
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            // => = Arrow Function. Retorna a expressao da direita de forma compacta.
            .map((doc) => doc.id)
            // Analise da Linha: .toList();
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
            .toList();

        // Analise da Linha: if (investedIds.isEmpty) {
        // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
        // (investedIds.isEmpty) = Expressao Condicional. Teste logico avaliado antes do bloco.
        // { = Abertura de Bloco Condicional. Inicia as instrucoes do if.
        if (investedIds.isEmpty) {
          // Analise da Linha: return _buildSection(
          // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
          // _buildSection( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
          return _buildSection(
            // Analise da Linha: investments: const [],
            // investments = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // const [] = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            investments: const [],
            // Analise da Linha: message: 'Voc\u00ea ainda n\u00e3o possui investimentos em carteira. '
            // message = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // 'Voc\u00ea ainda n\u00e3o possui investimentos em carteira. ' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            message: 'Voc\u00ea ainda n\u00e3o possui investimentos em carteira. '
                // Analise da Linha: 'Explore o cat\u00e1logo!',
                // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                'Explore o cat\u00e1logo!',
          // Analise da Linha: );
          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
          // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
          );
        // Analise da Linha: }
        // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
        }

        // Analise da Linha: return FutureBuilder<List<StartupDetail>>(
        // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
        // FutureBuilder<List<StartupDetail>>( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
        return FutureBuilder<List<StartupDetail>>(
          // Analise da Linha: future: _fetchInvestedStartups(investedIds),
          // future = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // _fetchInvestedStartups(investedIds) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          future: _fetchInvestedStartups(investedIds),
          // Analise da Linha: builder: (context, startupSnap) {
          // builder = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // (context, startupSnap) { = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          builder: (context, startupSnap) {
            // Analise da Linha: if (startupSnap.connectionState == ConnectionState.waiting) {
            // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
            // (startupSnap.connectionState == ConnectionState.waiting) = Expressao Condicional. Teste logico avaliado antes do bloco.
            // { = Abertura de Bloco Condicional. Inicia as instrucoes do if.
            if (startupSnap.connectionState == ConnectionState.waiting) {
              // Analise da Linha: return _buildSection(
              // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
              // _buildSection( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
              return _buildSection(
                // Analise da Linha: investments: const [],
                // investments = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // const [] = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                investments: const [],
                // Analise da Linha: message: 'Carregando detalhes dos investimentos...',
                // message = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 'Carregando detalhes dos investimentos...' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                message: 'Carregando detalhes dos investimentos...',
              // Analise da Linha: );
              // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
              // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
              );
            // Analise da Linha: }
            // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
            }

            // Analise da Linha: final startups = startupSnap.data ?? [];
            // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
            // startups = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
            // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
            // startupSnap.data ?? [] = Expressao de Valor. Resultado armazenado nesta variavel.
            // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
            final startups = startupSnap.data ?? [];
            // Analise da Linha: final investments = startups
            // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
            // investments = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
            // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
            // startups = Expressao de Valor. Resultado armazenado nesta variavel.
            final investments = startups
                // Analise da Linha: .take(3)
                // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                .take(3)
                // Analise da Linha: .map(_InvestmentItemData.fromStartup)
                // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                .map(_InvestmentItemData.fromStartup)
                // Analise da Linha: .toList(growable: false);
                // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
                .toList(growable: false);

            // Analise da Linha: return _buildSection(
            // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
            // _buildSection( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
            return _buildSection(
              // Analise da Linha: investments: investments,
              // investments = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // investments = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              investments: investments,
              // Analise da Linha: message: 'Nenhum investimento encontrado.',
              // message = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // 'Nenhum investimento encontrado.' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              message: 'Nenhum investimento encontrado.',
            // Analise da Linha: );
            // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
            // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
            );
          // Analise da Linha: },
          // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
          // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
          },
        // Analise da Linha: );
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
        );
      // Analise da Linha: },
      // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
      // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
      },
    // Analise da Linha: );
    // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
    // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
    );
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // =============================================================================
  // SECAO: FUNCAO/METODO: _buildSection
  // =============================================================================
  // Analise da Linha: Widget _buildSection({
  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
  // { = Abertura de Bloco. Inicia um novo escopo.
  Widget _buildSection({
    // Analise da Linha: required List<_InvestmentItemData> investments,
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
    required List<_InvestmentItemData> investments,
    // Analise da Linha: required String message,
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
    required String message,
  // Analise da Linha: }) {
  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
  // { = Abertura de Bloco. Inicia um novo escopo.
  // } = Fechamento de Bloco. Encerra um escopo aberto anteriormente.
  }) {
    // Analise da Linha: return _InvestmentSection(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // _InvestmentSection( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return _InvestmentSection(
      // Analise da Linha: title: 'Seus Investimentos',
      // title = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // 'Seus Investimentos' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      title: 'Seus Investimentos',
      // Analise da Linha: backgroundColor: backgroundColor,
      // backgroundColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // backgroundColor = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      backgroundColor: backgroundColor,
      // Analise da Linha: statusColor: statusColor,
      // statusColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // statusColor = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      statusColor: statusColor,
      // Analise da Linha: growthColor: growthColor,
      // growthColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // growthColor = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      growthColor: growthColor,
      // Analise da Linha: showMoreButton: true,
      // showMoreButton = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // true = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      showMoreButton: true,
      // Analise da Linha: showViewAll: investments.isNotEmpty,
      // showViewAll = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // investments.isNotEmpty = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      showViewAll: investments.isNotEmpty,
      // Analise da Linha: emptyMessage: message,
      // emptyMessage = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // message = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      emptyMessage: message,
      // Analise da Linha: onMoreTap: onMoreTap,
      // onMoreTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // onMoreTap = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      onMoreTap: onMoreTap,
      // Analise da Linha: onViewAllTap: onViewAllTap,
      // onViewAllTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // onViewAllTap = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      onViewAllTap: onViewAllTap,
      // Analise da Linha: onItemTap: (item) {
      // onItemTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // (item) { = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      onItemTap: (item) {
        // Analise da Linha: final startup = item.startup;
        // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
        // startup = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
        // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
        // item.startup = Expressao de Valor. Resultado armazenado nesta variavel.
        // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
        final startup = item.startup;
        // Analise da Linha: if (startup != null) onStartupTap(startup);
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
        if (startup != null) onStartupTap(startup);
      // Analise da Linha: },
      // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
      // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
      },
      // Analise da Linha: items: investments,
      // items = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // investments = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      items: investments,
    // Analise da Linha: );
    // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
    // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
    );
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// Analise da Linha: Future<List<StartupDetail>> _fetchInvestedStartups(
// Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
Future<List<StartupDetail>> _fetchInvestedStartups(
  // Analise da Linha: List<String> startupIds,
  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
  // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
  List<String> startupIds,
// Analise da Linha: ) async {
// Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
// { = Abertura de Bloco. Inicia um novo escopo.
) async {
  // Analise da Linha: final service = StartupService();
  // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
  // service = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
  // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
  // StartupService() = Expressao de Valor. Resultado armazenado nesta variavel.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
  final service = StartupService();
  // Analise da Linha: final List<StartupDetail> result = [];
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // List<StartupDetail> = Tipo Declarado. Define a categoria de dado aceita por esta variavel.
  // result = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // = = Operador de Atribuicao. Liga a variavel ao valor da direita.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final List<StartupDetail> result = [];
  // Analise da Linha: for (final id in startupIds) {
  // for = Estrutura de Repeticao. Percorre uma sequencia de valores ou indices.
  // (final id in startupIds) = Controle do Loop. Define como a repeticao percorre os dados.
  // { = Abertura de Bloco. Inicia as instrucoes repetidas.
  for (final id in startupIds) {
    // Analise da Linha: try {
    // try = Bloco de Tentativa. Executa codigo que pode gerar erro.
    // { = Abertura de Bloco Protegido. Inicia as instrucoes monitoradas pelo try.
    try {
      // Analise da Linha: result.add(await service.getStartupDetails(id));
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
      result.add(await service.getStartupDetails(id));
    // Analise da Linha: } catch (_) {
    // } = Fechamento de Bloco. Encerra o bloco try anterior.
    // catch = Captura de Erro. Executa quando o try gera uma excecao.
    // (_) = Parametro da Excecao. Recebe ou ignora o erro capturado.
    // { = Abertura de Bloco. Inicia o tratamento do erro.
    } catch (_) {
      // Startup n\u00e3o encontrada no cat\u00e1logo, ignora
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
    }
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }
  // Analise da Linha: return result;
  // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
  // result = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
  // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
  return result;
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}



// =============================================================================
// SECAO: CLASSE: _SectionTapTarget
// =============================================================================
// Analise da Linha: class _SectionTapTarget extends StatelessWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// _SectionTapTarget = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatelessWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class _SectionTapTarget extends StatelessWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: _SectionTapTarget
  // =============================================================================
  // Analise da Linha: const _SectionTapTarget({required this.onTap, required this.child});
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // _SectionTapTarget = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // { } = Delimitadores de Parametros Nomeados. Agrupam argumentos opcionais ou obrigatorios por nome.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao do construtor.
  const _SectionTapTarget({required this.onTap, required this.child});

  // Analise da Linha: final VoidCallback onTap;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // VoidCallback = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onTap = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final VoidCallback onTap;
  // Analise da Linha: final Widget child;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // Widget = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // child = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final Widget child;

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
    // Analise da Linha: return Material(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // Material( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return Material(
      // Analise da Linha: color: Colors.transparent,
      // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // Colors.transparent = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      color: Colors.transparent,
      // Analise da Linha: child: InkResponse(
      // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // InkResponse( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      child: InkResponse(
        // Analise da Linha: onTap: onTap,
        // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // onTap = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        onTap: onTap,
        // Analise da Linha: radius: 22,
        // radius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // 22 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        radius: 22,
        // Analise da Linha: child: SizedBox(width: 34, height: 34, child: Center(child: child)),
        // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // SizedBox(width: 34, height: 34, child: Center(child: child)) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        child: SizedBox(width: 34, height: 34, child: Center(child: child)),
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
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: CLASSE: _InvestmentSection
// =============================================================================
// Analise da Linha: class _InvestmentSection extends StatelessWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// _InvestmentSection = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatelessWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class _InvestmentSection extends StatelessWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: _InvestmentSection
  // =============================================================================
  // Analise da Linha: const _InvestmentSection({
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // _InvestmentSection = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // ( = Delimitador de Parametros. Inicia a lista de argumentos recebidos pelo construtor.
  const _InvestmentSection({
    // Analise da Linha: required this.title,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.title = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.title,
    // Analise da Linha: required this.items,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.items = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.items,
    // Analise da Linha: required this.backgroundColor,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.backgroundColor = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.backgroundColor,
    // Analise da Linha: required this.statusColor,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.statusColor = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.statusColor,
    // Analise da Linha: required this.growthColor,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.growthColor = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.growthColor,
    // Analise da Linha: this.showMoreButton = false,
    // this.showMoreButton = Parametro Opcional de Campo. Permite preencher esta propriedade ao construir o objeto.
    // = = Valor Padrao. Define o valor usado quando o argumento nao for informado.
    // , = Separador de Parametro. Continua a lista de parametros.
    this.showMoreButton = false,
    // Analise da Linha: this.showViewAll = false,
    // this.showViewAll = Parametro Opcional de Campo. Permite preencher esta propriedade ao construir o objeto.
    // = = Valor Padrao. Define o valor usado quando o argumento nao for informado.
    // , = Separador de Parametro. Continua a lista de parametros.
    this.showViewAll = false,
    // Analise da Linha: this.emptyMessage = 'Nenhuma empresa encontrada.',
    // this.emptyMessage = Parametro Opcional de Campo. Permite preencher esta propriedade ao construir o objeto.
    // = = Valor Padrao. Define o valor usado quando o argumento nao for informado.
    // , = Separador de Parametro. Continua a lista de parametros.
    this.emptyMessage = 'Nenhuma empresa encontrada.',
    // Analise da Linha: this.onMoreTap,
    // this.onMoreTap = Parametro Opcional de Campo. Permite preencher esta propriedade ao construir o objeto.
    // , = Separador de Parametro. Continua a lista de parametros.
    this.onMoreTap,
    // Analise da Linha: this.onViewAllTap,
    // this.onViewAllTap = Parametro Opcional de Campo. Permite preencher esta propriedade ao construir o objeto.
    // , = Separador de Parametro. Continua a lista de parametros.
    this.onViewAllTap,
    // Analise da Linha: this.onItemTap,
    // this.onItemTap = Parametro Opcional de Campo. Permite preencher esta propriedade ao construir o objeto.
    // , = Separador de Parametro. Continua a lista de parametros.
    this.onItemTap,
  // Analise da Linha: });
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
  // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
  });

  // Analise da Linha: final String title;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // title = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String title;
  // Analise da Linha: final List<_InvestmentItemData> items;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // List<_InvestmentItemData> = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // items = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final List<_InvestmentItemData> items;
  // Analise da Linha: final Color backgroundColor;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // Color = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // backgroundColor = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final Color backgroundColor;
  // Analise da Linha: final Color statusColor;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // Color = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // statusColor = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final Color statusColor;
  // Analise da Linha: final Color growthColor;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // Color = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // growthColor = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final Color growthColor;
  // Analise da Linha: final bool showMoreButton;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // bool = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // showMoreButton = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final bool showMoreButton;
  // Analise da Linha: final bool showViewAll;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // bool = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // showViewAll = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final bool showViewAll;
  // Analise da Linha: final String emptyMessage;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // emptyMessage = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String emptyMessage;
  // Analise da Linha: final VoidCallback? onMoreTap;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // VoidCallback? = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onMoreTap = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final VoidCallback? onMoreTap;
  // Analise da Linha: final VoidCallback? onViewAllTap;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // VoidCallback? = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onViewAllTap = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final VoidCallback? onViewAllTap;
  // Analise da Linha: final ValueChanged<_InvestmentItemData>? onItemTap;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // ValueChanged<_InvestmentItemData>? = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onItemTap = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final ValueChanged<_InvestmentItemData>? onItemTap;

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
    // Analise da Linha: return Container(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // Container( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return Container(
      // Analise da Linha: padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // const EdgeInsets.fromLTRB(14, 14, 14, 16) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      // Analise da Linha: decoration: BoxDecoration(
      // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      decoration: BoxDecoration(
        // Analise da Linha: color: backgroundColor,
        // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // backgroundColor = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        color: backgroundColor,
        // Analise da Linha: borderRadius: BorderRadius.circular(18),
        // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // BorderRadius.circular(18) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        borderRadius: BorderRadius.circular(18),
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
            // Analise da Linha: blurRadius: 14,
            // blurRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // 14 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            blurRadius: 14,
            // Analise da Linha: offset: const Offset(0, 6),
            // offset = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // const Offset(0, 6) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            offset: const Offset(0, 6),
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
          // Analise da Linha: Row(
          // Row = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
          // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
          Row(
            // Analise da Linha: children: [
            // children = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            children: [
              // Analise da Linha: Expanded(
              // Expanded = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
              // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
              Expanded(
                // Analise da Linha: child: Text(
                // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // Text( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                child: Text(
                  // Analise da Linha: title,
                  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                  // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                  title,
                  // Analise da Linha: style: const TextStyle(
                  // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // const TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  style: const TextStyle(
                    // Analise da Linha: color: Color(0xFF191919),
                    // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // Color(0xFF191919) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    color: Color(0xFF191919),
                    // Analise da Linha: fontFamily: 'Georgia',
                    // fontFamily = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // 'Georgia' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    fontFamily: 'Georgia',
                    // Analise da Linha: fontSize: 16,
                    // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // 16 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    fontSize: 16,
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
              // Analise da Linha: if (showMoreButton)
              // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
              // (showMoreButton) = Expressao Condicional. Teste logico avaliado antes do bloco.
              if (showMoreButton)
                // Analise da Linha: _SectionTapTarget(
                // _SectionTapTarget = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
                // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
                _SectionTapTarget(
                  // Analise da Linha: onTap: onMoreTap ?? () {},
                  // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // onMoreTap ?? () {} = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  onTap: onMoreTap ?? () {},
                  // Analise da Linha: child: const Icon(
                  // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // const Icon( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  child: const Icon(
                    // Analise da Linha: CupertinoIcons.ellipsis,
                    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                    // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                    CupertinoIcons.ellipsis,
                    // Analise da Linha: size: 18,
                    // size = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // 18 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    size: 18,
                    // Analise da Linha: color: Color(0xFF1D1D1F),
                    // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // Color(0xFF1D1D1F) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    color: Color(0xFF1D1D1F),
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

          // =============================================================================
          // SECAO: CONSTRUTOR: SizedBox
          // =============================================================================
          // Analise da Linha: const SizedBox(height: 12),
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
          const SizedBox(height: 12),
          // Analise da Linha: if (items.isEmpty)
          // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
          // (items.isEmpty) = Expressao Condicional. Teste logico avaliado antes do bloco.
          if (items.isEmpty)
            // Analise da Linha: _SectionEmptyState(message: emptyMessage)
            // _SectionEmptyState = Chamada de Construtor/Funcao. Cria um widget/objeto ou executa um metodo.
            // ( ) = Delimitadores de Argumentos. Contem os valores enviados na chamada.
            _SectionEmptyState(message: emptyMessage)
          // Analise da Linha: else
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          else
            // Analise da Linha: for (var index = 0; index < items.length; index++) ...[
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            for (var index = 0; index < items.length; index++) ...[
              // Analise da Linha: _InvestmentListTile(
              // _InvestmentListTile = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
              // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
              _InvestmentListTile(
                // Analise da Linha: item: items[index],
                // item = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // items[index] = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                item: items[index],
                // Analise da Linha: statusColor: statusColor,
                // statusColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // statusColor = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                statusColor: statusColor,
                // Analise da Linha: growthColor: growthColor,
                // growthColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // growthColor = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                growthColor: growthColor,
                // Analise da Linha: onTap: onItemTap == null
                // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // onItemTap == null = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                onTap: onItemTap == null
                    // Analise da Linha: ? null
                    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                    ? null
                    // Analise da Linha: : () => onItemTap!(items[index]),
                    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                    // => = Arrow Function. Retorna a expressao da direita de forma compacta.
                    // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                    : () => onItemTap!(items[index]),
              // Analise da Linha: ),
              // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
              // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
              ),
              // Analise da Linha: if (index != items.length - 1)
              // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
              // (index != items.length - 1) = Expressao Condicional. Teste logico avaliado antes do bloco.
              if (index != items.length - 1)

                // =============================================================================
                // SECAO: CONSTRUTOR: Divider
                // =============================================================================
                // Analise da Linha: const Divider(
                // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
                // Divider = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
                // ( = Delimitador de Parametros. Inicia a lista de argumentos recebidos pelo construtor.
                const Divider(
                  // Analise da Linha: height: 18,
                  // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // 18 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  height: 18,
                  // Analise da Linha: thickness: 0.7,
                  // thickness = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // 0.7 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  thickness: 0.7,
                  // Analise da Linha: color: Color(0xFFD3D4D8),
                  // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // Color(0xFFD3D4D8) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  color: Color(0xFFD3D4D8),
                // Analise da Linha: ),
                // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                ),
            // Analise da Linha: ],
            // ] = Fechamento de Lista. Encerra uma colecao ou lista de widgets.
            // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
            ],
          // Analise da Linha: if (showViewAll) ...[
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          if (showViewAll) ...[

            // =============================================================================
            // SECAO: CONSTRUTOR: SizedBox
            // =============================================================================
            // Analise da Linha: const SizedBox(height: 14),
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
            const SizedBox(height: 14),
            // Analise da Linha: InkWell(
            // InkWell = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
            // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
            InkWell(
              // Analise da Linha: onTap: onViewAllTap,
              // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // onViewAllTap = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              onTap: onViewAllTap,
              // Analise da Linha: borderRadius: BorderRadius.circular(8),
              // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // BorderRadius.circular(8) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              borderRadius: BorderRadius.circular(8),
              // Analise da Linha: child: const Padding(
              // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // const Padding( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              child: const Padding(
                // Analise da Linha: padding: EdgeInsets.symmetric(vertical: 4),
                // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // EdgeInsets.symmetric(vertical: 4) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                padding: EdgeInsets.symmetric(vertical: 4),
                // Analise da Linha: child: Text(
                // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // Text( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                child: Text(
                  // Analise da Linha: 'Ver Todos',
                  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                  // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                  'Ver Todos',
                  // Analise da Linha: style: TextStyle(
                  // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  style: TextStyle(
                    // Analise da Linha: color: Color(0xFF4169FF),
                    // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // Color(0xFF4169FF) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    color: Color(0xFF4169FF),
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
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: CLASSE: _SectionEmptyState
// =============================================================================
// Analise da Linha: class _SectionEmptyState extends StatelessWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// _SectionEmptyState = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatelessWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class _SectionEmptyState extends StatelessWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: _SectionEmptyState
  // =============================================================================
  // Analise da Linha: const _SectionEmptyState({required this.message});
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // _SectionEmptyState = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // { } = Delimitadores de Parametros Nomeados. Agrupam argumentos opcionais ou obrigatorios por nome.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao do construtor.
  const _SectionEmptyState({required this.message});

  // Analise da Linha: final String message;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // message = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String message;

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
    // Analise da Linha: return Padding(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // Padding( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return Padding(
      // Analise da Linha: padding: const EdgeInsets.symmetric(vertical: 16),
      // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // const EdgeInsets.symmetric(vertical: 16) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      padding: const EdgeInsets.symmetric(vertical: 16),
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
            // Analise da Linha: width: 36,
            // width = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // 36 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            width: 36,
            // Analise da Linha: height: 36,
            // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // 36 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            height: 36,
            // Analise da Linha: decoration: const BoxDecoration(
            // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // const BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            decoration: const BoxDecoration(
              // Analise da Linha: color: Color(0xFFEDEDF1),
              // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // Color(0xFFEDEDF1) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              color: Color(0xFFEDEDF1),
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
              // Analise da Linha: CupertinoIcons.building_2_fill,
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              CupertinoIcons.building_2_fill,
              // Analise da Linha: color: Color(0xFF777777),
              // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // Color(0xFF777777) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              color: Color(0xFF777777),
              // Analise da Linha: size: 18,
              // size = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // 18 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              size: 18,
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
          // Analise da Linha: const SizedBox(width: 12),
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
          const SizedBox(width: 12),
          // Analise da Linha: Expanded(
          // Expanded = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
          // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
          Expanded(
            // Analise da Linha: child: Text(
            // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // Text( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            child: Text(
              // Analise da Linha: message,
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              message,
              // Analise da Linha: style: const TextStyle(
              // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // const TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              style: const TextStyle(
                // Analise da Linha: color: Color(0xFF6F6F76),
                // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // Color(0xFF6F6F76) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                color: Color(0xFF6F6F76),
                // Analise da Linha: fontSize: 13,
                // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 13 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                fontSize: 13,
                // Analise da Linha: height: 1.3,
                // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 1.3 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                height: 1.3,
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
    // Analise da Linha: );
    // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
    // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
    );
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: CLASSE: _InvestmentListTile
// =============================================================================
// Analise da Linha: class _InvestmentListTile extends StatelessWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// _InvestmentListTile = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatelessWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class _InvestmentListTile extends StatelessWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: _InvestmentListTile
  // =============================================================================
  // Analise da Linha: const _InvestmentListTile({
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // _InvestmentListTile = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // ( = Delimitador de Parametros. Inicia a lista de argumentos recebidos pelo construtor.
  const _InvestmentListTile({
    // Analise da Linha: required this.item,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.item = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.item,
    // Analise da Linha: required this.statusColor,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.statusColor = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.statusColor,
    // Analise da Linha: required this.growthColor,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.growthColor = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.growthColor,
    // Analise da Linha: this.onTap,
    // this.onTap = Parametro Opcional de Campo. Permite preencher esta propriedade ao construir o objeto.
    // , = Separador de Parametro. Continua a lista de parametros.
    this.onTap,
  // Analise da Linha: });
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
  // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
  });

  // Analise da Linha: final _InvestmentItemData item;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // _InvestmentItemData = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // item = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final _InvestmentItemData item;
  // Analise da Linha: final Color statusColor;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // Color = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // statusColor = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final Color statusColor;
  // Analise da Linha: final Color growthColor;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // Color = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // growthColor = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final Color growthColor;
  // Analise da Linha: final VoidCallback? onTap;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // VoidCallback? = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onTap = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final VoidCallback? onTap;

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
    // Analise da Linha: return Material(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // Material( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return Material(
      // Analise da Linha: color: Colors.transparent,
      // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // Colors.transparent = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      color: Colors.transparent,
      // Analise da Linha: child: InkWell(
      // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // InkWell( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      child: InkWell(
        // Analise da Linha: onTap: onTap,
        // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // onTap = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        onTap: onTap,
        // Analise da Linha: borderRadius: BorderRadius.circular(12),
        // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // BorderRadius.circular(12) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        borderRadius: BorderRadius.circular(12),
        // Analise da Linha: child: Padding(
        // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // Padding( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        child: Padding(
          // Analise da Linha: padding: const EdgeInsets.symmetric(vertical: 2),
          // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // const EdgeInsets.symmetric(vertical: 2) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          padding: const EdgeInsets.symmetric(vertical: 2),
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
              // Analise da Linha: SizedBox(
              // SizedBox = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
              // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
              SizedBox(
                // Analise da Linha: width: 38,
                // width = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 38 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                width: 38,
                // Analise da Linha: child: _CompanyLogo(
                // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // _CompanyLogo( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                child: _CompanyLogo(
                  // Analise da Linha: imageUrl: item.imageUrl,
                  // imageUrl = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // item.imageUrl = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  imageUrl: item.imageUrl,
                  // Analise da Linha: fallbackLabel: item.company,
                  // fallbackLabel = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // item.company = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  fallbackLabel: item.company,
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
              // Analise da Linha: const SizedBox(width: 10),
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              const SizedBox(width: 10),
              // Analise da Linha: Expanded(
              // Expanded = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
              // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
              Expanded(
                // Analise da Linha: flex: 3,
                // flex = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 3 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                flex: 3,
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
                    // Analise da Linha: Text(
                    // Text = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
                    // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
                    Text(
                      // Analise da Linha: item.company,
                      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                      // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                      item.company,
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
                        // Analise da Linha: color: Color(0xFF191919),
                        // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                        // Color(0xFF191919) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                        // , = Separador de Argumento. Permite informar outro argumento depois.
                        color: Color(0xFF191919),
                        // Analise da Linha: fontSize: 16,
                        // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                        // 16 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                        // , = Separador de Argumento. Permite informar outro argumento depois.
                        fontSize: 16,
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
                    // Analise da Linha: const SizedBox(height: 2),
                    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                    // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                    const SizedBox(height: 2),
                    // Analise da Linha: if (item.variation.isNotEmpty)
                    // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
                    // (item.variation.isNotEmpty) = Expressao Condicional. Teste logico avaliado antes do bloco.
                    if (item.variation.isNotEmpty)
                      // Analise da Linha: Row(
                      // Row = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
                      // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
                      Row(
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
                          // Analise da Linha: Text(
                          // Text = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
                          // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
                          Text(
                            // Analise da Linha: item.variation,
                            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                            // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                            item.variation,
                            // Analise da Linha: style: TextStyle(
                            // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                            // TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                            style: TextStyle(
                              // Analise da Linha: color: growthColor,
                              // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                              // growthColor = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                              // , = Separador de Argumento. Permite informar outro argumento depois.
                              color: growthColor,
                              // Analise da Linha: fontSize: 13,
                              // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                              // 13 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                              // , = Separador de Argumento. Permite informar outro argumento depois.
                              fontSize: 13,
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
                          // Analise da Linha: const SizedBox(width: 2),
                          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                          // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                          const SizedBox(width: 2),
                          // Analise da Linha: Icon(
                          // Icon = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
                          // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
                          Icon(
                            // Analise da Linha: Icons.arrow_drop_up,
                            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                            // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                            Icons.arrow_drop_up,
                            // Analise da Linha: color: growthColor,
                            // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                            // growthColor = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                            // , = Separador de Argumento. Permite informar outro argumento depois.
                            color: growthColor,
                            // Analise da Linha: size: 14,
                            // size = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                            // 14 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                            // , = Separador de Argumento. Permite informar outro argumento depois.
                            size: 14,
                          // Analise da Linha: ),
                          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                          // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                          ),
                        // Analise da Linha: ],
                        // ] = Fechamento de Lista. Encerra uma colecao ou lista de widgets.
                        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
                        ],
                      // Analise da Linha: )
                      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
                      )
                    // Analise da Linha: else if (item.subtitle.isNotEmpty)
                    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                    else if (item.subtitle.isNotEmpty)
                      // Analise da Linha: Text(
                      // Text = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
                      // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
                      Text(
                        // Analise da Linha: item.subtitle,
                        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                        // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                        item.subtitle,
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
                          // Analise da Linha: color: Color(0xFF6F6F76),
                          // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // Color(0xFF6F6F76) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          // , = Separador de Argumento. Permite informar outro argumento depois.
                          color: Color(0xFF6F6F76),
                          // Analise da Linha: fontSize: 12,
                          // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                          // 12 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                          // , = Separador de Argumento. Permite informar outro argumento depois.
                          fontSize: 12,
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
              // Analise da Linha: Expanded(
              // Expanded = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
              // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
              Expanded(
                // Analise da Linha: flex: 2,
                // flex = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 2 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                flex: 2,
                // Analise da Linha: child: Text(
                // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // Text( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                child: Text(
                  // Analise da Linha: item.status,
                  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                  // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                  item.status,
                  // Analise da Linha: textAlign: TextAlign.center,
                  // textAlign = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // TextAlign.center = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  textAlign: TextAlign.center,
                  // Analise da Linha: overflow: TextOverflow.ellipsis,
                  // overflow = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // TextOverflow.ellipsis = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  overflow: TextOverflow.ellipsis,
                  // Analise da Linha: style: TextStyle(
                  // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  style: TextStyle(
                    // Analise da Linha: color: statusColor,
                    // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // statusColor = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    color: statusColor,
                    // Analise da Linha: fontSize: 13,
                    // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // 13 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    fontSize: 13,
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
              // Analise da Linha: const SizedBox(width: 8),
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              const SizedBox(width: 8),
              // Analise da Linha: Row(
              // Row = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
              // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
              Row(
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
                  // Analise da Linha: Text(
                  // Text = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
                  // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
                  Text(
                    // Analise da Linha: item.value,
                    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                    // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                    item.value,
                    // Analise da Linha: style: const TextStyle(
                    // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // const TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    style: const TextStyle(
                      // Analise da Linha: color: Color(0xFF1D1D1F),
                      // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                      // Color(0xFF1D1D1F) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                      // , = Separador de Argumento. Permite informar outro argumento depois.
                      color: Color(0xFF1D1D1F),
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
                  // Analise da Linha: const SizedBox(width: 8),
                  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                  // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                  const SizedBox(width: 8),

                  // =============================================================================
                  // SECAO: CONSTRUTOR: Icon
                  // =============================================================================
                  // Analise da Linha: const Icon(
                  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
                  // Icon = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
                  // ( = Delimitador de Parametros. Inicia a lista de argumentos recebidos pelo construtor.
                  const Icon(
                    // Analise da Linha: CupertinoIcons.chevron_forward,
                    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                    // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                    CupertinoIcons.chevron_forward,
                    // Analise da Linha: size: 12,
                    // size = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // 12 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    size: 12,
                    // Analise da Linha: color: Color(0xFF1D1D1F),
                    // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // Color(0xFF1D1D1F) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    color: Color(0xFF1D1D1F),
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
    // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
    );
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: CLASSE: _CompanyLogo
// =============================================================================
// Analise da Linha: class _CompanyLogo extends StatelessWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// _CompanyLogo = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatelessWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class _CompanyLogo extends StatelessWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: _CompanyLogo
  // =============================================================================
  // Analise da Linha: const _CompanyLogo({required this.imageUrl, required this.fallbackLabel});
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // _CompanyLogo = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // { } = Delimitadores de Parametros Nomeados. Agrupam argumentos opcionais ou obrigatorios por nome.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao do construtor.
  const _CompanyLogo({required this.imageUrl, required this.fallbackLabel});

  // Analise da Linha: final String? imageUrl;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String? = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // imageUrl = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String? imageUrl;
  // Analise da Linha: final String fallbackLabel;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // fallbackLabel = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String fallbackLabel;

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
    // Analise da Linha: final logo = imageUrl;
    // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
    // logo = = Tipo Declarado. Define a categoria de dado aceita por este campo.
    // imageUrl = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
    final logo = imageUrl;

    // Analise da Linha: if (logo != null && logo.isNotEmpty) {
    // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
    // (logo != null && logo.isNotEmpty) = Expressao Condicional. Teste logico avaliado antes do bloco.
    // { = Abertura de Bloco Condicional. Inicia as instrucoes do if.
    if (logo != null && logo.isNotEmpty) {
      // Analise da Linha: final image = logo.startsWith('http')
      // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
      // image = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
      // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
      // logo.startsWith('http') = Expressao de Valor. Resultado armazenado nesta variavel.
      final image = logo.startsWith('http')
          // Analise da Linha: ? Image.network(
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          ? Image.network(
              // Analise da Linha: logo,
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              logo,
              // Analise da Linha: fit: BoxFit.contain,
              // fit = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // BoxFit.contain = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              fit: BoxFit.contain,
              // Analise da Linha: errorBuilder: (_, _, _) => _LogoFallback(label: fallbackLabel),
              // errorBuilder = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // (_, _, _) => _LogoFallback(label: fallbackLabel) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              errorBuilder: (_, _, _) => _LogoFallback(label: fallbackLabel),
            // Analise da Linha: )
            // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
            )
          // Analise da Linha: : Image.asset(
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          : Image.asset(
              // Analise da Linha: logo,
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              logo,
              // Analise da Linha: fit: BoxFit.contain,
              // fit = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // BoxFit.contain = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              fit: BoxFit.contain,
              // Analise da Linha: errorBuilder: (_, _, _) => _LogoFallback(label: fallbackLabel),
              // errorBuilder = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // (_, _, _) => _LogoFallback(label: fallbackLabel) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              errorBuilder: (_, _, _) => _LogoFallback(label: fallbackLabel),
            // Analise da Linha: );
            // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
            // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
            );

      // Analise da Linha: return ClipRRect(
      // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
      // ClipRRect( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
      return ClipRRect(
        // Analise da Linha: borderRadius: BorderRadius.circular(8),
        // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // BorderRadius.circular(8) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        borderRadius: BorderRadius.circular(8),
        // Analise da Linha: child: SizedBox(width: 32, height: 32, child: image),
        // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // SizedBox(width: 32, height: 32, child: image) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        child: SizedBox(width: 32, height: 32, child: image),
      // Analise da Linha: );
      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
      // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
      );
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
    }

    // Analise da Linha: return _LogoFallback(label: fallbackLabel);
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // _LogoFallback(label: fallbackLabel) = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
    return _LogoFallback(label: fallbackLabel);
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: CLASSE: _LogoFallback
// =============================================================================
// Analise da Linha: class _LogoFallback extends StatelessWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// _LogoFallback = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatelessWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class _LogoFallback extends StatelessWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: _LogoFallback
  // =============================================================================
  // Analise da Linha: const _LogoFallback({required this.label});
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // _LogoFallback = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // { } = Delimitadores de Parametros Nomeados. Agrupam argumentos opcionais ou obrigatorios por nome.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao do construtor.
  const _LogoFallback({required this.label});

  // Analise da Linha: final String label;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // label = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String label;

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
    // Analise da Linha: final initials = label
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // initials = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // label = Expressao de Valor. Resultado armazenado nesta variavel.
    final initials = label
        // Analise da Linha: .trim()
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        .trim()
        // Analise da Linha: .split(RegExp(r'\s+'))
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        .split(RegExp(r'\s+'))
        // Analise da Linha: .where((part) => part.isNotEmpty)
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        // => = Arrow Function. Retorna a expressao da direita de forma compacta.
        .where((part) => part.isNotEmpty)
        // Analise da Linha: .take(2)
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        .take(2)
        // Analise da Linha: .map((part) => part[0].toUpperCase())
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        // => = Arrow Function. Retorna a expressao da direita de forma compacta.
        .map((part) => part[0].toUpperCase())
        // Analise da Linha: .join();
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
        .join();

    // Analise da Linha: return Container(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // Container( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return Container(
      // Analise da Linha: width: 32,
      // width = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // 32 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      width: 32,
      // Analise da Linha: height: 32,
      // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // 32 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      height: 32,
      // Analise da Linha: decoration: BoxDecoration(
      // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      decoration: BoxDecoration(
        // Analise da Linha: color: const Color(0xFFEDEDF1),
        // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // const Color(0xFFEDEDF1) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        color: const Color(0xFFEDEDF1),
        // Analise da Linha: borderRadius: BorderRadius.circular(8),
        // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // BorderRadius.circular(8) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        borderRadius: BorderRadius.circular(8),
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
      // Analise da Linha: child: Text(
      // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // Text( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      child: Text(
        // Analise da Linha: initials.isEmpty ? '?' : initials,
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
        initials.isEmpty ? '?' : initials,
        // Analise da Linha: style: const TextStyle(
        // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // const TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        style: const TextStyle(
          // Analise da Linha: color: Color(0xFF1D1D1F),
          // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // Color(0xFF1D1D1F) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          color: Color(0xFF1D1D1F),
          // Analise da Linha: fontSize: 13,
          // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // 13 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          fontSize: 13,
          // Analise da Linha: fontWeight: FontWeight.w700,
          // fontWeight = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // FontWeight.w700 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          fontWeight: FontWeight.w700,
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
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}



// =============================================================================
// SECAO: FUNCAO/METODO: _formatCurrencyCents
// =============================================================================
// Analise da Linha: String _formatCurrencyCents(int cents) {
// String = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
// _formatCurrencyCents = Identificador da Funcao/Metodo. Nome tecnico usado para chamar este bloco de comportamento.
// ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
// { = Abertura de Bloco. Inicia o corpo executavel.
String _formatCurrencyCents(int cents) {
  // Analise da Linha: final value = (cents / 100).toStringAsFixed(2).replaceAll('.', ',');
  // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
  // value = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
  // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
  // (cents / 100).toStringAsFixed(2).replaceAll('.', ',') = Expressao de Valor. Resultado armazenado nesta variavel.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
  final value = (cents / 100).toStringAsFixed(2).replaceAll('.', ',');
  // Analise da Linha: return 'R\$$value';
  // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
  // 'R\$$value' = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
  // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
  return 'R\$$value';
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: FUNCAO/METODO: _formatPercent
// =============================================================================
// Analise da Linha: String _formatPercent(double value) {
// String = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
// _formatPercent = Identificador da Funcao/Metodo. Nome tecnico usado para chamar este bloco de comportamento.
// ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
// { = Abertura de Bloco. Inicia o corpo executavel.
String _formatPercent(double value) {
  // Analise da Linha: return '${value.toStringAsFixed(2).replaceAll('.', ',')}%';
  // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
  // '${value.toStringAsFixed(2).replaceAll('.', ',')}%' = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
  // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
  return '${value.toStringAsFixed(2).replaceAll('.', ',')}%';
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: FUNCAO/METODO: _stageLabel
// =============================================================================
// Analise da Linha: String _stageLabel(String stage) {
// String = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
// _stageLabel = Identificador da Funcao/Metodo. Nome tecnico usado para chamar este bloco de comportamento.
// ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
// { = Abertura de Bloco. Inicia o corpo executavel.
String _stageLabel(String stage) {
  // Analise da Linha: if (stage.trim().isEmpty) return 'Sem status';
  // if = Estrutura Condicional em Linha. Testa uma condicao antes de retornar imediatamente.
  // (stage.trim().isEmpty) = Expressao Condicional. Define quando o retorno antecipado acontece.
  // return = Instrucao de Retorno. Sai da funcao ou metodo com o valor informado.
  // ; = Finalizador de Instrucao. Operador que indica o fim do retorno em linha.
  if (stage.trim().isEmpty) return 'Sem status';
  // Analise da Linha: return stage;
  // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
  // stage = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
  // ; = Finalizador de Instrucao. Operador que indica o fim do retorno.
  return stage;
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: CLASSE: _InvestmentItemData
// =============================================================================
// Analise da Linha: class _InvestmentItemData {
// Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
// { = Abertura de Bloco. Inicia um novo escopo.
class _InvestmentItemData {

  // =============================================================================
  // SECAO: CONSTRUTOR: _InvestmentItemData
  // =============================================================================
  // Analise da Linha: const _InvestmentItemData({
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // _InvestmentItemData = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // ( = Delimitador de Parametros. Inicia a lista de argumentos recebidos pelo construtor.
  const _InvestmentItemData({
    // Analise da Linha: required this.company,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.company = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.company,
    // Analise da Linha: required this.subtitle,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.subtitle = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.subtitle,
    // Analise da Linha: required this.variation,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.variation = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.variation,
    // Analise da Linha: required this.status,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.status = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.status,
    // Analise da Linha: required this.value,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.value = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.value,
    // Analise da Linha: this.imageUrl,
    // this.imageUrl = Parametro Opcional de Campo. Permite preencher esta propriedade ao construir o objeto.
    // , = Separador de Parametro. Continua a lista de parametros.
    this.imageUrl,
    // Analise da Linha: this.startup,
    // this.startup = Parametro Opcional de Campo. Permite preencher esta propriedade ao construir o objeto.
    // , = Separador de Parametro. Continua a lista de parametros.
    this.startup,
  // Analise da Linha: });
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
  // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
  });

  // =============================================================================
  // SECAO: FACTORY: _InvestmentItemData.fromStartup
  // =============================================================================
  // Analise da Linha: factory _InvestmentItemData.fromStartup(StartupDetail startup) {
  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
  // { = Abertura de Bloco. Inicia um novo escopo.
  factory _InvestmentItemData.fromStartup(StartupDetail startup) {
    // Analise da Linha: final valueCents =
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // valueCents = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // expressao seguinte = Valor Continuado. A expressao atribuida continua nas proximas linhas.
    final valueCents =
        // Analise da Linha: startup.investmentValueCents ?? startup.currentTokenPriceCents;
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        // ?? = Operador de Coalescencia Nula. Usa o valor da direita se o da esquerda for null.
        // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
        startup.investmentValueCents ?? startup.currentTokenPriceCents;

    // Analise da Linha: return _InvestmentItemData(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // _InvestmentItemData( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return _InvestmentItemData(
      // Analise da Linha: company: startup.name,
      // company = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // startup.name = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      company: startup.name,
      // Analise da Linha: subtitle: startup.shortDescription,
      // subtitle = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // startup.shortDescription = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      subtitle: startup.shortDescription,
      // Analise da Linha: variation: startup.weeklyVariationPercent == null
      // variation = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // startup.weeklyVariationPercent == null = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      variation: startup.weeklyVariationPercent == null
          // Analise da Linha: ? ''
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          ? ''
          // Analise da Linha: : _formatPercent(startup.weeklyVariationPercent!),
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
          : _formatPercent(startup.weeklyVariationPercent!),
      // Analise da Linha: status: _stageLabel(startup.stage),
      // status = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // _stageLabel(startup.stage) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      status: _stageLabel(startup.stage),
      // Analise da Linha: value: _formatCurrencyCents(valueCents),
      // value = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // _formatCurrencyCents(valueCents) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      value: _formatCurrencyCents(valueCents),
      // Analise da Linha: imageUrl: startup.coverImageUrl,
      // imageUrl = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // startup.coverImageUrl = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      imageUrl: startup.coverImageUrl,
      // Analise da Linha: startup: startup,
      // startup = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // startup = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      startup: startup,
    // Analise da Linha: );
    // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
    // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
    );
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // Analise da Linha: final String company;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // company = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String company;
  // Analise da Linha: final String subtitle;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // subtitle = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String subtitle;
  // Analise da Linha: final String variation;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // variation = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String variation;
  // Analise da Linha: final String status;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // status = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String status;
  // Analise da Linha: final String value;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // value = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String value;
  // Analise da Linha: final String? imageUrl;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String? = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // imageUrl = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String? imageUrl;
  // Analise da Linha: final StartupDetail? startup;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // StartupDetail? = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // startup = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final StartupDetail? startup;
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}
