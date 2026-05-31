// GUILHERME PREVENTI CORREIA

// =============================================================================
// SECAO: IMPORTACOES
// =============================================================================
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
// Analise da Linha: import 'package:mobile/core/routes/app_routes.dart';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'package:mobile/core/routes/app_routes.dart' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'package:mobile/core/routes/app_routes.dart';
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
// Analise da Linha: import 'dart:async';
// import = Diretiva de Importacao. Traz uma biblioteca externa para este arquivo Dart.
// 'dart:async' = URI da Biblioteca. Indica exatamente qual pacote ou biblioteca sera usado.
// ; = Finalizador de Instrucao. Operador que indica o fim da diretiva de importacao.
import 'dart:async';

// =============================================================================
// SECAO: CLASSE: HomeHeader
// =============================================================================
// Analise da Linha: class HomeHeader extends StatelessWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// HomeHeader = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatelessWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class HomeHeader extends StatelessWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: HomeHeader
  // =============================================================================
  // Analise da Linha: const HomeHeader({
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // HomeHeader = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // ( = Delimitador de Parametros. Inicia a lista de argumentos recebidos pelo construtor.
  const HomeHeader({
    // Analise da Linha: super.key,
    // super.key = Encaminhamento de Chave. Repassa a Key para a classe pai do widget.
    // , = Separador de Argumento. Indica que outros parametros podem vir depois.
    super.key,
    // Analise da Linha: required this.primaryPurple,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.primaryPurple = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.primaryPurple,
    // Analise da Linha: required this.userName,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.userName = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.userName,
    // Analise da Linha: required this.userPhotoUrl,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.userPhotoUrl = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.userPhotoUrl,
    // Analise da Linha: required this.showBalance,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.showBalance = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.showBalance,
    // Analise da Linha: required this.onToggleVisibility,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.onToggleVisibility = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.onToggleVisibility,
    // Analise da Linha: required this.onNotificationsTap,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.onNotificationsTap = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.onNotificationsTap,
  // Analise da Linha: });
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
  // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
  });

  // Analise da Linha: final Color primaryPurple;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // Color = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // primaryPurple = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final Color primaryPurple;
  // Analise da Linha: final String userName;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // userName = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String userName;
  // Analise da Linha: final String? userPhotoUrl;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String? = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // userPhotoUrl = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String? userPhotoUrl;
  // Analise da Linha: final bool showBalance;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // bool = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // showBalance = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final bool showBalance;
  // Analise da Linha: final VoidCallback onToggleVisibility;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // VoidCallback = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onToggleVisibility = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final VoidCallback onToggleVisibility;
  // Analise da Linha: final VoidCallback onNotificationsTap;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // VoidCallback = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onNotificationsTap = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final VoidCallback onNotificationsTap;

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
    // Analise da Linha: return Row(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // Row( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return Row(
      // Analise da Linha: children: [
      // children = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      children: [
        // Analise da Linha: Container(
        // Container = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
        // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
        Container(
          // Analise da Linha: width: 40,
          // width = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // 40 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          width: 40,
          // Analise da Linha: height: 40,
          // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // 40 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          height: 40,
          // Analise da Linha: decoration: BoxDecoration(
          // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          decoration: BoxDecoration(
            // Analise da Linha: shape: BoxShape.circle,
            // shape = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // BoxShape.circle = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            shape: BoxShape.circle,
            // Analise da Linha: border: Border.all(color: Colors.white, width: 2),
            // border = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // Border.all(color: Colors.white, width: 2) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            border: Border.all(color: Colors.white, width: 2),
            // Analise da Linha: boxShadow: [
            // boxShadow = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            boxShadow: [
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
                // Analise da Linha: blurRadius: 10,
                // blurRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 10 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                blurRadius: 10,
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
          // Analise da Linha: child: ClipOval(child: _ProfileAvatar(photoUrl: userPhotoUrl)),
          // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // ClipOval(child: _ProfileAvatar(photoUrl: userPhotoUrl)) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          child: ClipOval(child: _ProfileAvatar(photoUrl: userPhotoUrl)),
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
        // Analise da Linha: Flexible(
        // Flexible = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
        // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
        Flexible(
          // Analise da Linha: child: Text(
          // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // Text( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          child: Text(
            // Analise da Linha: 'Ol\u00e1, $userName',
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
            'Ol\u00e1, $userName',
            // Analise da Linha: maxLines: 1,
            // maxLines = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // 1 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            maxLines: 1,
            // Analise da Linha: style: TextStyle(
            // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            style: TextStyle(
              // Analise da Linha: color: primaryPurple,
              // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // primaryPurple = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              color: primaryPurple,
              // Analise da Linha: fontSize: 17,
              // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // 17 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              fontSize: 17,
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
        // Analise da Linha: ),
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
        ),
        // Analise da Linha: const SizedBox(width: 10),
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
        const SizedBox(width: 10),

        // =============================================================================
        // SECAO: CONSTRUTOR: Spacer
        // =============================================================================
        // Analise da Linha: const Spacer(),
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
        const Spacer(),
        // Analise da Linha: _TapTarget(
        // _TapTarget = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
        // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
        _TapTarget(
          // Analise da Linha: onTap: onToggleVisibility,
          // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // onToggleVisibility = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          onTap: onToggleVisibility,
          // Analise da Linha: child: Icon(
          // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // Icon( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          child: Icon(
            // Analise da Linha: showBalance ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
            showBalance ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
            // Analise da Linha: color: primaryPurple,
            // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // primaryPurple = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            color: primaryPurple,
            // Analise da Linha: size: 23,
            // size = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // 23 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            size: 23,
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
        // Analise da Linha: _TapTarget(
        // _TapTarget = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
        // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
        _TapTarget(
          // Analise da Linha: onTap: onNotificationsTap,
          // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // onNotificationsTap = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          onTap: onNotificationsTap,
          // Analise da Linha: child: Icon(CupertinoIcons.bell, color: primaryPurple, size: 22),
          // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // Icon(CupertinoIcons.bell, color: primaryPurple, size: 22) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          child: Icon(CupertinoIcons.bell, color: primaryPurple, size: 22),
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
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: CLASSE: _ProfileAvatar
// =============================================================================
// Analise da Linha: class _ProfileAvatar extends StatelessWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// _ProfileAvatar = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatelessWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class _ProfileAvatar extends StatelessWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: _ProfileAvatar
  // =============================================================================
  // Analise da Linha: const _ProfileAvatar({required this.photoUrl});
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // _ProfileAvatar = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // { } = Delimitadores de Parametros Nomeados. Agrupam argumentos opcionais ou obrigatorios por nome.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao do construtor.
  const _ProfileAvatar({required this.photoUrl});

  // Analise da Linha: final String? photoUrl;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String? = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // photoUrl = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String? photoUrl;

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
    // Analise da Linha: final source = photoUrl?.trim();
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // source = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // photoUrl?.trim() = Expressao de Valor. Resultado armazenado nesta variavel.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
    final source = photoUrl?.trim();

    // Analise da Linha: if (source != null && source.isNotEmpty) {
    // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
    // (source != null && source.isNotEmpty) = Expressao Condicional. Teste logico avaliado antes do bloco.
    // { = Abertura de Bloco Condicional. Inicia as instrucoes do if.
    if (source != null && source.isNotEmpty) {
      // Analise da Linha: if (source.startsWith('http')) {
      // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
      // (source.startsWith('http')) = Expressao Condicional. Teste logico avaliado antes do bloco.
      // { = Abertura de Bloco Condicional. Inicia as instrucoes do if.
      if (source.startsWith('http')) {
        // Analise da Linha: return Image.network(
        // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
        // Image.network( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
        return Image.network(
          // Analise da Linha: source,
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
          source,
          // Analise da Linha: fit: BoxFit.cover,
          // fit = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // BoxFit.cover = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          fit: BoxFit.cover,
          // Analise da Linha: errorBuilder: (_, _, _) => const _DefaultProfileAvatar(),
          // errorBuilder = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // (_, _, _) => const _DefaultProfileAvatar() = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          errorBuilder: (_, _, _) => const _DefaultProfileAvatar(),
        // Analise da Linha: );
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
        );
      // Analise da Linha: }
      // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
      }

      // Analise da Linha: return Image.asset(
      // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
      // Image.asset( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
      return Image.asset(
        // Analise da Linha: source,
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
        source,
        // Analise da Linha: fit: BoxFit.cover,
        // fit = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // BoxFit.cover = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        fit: BoxFit.cover,
        // Analise da Linha: errorBuilder: (_, _, _) => const _DefaultProfileAvatar(),
        // errorBuilder = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // (_, _, _) => const _DefaultProfileAvatar() = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        errorBuilder: (_, _, _) => const _DefaultProfileAvatar(),
      // Analise da Linha: );
      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
      // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
      );
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
    }

    // Analise da Linha: return Image.asset(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // Image.asset( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return Image.asset(
      // Analise da Linha: 'assets/images/perfil.png',
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
      'assets/images/perfil.png',
      // Analise da Linha: fit: BoxFit.cover,
      // fit = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // BoxFit.cover = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      fit: BoxFit.cover,
      // Analise da Linha: errorBuilder: (_, _, _) => const _DefaultProfileAvatar(),
      // errorBuilder = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // (_, _, _) => const _DefaultProfileAvatar() = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      errorBuilder: (_, _, _) => const _DefaultProfileAvatar(),
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
// SECAO: CLASSE: _DefaultProfileAvatar
// =============================================================================
// Analise da Linha: class _DefaultProfileAvatar extends StatelessWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// _DefaultProfileAvatar = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatelessWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class _DefaultProfileAvatar extends StatelessWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: _DefaultProfileAvatar
  // =============================================================================
  // Analise da Linha: const _DefaultProfileAvatar();
  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
  // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
  const _DefaultProfileAvatar();

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
    // Analise da Linha: return const DecoratedBox(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // const DecoratedBox( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return const DecoratedBox(
      // Analise da Linha: decoration: BoxDecoration(
      // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      decoration: BoxDecoration(
        // Analise da Linha: gradient: LinearGradient(
        // gradient = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // LinearGradient( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        gradient: LinearGradient(
          // Analise da Linha: begin: Alignment.topCenter,
          // begin = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // Alignment.topCenter = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          begin: Alignment.topCenter,
          // Analise da Linha: end: Alignment.bottomCenter,
          // end = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // Alignment.bottomCenter = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          end: Alignment.bottomCenter,
          // Analise da Linha: colors: [Color(0xFF5A2D91), Color(0xFF9B8BAF)],
          // colors = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // [Color(0xFF5A2D91), Color(0xFF9B8BAF)] = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          colors: [Color(0xFF5A2D91), Color(0xFF9B8BAF)],
        // Analise da Linha: ),
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
        ),
      // Analise da Linha: ),
      // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
      // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
      ),
      // Analise da Linha: child: Icon(CupertinoIcons.person_fill, color: Colors.white, size: 23),
      // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // Icon(CupertinoIcons.person_fill, color: Colors.white, size: 23) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      child: Icon(CupertinoIcons.person_fill, color: Colors.white, size: 23),
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

// ── ALTERADO: StatelessWidget → StatefulWidget para buscar saldo ──

// =============================================================================
// SECAO: CLASSE: WalletCard
// =============================================================================
// Analise da Linha: class WalletCard extends StatefulWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// WalletCard = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatefulWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class WalletCard extends StatefulWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: WalletCard
  // =============================================================================
  // Analise da Linha: const WalletCard({
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // WalletCard = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // ( = Delimitador de Parametros. Inicia a lista de argumentos recebidos pelo construtor.
  const WalletCard({
    // Analise da Linha: super.key,
    // super.key = Encaminhamento de Chave. Repassa a Key para a classe pai do widget.
    // , = Separador de Argumento. Indica que outros parametros podem vir depois.
    super.key,
    // Analise da Linha: required this.primaryPurple,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.primaryPurple = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.primaryPurple,
    // Analise da Linha: required this.showBalance,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.showBalance = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.showBalance,
    // Analise da Linha: required this.onCardTap,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.onCardTap = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.onCardTap,
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

  // Analise da Linha: final Color primaryPurple;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // Color = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // primaryPurple = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final Color primaryPurple;
  // Analise da Linha: final bool showBalance;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // bool = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // showBalance = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final bool showBalance;
  // Analise da Linha: final VoidCallback onCardTap;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // VoidCallback = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onCardTap = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final VoidCallback onCardTap;
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
  // SECAO: FUNCAO/METODO: createState
  // =============================================================================
  // Analise da Linha: State<WalletCard> createState() => _WalletCardState();
  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
  // => = Arrow Function. Retorna a expressao da direita de forma compacta.
  // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
  State<WalletCard> createState() => _WalletCardState();
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: CLASSE: _WalletCardState
// =============================================================================
// Analise da Linha: class _WalletCardState extends State<WalletCard> {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// _WalletCardState = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de State<WalletCard>.
// { = Abertura de Bloco. Inicia o corpo da classe.
class _WalletCardState extends State<WalletCard> {
  // Analise da Linha: double _saldo = 0;
  // double = Tipo da Variavel. Define quais valores podem ser armazenados aqui.
  // _saldo = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // = = Operador de Atribuicao. Define o valor inicial da variavel.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  double _saldo = 0;
  // Analise da Linha: bool _carregando = true;
  // bool = Tipo da Variavel. Define quais valores podem ser armazenados aqui.
  // _carregando = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // = = Operador de Atribuicao. Define o valor inicial da variavel.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  bool _carregando = true;
  // Analise da Linha: StreamSubscription? _subscription;
  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
  // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
  StreamSubscription? _subscription;

  // Analise da Linha: @override
  // @override = Anotacao de Sobrescrita. Informa que o metodo abaixo substitui um metodo herdado.
  @override

  // =============================================================================
  // SECAO: FUNCAO/METODO: initState
  // =============================================================================
  // Analise da Linha: void initState() {
  // void = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // initState = Identificador da Funcao/Metodo. Nome tecnico usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  void initState() {
    // Analise da Linha: super.initState();
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    super.initState();
    // Analise da Linha: _ouvirSaldo();
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
    _ouvirSaldo();
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

  // =============================================================================
  // SECAO: FUNCAO/METODO: _ouvirSaldo
  // =============================================================================
  // Analise da Linha: void _ouvirSaldo() {
  // void = Tipo de Retorno. Define o tipo de valor que esta funcao ou metodo entrega.
  // _ouvirSaldo = Identificador da Funcao/Metodo. Nome tecnico usado para chamar este bloco de comportamento.
  // ( ) = Delimitadores de Parametros. Contem os dados recebidos pela funcao ou metodo.
  // { = Abertura de Bloco. Inicia o corpo executavel.
  void _ouvirSaldo() {
    // Analise da Linha: final uid = FirebaseAuth.instance.currentUser?.uid;
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // uid = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // FirebaseAuth.instance.currentUser?.uid = Expressao de Valor. Resultado armazenado nesta variavel.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
    final uid = FirebaseAuth.instance.currentUser?.uid;
    // Analise da Linha: if (uid == null) {
    // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
    // (uid == null) = Expressao Condicional. Teste logico avaliado antes do bloco.
    // { = Abertura de Bloco Condicional. Inicia as instrucoes do if.
    if (uid == null) {
      // Analise da Linha: setState(() => _carregando = false);
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // => = Arrow Function. Retorna a expressao da direita de forma compacta.
      // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
      setState(() => _carregando = false);
      // Analise da Linha: return;
      // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
      // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
      return;
    // Analise da Linha: }
    // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
    }

    // Analise da Linha: _subscription = FirebaseFirestore.instance
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    _subscription = FirebaseFirestore.instance
        // Analise da Linha: .collection('users')
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        .collection('users')
        // Analise da Linha: .doc(uid)
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        .doc(uid)
        // Analise da Linha: .collection('carteira')
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        .collection('carteira')
        // Analise da Linha: .doc('saldo')
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        .doc('saldo')
        // Analise da Linha: .snapshots()
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        .snapshots()
        // Analise da Linha: .listen((snap) {
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        // { = Abertura de Bloco. Inicia um novo escopo.
        .listen((snap) {
          // Analise da Linha: if (!mounted) return;
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
          if (!mounted) return;
          // Analise da Linha: setState(() {
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          // { = Abertura de Bloco. Inicia um novo escopo.
          setState(() {
            // Analise da Linha: _saldo = (snap.data()?['saldo'] as num? ?? 0).toDouble();
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            // ?? = Operador de Coalescencia Nula. Usa o valor da direita se o da esquerda for null.
            // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
            _saldo = (snap.data()?['saldo'] as num? ?? 0).toDouble();
            // Analise da Linha: _carregando = false;
            // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
            // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
            _carregando = false;
          // Analise da Linha: });
          // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
          // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
          });
        // Analise da Linha: });
        // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
        });
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }

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
    // Analise da Linha: _subscription?.cancel(); // <-- cancela ao sair
    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
    // ?. = Acesso Seguro. Chama membro somente se o objeto da esquerda nao for null.
    _subscription?.cancel(); // <-- cancela ao sair
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
    // Analise da Linha: final saldoTexto = _carregando
    // final = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // saldoTexto = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // _carregando = Expressao de Valor. Resultado armazenado nesta variavel.
    final saldoTexto = _carregando
        // Analise da Linha: ? 'Carregando...'
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        ? 'Carregando...'
        // Analise da Linha: : widget.showBalance
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        : widget.showBalance
        // Analise da Linha: ? 'R\$ ${_saldo.toStringAsFixed(2)}'
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        // { = Abertura de Bloco. Inicia um novo escopo.
        // } = Fechamento de Bloco. Encerra um escopo aberto anteriormente.
        ? 'R\$ ${_saldo.toStringAsFixed(2)}'
        // Analise da Linha: : 'R\$ ******';
        // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
        // ; = Finalizador de Instrucao. Marca o fim da instrucao atual.
        : 'R\$ ******';

    // Analise da Linha: return Container(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // Container( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return Container(
      // Analise da Linha: padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // const EdgeInsets.fromLTRB(14, 14, 14, 12) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      // Analise da Linha: decoration: BoxDecoration(
      // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      decoration: BoxDecoration(
        // Analise da Linha: borderRadius: BorderRadius.circular(18),
        // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // BorderRadius.circular(18) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        borderRadius: BorderRadius.circular(18),
        // Analise da Linha: gradient: const LinearGradient(
        // gradient = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // const LinearGradient( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        gradient: const LinearGradient(
          // Analise da Linha: begin: Alignment.topLeft,
          // begin = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // Alignment.topLeft = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          begin: Alignment.topLeft,
          // Analise da Linha: end: Alignment.bottomRight,
          // end = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // Alignment.bottomRight = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          end: Alignment.bottomRight,
          // Analise da Linha: colors: [Color(0xFF6B33B4), Color(0xFF5B2E92), Color(0xFF44206F)],
          // colors = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // [Color(0xFF6B33B4), Color(0xFF5B2E92), Color(0xFF44206F)] = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          colors: [Color(0xFF6B33B4), Color(0xFF5B2E92), Color(0xFF44206F)],
        // Analise da Linha: ),
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
        ),
        // Analise da Linha: boxShadow: [
        // boxShadow = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        boxShadow: [
          // Analise da Linha: BoxShadow(
          // BoxShadow = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
          // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
          BoxShadow(
            // Analise da Linha: color: widget.primaryPurple.withValues(alpha: 0.18),
            // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // widget.primaryPurple.withValues(alpha: 0.18) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            color: widget.primaryPurple.withValues(alpha: 0.18),
            // Analise da Linha: blurRadius: 22,
            // blurRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // 22 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            blurRadius: 22,
            // Analise da Linha: offset: const Offset(0, 12),
            // offset = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // const Offset(0, 12) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            offset: const Offset(0, 12),
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

              // =============================================================================
              // SECAO: CONSTRUTOR: Expanded
              // =============================================================================
              // Analise da Linha: const Expanded(
              // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
              // Expanded = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
              // ( = Delimitador de Parametros. Inicia a lista de argumentos recebidos pelo construtor.
              const Expanded(
                // Analise da Linha: child: Text(
                // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // Text( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                child: Text(
                  // Analise da Linha: 'MesclaInvest',
                  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                  // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                  'MesclaInvest',
                  // Analise da Linha: style: TextStyle(
                  // style = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // TextStyle( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  style: TextStyle(
                    // Analise da Linha: color: Colors.white,
                    // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // Colors.white = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    color: Colors.white,
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
              // Analise da Linha: Text(
              // Text = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
              // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
              Text(
                // Analise da Linha: saldoTexto, // ── ALTERADO: era 'R\$ 1.922,34'
                // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                saldoTexto, // ── ALTERADO: era 'R\$ 1.922,34'
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
                  // Analise da Linha: fontFamily: 'Georgia',
                  // fontFamily = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // 'Georgia' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  fontFamily: 'Georgia',
                  // Analise da Linha: fontSize: 18,
                  // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // 18 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  fontSize: 18,
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

          // =============================================================================
          // SECAO: CONSTRUTOR: SizedBox
          // =============================================================================
          // Analise da Linha: const SizedBox(height: 9),
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
          const SizedBox(height: 9),
          // Analise da Linha: const SizedBox(height: 20),
          // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
          // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
          const SizedBox(height: 20),
          // Analise da Linha: Row(
          // Row = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
          // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
          Row(
            // Analise da Linha: children: [
            // children = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            children: [
              // Analise da Linha: _CardActionChip(
              // _CardActionChip = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
              // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
              _CardActionChip(
                // Analise da Linha: label: 'Carteira',
                // label = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 'Carteira' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                label: 'Carteira',
                // Analise da Linha: icon: CupertinoIcons.creditcard_fill,
                // icon = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // CupertinoIcons.creditcard_fill = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                icon: CupertinoIcons.creditcard_fill,
                // Analise da Linha: onTap: widget.onCardTap,
                // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // widget.onCardTap = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                onTap: widget.onCardTap,
              // Analise da Linha: ),
              // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
              // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
              ),

              // =============================================================================
              // SECAO: CONSTRUTOR: Spacer
              // =============================================================================
              // Analise da Linha: const Spacer(),
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              const Spacer(),
              // Analise da Linha: _TapTarget(
              // _TapTarget = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
              // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
              _TapTarget(
                // Analise da Linha: onTap: widget.onMoreTap,
                // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // widget.onMoreTap = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                onTap: widget.onMoreTap,
                // Analise da Linha: child: Container(
                // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // Container( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                child: Container(
                  // Analise da Linha: width: 24,
                  // width = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // 24 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  width: 24,
                  // Analise da Linha: height: 24,
                  // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // 24 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  height: 24,
                  // Analise da Linha: decoration: BoxDecoration(
                  // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  decoration: BoxDecoration(
                    // Analise da Linha: color: Colors.black.withValues(alpha: 0.35),
                    // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // Colors.black.withValues(alpha: 0.35) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    color: Colors.black.withValues(alpha: 0.35),
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
                  // Analise da Linha: alignment: Alignment.center,
                  // alignment = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // Alignment.center = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  alignment: Alignment.center,
                  // Analise da Linha: child: const Icon(
                  // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // const Icon( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  child: const Icon(
                    // Analise da Linha: CupertinoIcons.ellipsis,
                    // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                    // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                    CupertinoIcons.ellipsis,
                    // Analise da Linha: color: Colors.white,
                    // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                    // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                    // Colors.white = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                    // , = Separador de Argumento. Permite informar outro argumento depois.
                    color: Colors.white,
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
// SECAO: CLASSE: _CardActionChip
// =============================================================================
// Analise da Linha: class _CardActionChip extends StatelessWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// _CardActionChip = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatelessWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class _CardActionChip extends StatelessWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: _CardActionChip
  // =============================================================================
  // Analise da Linha: const _CardActionChip({
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // _CardActionChip = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // ( = Delimitador de Parametros. Inicia a lista de argumentos recebidos pelo construtor.
  const _CardActionChip({
    // Analise da Linha: required this.label,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.label = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.label,
    // Analise da Linha: required this.icon,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.icon = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.icon,
    // Analise da Linha: required this.onTap,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.onTap = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.onTap,
  // Analise da Linha: });
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
  // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
  });

  // Analise da Linha: final String label;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // label = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String label;
  // Analise da Linha: final IconData icon;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // IconData = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // icon = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final IconData icon;
  // Analise da Linha: final VoidCallback onTap;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // VoidCallback = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onTap = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final VoidCallback onTap;

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
        // Analise da Linha: borderRadius: BorderRadius.circular(16),
        // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // BorderRadius.circular(16) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        borderRadius: BorderRadius.circular(16),
        // Analise da Linha: child: Container(
        // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // Container( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        child: Container(
          // Analise da Linha: height: 30,
          // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // 30 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          height: 30,
          // Analise da Linha: padding: const EdgeInsets.symmetric(horizontal: 9),
          // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // const EdgeInsets.symmetric(horizontal: 9) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          padding: const EdgeInsets.symmetric(horizontal: 9),
          // Analise da Linha: decoration: BoxDecoration(
          // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          decoration: BoxDecoration(
            // Analise da Linha: color: Colors.black.withValues(alpha: 0.26),
            // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // Colors.black.withValues(alpha: 0.26) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            color: Colors.black.withValues(alpha: 0.26),
            // Analise da Linha: borderRadius: BorderRadius.circular(16),
            // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // BorderRadius.circular(16) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            borderRadius: BorderRadius.circular(16),
          // Analise da Linha: ),
          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
          // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
          ),
          // Analise da Linha: child: Row(
          // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // Row( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          child: Row(
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
              // Analise da Linha: Icon(icon, color: Colors.white, size: 14),
              // Icon = Chamada de Construtor/Funcao. Cria um widget/objeto ou executa um metodo.
              // ( ) = Delimitadores de Argumentos. Contem os valores enviados na chamada.
              // , = Separador de Argumento. Mantem a lista externa em continuidade.
              Icon(icon, color: Colors.white, size: 14),

              // =============================================================================
              // SECAO: CONSTRUTOR: SizedBox
              // =============================================================================
              // Analise da Linha: const SizedBox(width: 5),
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              const SizedBox(width: 5),
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
                  // Analise da Linha: fontSize: 10.5,
                  // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // 10.5 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  fontSize: 10.5,
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
    // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
    );
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: CLASSE: _TapTarget
// =============================================================================
// Analise da Linha: class _TapTarget extends StatelessWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// _TapTarget = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatelessWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class _TapTarget extends StatelessWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: _TapTarget
  // =============================================================================
  // Analise da Linha: const _TapTarget({required this.onTap, required this.child});
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // _TapTarget = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // { } = Delimitadores de Parametros Nomeados. Agrupam argumentos opcionais ou obrigatorios por nome.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao do construtor.
  const _TapTarget({required this.onTap, required this.child});

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
        // Analise da Linha: radius: 24,
        // radius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // 24 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        radius: 24,
        // Analise da Linha: child: Padding(padding: const EdgeInsets.all(4), child: child),
        // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // Padding(padding: const EdgeInsets.all(4), child: child) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        child: Padding(padding: const EdgeInsets.all(4), child: child),
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
// SECAO: CLASSE: QuickActions
// =============================================================================
// Analise da Linha: class QuickActions extends StatelessWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// QuickActions = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatelessWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class QuickActions extends StatelessWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: QuickActions
  // =============================================================================
  // Analise da Linha: const QuickActions({super.key, required this.onRouteTap});
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // QuickActions = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // { } = Delimitadores de Parametros Nomeados. Agrupam argumentos opcionais ou obrigatorios por nome.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao do construtor.
  const QuickActions({super.key, required this.onRouteTap});

  // Analise da Linha: final ValueChanged<String> onRouteTap;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // ValueChanged<String> = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onRouteTap = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final ValueChanged<String> onRouteTap;

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
    // Analise da Linha: const background = Color(0xFFEFEFF2);
    // const = Modificador de Declaracao. Cria uma variavel local com valor unico ou constante.
    // background = Identificador da Variavel. Nome tecnico usado para acessar o resultado depois.
    // = = Operador de Atribuicao. Coloca o valor calculado dentro da variavel.
    // Color(0xFFEFEFF2) = Expressao de Valor. Resultado armazenado nesta variavel.
    // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao local.
    const background = Color(0xFFEFEFF2);

    // Analise da Linha: return Row(
    // return = Instrucao de Retorno. Entrega um valor e encerra a execucao atual.
    // Row( = Expressao Retornada. Valor, widget ou objeto devolvido ao chamador.
    return Row(
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
        // Analise da Linha: _QuickActionButton(
        // _QuickActionButton = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
        // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
        _QuickActionButton(
          // Analise da Linha: label: 'Investir',
          // label = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // 'Investir' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          label: 'Investir',
          // Analise da Linha: backgroundColor: background,
          // backgroundColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // background = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          backgroundColor: background,
          // Analise da Linha: icon: Icons.insert_chart_outlined_rounded,
          // icon = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // Icons.insert_chart_outlined_rounded = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          icon: Icons.insert_chart_outlined_rounded,
          // Analise da Linha: onTap: () => onRouteTap(AppRoutes.investir),
          // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // () => onRouteTap(AppRoutes.investir) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          onTap: () => onRouteTap(AppRoutes.investir),
        // Analise da Linha: ),
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
        ),
        // Analise da Linha: _QuickActionButton(
        // _QuickActionButton = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
        // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
        _QuickActionButton(
          // Analise da Linha: label: 'Vender',
          // label = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // 'Vender' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          label: 'Vender',
          // Analise da Linha: backgroundColor: background,
          // backgroundColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // background = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          backgroundColor: background,
          // Analise da Linha: icon: CupertinoIcons.money_dollar_circle,
          // icon = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // CupertinoIcons.money_dollar_circle = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          icon: CupertinoIcons.money_dollar_circle,
          // Analise da Linha: onTap: () => onRouteTap(AppRoutes.vender),
          // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // () => onRouteTap(AppRoutes.vender) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          onTap: () => onRouteTap(AppRoutes.vender),
        // Analise da Linha: ),
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
        ),
        // Analise da Linha: _QuickActionButton(
        // _QuickActionButton = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
        // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
        _QuickActionButton(
          // Analise da Linha: label: 'Depositar',
          // label = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // 'Depositar' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          label: 'Depositar',
          // Analise da Linha: backgroundColor: background,
          // backgroundColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // background = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          backgroundColor: background,
          // Analise da Linha: icon: CupertinoIcons.arrow_up,
          // icon = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // CupertinoIcons.arrow_up = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          icon: CupertinoIcons.arrow_up,
          // Analise da Linha: onTap: () => onRouteTap(AppRoutes.depositar),
          // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // () => onRouteTap(AppRoutes.depositar) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          onTap: () => onRouteTap(AppRoutes.depositar),
        // Analise da Linha: ),
        // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
        // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
        ),
        // Analise da Linha: _QuickActionButton(
        // _QuickActionButton = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
        // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
        _QuickActionButton(
          // Analise da Linha: label: 'Sacar',
          // label = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // 'Sacar' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          label: 'Sacar',
          // Analise da Linha: backgroundColor: background,
          // backgroundColor = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // background = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          backgroundColor: background,
          // Analise da Linha: icon: CupertinoIcons.arrow_down,
          // icon = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // CupertinoIcons.arrow_down = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          icon: CupertinoIcons.arrow_down,
          // Analise da Linha: onTap: () => onRouteTap(AppRoutes.sacar),
          // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // () => onRouteTap(AppRoutes.sacar) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          onTap: () => onRouteTap(AppRoutes.sacar),
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
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: CLASSE: _QuickActionButton
// =============================================================================
// Analise da Linha: class _QuickActionButton extends StatelessWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// _QuickActionButton = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatelessWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class _QuickActionButton extends StatelessWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: _QuickActionButton
  // =============================================================================
  // Analise da Linha: const _QuickActionButton({
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // _QuickActionButton = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // ( = Delimitador de Parametros. Inicia a lista de argumentos recebidos pelo construtor.
  const _QuickActionButton({
    // Analise da Linha: required this.label,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.label = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.label,
    // Analise da Linha: required this.icon,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.icon = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.icon,
    // Analise da Linha: required this.backgroundColor,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.backgroundColor = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.backgroundColor,
    // Analise da Linha: required this.onTap,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.onTap = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.onTap,
  // Analise da Linha: });
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
  // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
  });

  // Analise da Linha: final String label;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // label = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String label;
  // Analise da Linha: final IconData icon;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // IconData = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // icon = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final IconData icon;
  // Analise da Linha: final Color backgroundColor;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // Color = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // backgroundColor = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final Color backgroundColor;
  // Analise da Linha: final VoidCallback onTap;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // VoidCallback = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onTap = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final VoidCallback onTap;

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
        // Analise da Linha: borderRadius: BorderRadius.circular(32),
        // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // BorderRadius.circular(32) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        borderRadius: BorderRadius.circular(32),
        // Analise da Linha: child: Padding(
        // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // Padding( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        child: Padding(
          // Analise da Linha: padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // const EdgeInsets.symmetric(horizontal: 4, vertical: 2) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          // Analise da Linha: child: Column(
          // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // Column( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          child: Column(
            // Analise da Linha: children: [
            // children = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            children: [
              // Analise da Linha: Container(
              // Container = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
              // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
              Container(
                // Analise da Linha: width: 46,
                // width = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 46 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                width: 46,
                // Analise da Linha: height: 46,
                // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // 46 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                height: 46,
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
                // Analise da Linha: alignment: Alignment.center,
                // alignment = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // Alignment.center = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                alignment: Alignment.center,
                // Analise da Linha: child: Icon(icon, color: Colors.black87, size: 23),
                // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                // Icon(icon, color: Colors.black87, size: 23) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                // , = Separador de Argumento. Permite informar outro argumento depois.
                child: Icon(icon, color: Colors.black87, size: 23),
              // Analise da Linha: ),
              // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
              // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
              ),

              // =============================================================================
              // SECAO: CONSTRUTOR: SizedBox
              // =============================================================================
              // Analise da Linha: const SizedBox(height: 9),
              // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
              // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
              const SizedBox(height: 9),
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
                  // Analise da Linha: color: Color(0xFF333333),
                  // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // Color(0xFF333333) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  color: Color(0xFF333333),
                  // Analise da Linha: fontSize: 15,
                  // fontSize = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
                  // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
                  // 15 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
                  // , = Separador de Argumento. Permite informar outro argumento depois.
                  fontSize: 15,
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
    // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
    );
  // Analise da Linha: }
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  }
// Analise da Linha: }
// } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
}

// =============================================================================
// SECAO: CLASSE: HomeBottomNavigationBar
// =============================================================================
// Analise da Linha: class HomeBottomNavigationBar extends StatelessWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// HomeBottomNavigationBar = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatelessWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class HomeBottomNavigationBar extends StatelessWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: HomeBottomNavigationBar
  // =============================================================================
  // Analise da Linha: const HomeBottomNavigationBar({super.key, required this.onRouteTap});
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // HomeBottomNavigationBar = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // { } = Delimitadores de Parametros Nomeados. Agrupam argumentos opcionais ou obrigatorios por nome.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao do construtor.
  const HomeBottomNavigationBar({super.key, required this.onRouteTap});

  // Analise da Linha: final ValueChanged<String> onRouteTap;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // ValueChanged<String> = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onRouteTap = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final ValueChanged<String> onRouteTap;

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
      // Analise da Linha: height: 74,
      // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // 74 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      height: 74,
      // Analise da Linha: padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // const EdgeInsets.symmetric(horizontal: 12, vertical: 10) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      // , = Separador de Argumento. Permite informar outro argumento depois.
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      // Analise da Linha: decoration: BoxDecoration(
      // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      decoration: BoxDecoration(
        // Analise da Linha: color: const Color(0xFF2C2C2F),
        // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // const Color(0xFF2C2C2F) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        color: const Color(0xFF2C2C2F),
        // Analise da Linha: borderRadius: BorderRadius.circular(38),
        // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // BorderRadius.circular(38) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        borderRadius: BorderRadius.circular(38),
        // Analise da Linha: boxShadow: [
        // boxShadow = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        boxShadow: [
          // Analise da Linha: BoxShadow(
          // BoxShadow = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
          // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
          BoxShadow(
            // Analise da Linha: color: Colors.black.withValues(alpha: 0.14),
            // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // Colors.black.withValues(alpha: 0.14) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            color: Colors.black.withValues(alpha: 0.14),
            // Analise da Linha: blurRadius: 18,
            // blurRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // 18 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            blurRadius: 18,
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
      // Analise da Linha: child: Row(
      // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
      // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
      // Row( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
      child: Row(
        // Analise da Linha: mainAxisAlignment: MainAxisAlignment.spaceAround,
        // mainAxisAlignment = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // MainAxisAlignment.spaceAround = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // Analise da Linha: children: [
        // children = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // [ = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        children: [
          // Analise da Linha: _NavIcon(
          // _NavIcon = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
          // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
          _NavIcon(
            // Analise da Linha: icon: CupertinoIcons.house_fill,
            // icon = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // CupertinoIcons.house_fill = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            icon: CupertinoIcons.house_fill,
            // Analise da Linha: isActive: true,
            // isActive = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // true = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            isActive: true,
            // Analise da Linha: label: 'Home',
            // label = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // 'Home' = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            label: 'Home',
            // Analise da Linha: onTap: () => onRouteTap(AppRoutes.mainRoute),
            // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // () => onRouteTap(AppRoutes.mainRoute) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            onTap: () => onRouteTap(AppRoutes.mainRoute),
          // Analise da Linha: ),
          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
          // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
          ),
          // Analise da Linha: _NavIcon(
          // _NavIcon = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
          // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
          _NavIcon(
            // Analise da Linha: icon: CupertinoIcons.search,
            // icon = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // CupertinoIcons.search = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            icon: CupertinoIcons.search,
            // Analise da Linha: isActive: false,
            // isActive = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // false = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            isActive: false,
            // Analise da Linha: onTap: () => onRouteTap(AppRoutes.catalogo),
            // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // () => onRouteTap(AppRoutes.catalogo) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            onTap: () => onRouteTap(AppRoutes.catalogo),
          // Analise da Linha: ),
          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
          // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
          ),
          // Analise da Linha: _NavIcon(
          // _NavIcon = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
          // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
          _NavIcon(
            // Analise da Linha: icon: CupertinoIcons.square_grid_2x2,
            // icon = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // CupertinoIcons.square_grid_2x2 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            icon: CupertinoIcons.square_grid_2x2,
            // Analise da Linha: isActive: false,
            // isActive = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // false = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            isActive: false,
            // Analise da Linha: onTap: () => onRouteTap(AppRoutes.balcao),
            // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // () => onRouteTap(AppRoutes.balcao) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            onTap: () => onRouteTap(AppRoutes.balcao),
          // Analise da Linha: ),
          // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
          // , = Separador de Elemento. Indica continuidade dentro de uma lista ou chamada externa.
          ),
          // Analise da Linha: _NavIcon(
          // _NavIcon = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
          // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
          _NavIcon(
            // Analise da Linha: icon: CupertinoIcons.person_crop_circle,
            // icon = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // CupertinoIcons.person_crop_circle = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            icon: CupertinoIcons.person_crop_circle,
            // Analise da Linha: isActive: false,
            // isActive = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // false = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            isActive: false,
            // Analise da Linha: onTap: () => onRouteTap(AppRoutes.profileSecurity),
            // onTap = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // () => onRouteTap(AppRoutes.profileSecurity) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            onTap: () => onRouteTap(AppRoutes.profileSecurity),
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
// SECAO: CLASSE: _NavIcon
// =============================================================================
// Analise da Linha: class _NavIcon extends StatelessWidget {
// class = Palavra-chave de Declaracao de Classe. Inicia um novo tipo no Dart.
// _NavIcon = Identificador da Classe. Nome tecnico usado para instanciar ou referenciar essa estrutura.
// extends = Relacao de Heranca. Indica que esta classe recebe comportamento base de StatelessWidget.
// { = Abertura de Bloco. Inicia o corpo da classe.
class _NavIcon extends StatelessWidget {

  // =============================================================================
  // SECAO: CONSTRUTOR: _NavIcon
  // =============================================================================
  // Analise da Linha: const _NavIcon({
  // const = Modificador de Construtor Constante. Permite criar a instancia em tempo de compilacao quando possivel.
  // _NavIcon = Identificador do Construtor. Usa o mesmo nome da classe que esta sendo criada.
  // ( = Delimitador de Parametros. Inicia a lista de argumentos recebidos pelo construtor.
  const _NavIcon({
    // Analise da Linha: required this.icon,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.icon = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.icon,
    // Analise da Linha: required this.isActive,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.isActive = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.isActive,
    // Analise da Linha: required this.onTap,
    // required = Modificador de Obrigatoriedade. Exige que esse parametro seja informado na criacao do objeto.
    // this.onTap = Parametro de Campo. Recebe o valor e preenche diretamente a propriedade da classe.
    // , = Separador de Parametro. Mantem a lista de parametros aberta para o proximo item.
    required this.onTap,
    // Analise da Linha: this.label,
    // this.label = Parametro Opcional de Campo. Permite preencher esta propriedade ao construir o objeto.
    // , = Separador de Parametro. Continua a lista de parametros.
    this.label,
  // Analise da Linha: });
  // } = Fechamento de Bloco. Encerra o escopo aberto anteriormente.
  // ) = Fechamento de Argumentos. Encerra uma chamada de funcao, metodo ou construtor.
  // ; = Finalizador de Instrucao. Operador que indica o fim da expressao atual.
  });

  // Analise da Linha: final IconData icon;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // IconData = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // icon = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final IconData icon;
  // Analise da Linha: final bool isActive;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // bool = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // isActive = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final bool isActive;
  // Analise da Linha: final VoidCallback onTap;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // VoidCallback = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // onTap = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final VoidCallback onTap;
  // Analise da Linha: final String? label;
  // final = Modificador de Imutabilidade. Permite atribuir o valor uma unica vez.
  // String? = Tipo Declarado. Define a categoria de dado aceita por este campo.
  // label = Identificador da Variavel. Nome tecnico usado para acessar esse valor no codigo.
  // ; = Finalizador de Instrucao. Operador que indica o fim da declaracao.
  final String? label;

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
    // Analise da Linha: if (isActive) {
    // if = Estrutura Condicional. Executa o bloco somente se a condicao for verdadeira.
    // (isActive) = Expressao Condicional. Teste logico avaliado antes do bloco.
    // { = Abertura de Bloco Condicional. Inicia as instrucoes do if.
    if (isActive) {
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
          // Analise da Linha: borderRadius: BorderRadius.circular(22),
          // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // BorderRadius.circular(22) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          borderRadius: BorderRadius.circular(22),
          // Analise da Linha: child: Container(
          // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // Container( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          child: Container(
            // Analise da Linha: height: 38,
            // height = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // 38 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            height: 38,
            // Analise da Linha: padding: const EdgeInsets.symmetric(horizontal: 14),
            // padding = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // const EdgeInsets.symmetric(horizontal: 14) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            // , = Separador de Argumento. Permite informar outro argumento depois.
            padding: const EdgeInsets.symmetric(horizontal: 14),
            // Analise da Linha: decoration: BoxDecoration(
            // decoration = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
            // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
            // BoxDecoration( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
            decoration: BoxDecoration(
              // Analise da Linha: color: const Color(0xFF6B33B4),
              // color = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // const Color(0xFF6B33B4) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              color: const Color(0xFF6B33B4),
              // Analise da Linha: borderRadius: BorderRadius.circular(22),
              // borderRadius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
              // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
              // BorderRadius.circular(22) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
              // , = Separador de Argumento. Permite informar outro argumento depois.
              borderRadius: BorderRadius.circular(22),
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
                // Analise da Linha: const SizedBox(width: 7),
                // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                const SizedBox(width: 7),
                // Analise da Linha: Text(
                // Text = Chamada de Construtor/Funcao. Inicia a criacao de um objeto ou execucao de uma rotina.
                // ( = Abertura de Argumentos. Comeca a lista de parametros enviados.
                Text(
                  // Analise da Linha: label ?? '',
                  // Linha = Instrucao Dart. Participa da declaracao, configuracao ou composicao da interface.
                  // ?? = Operador de Coalescencia Nula. Usa o valor da direita se o da esquerda for null.
                  // , = Separador. Mantem a lista de argumentos ou elementos em continuidade.
                  label ?? '',
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
        // Analise da Linha: radius: 24,
        // radius = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // 24 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        // , = Separador de Argumento. Permite informar outro argumento depois.
        radius: 24,
        // Analise da Linha: child: SizedBox(
        // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
        // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
        // SizedBox( = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
        child: SizedBox(
          // Analise da Linha: width: 42,
          // width = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // 42 = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          width: 42,
          // Analise da Linha: child: Center(child: Icon(icon, color: Colors.white, size: 22)),
          // child = Nome do Argumento/Propriedade. Indica qual parametro esta sendo preenchido.
          // : = Separador Nomeado. Liga o nome do argumento ao valor informado.
          // Center(child: Icon(icon, color: Colors.white, size: 22)) = Valor do Argumento. Expressao passada para configurar o widget ou objeto.
          // , = Separador de Argumento. Permite informar outro argumento depois.
          child: Center(child: Icon(icon, color: Colors.white, size: 22)),
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
