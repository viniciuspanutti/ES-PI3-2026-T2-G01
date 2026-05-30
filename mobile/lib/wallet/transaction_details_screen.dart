//feito por camila fernandes costacurta RA:25012949 
import 'package:flutter/material.dart'; // Biblioteca base do Flutter (permite usar widgets como Scaffold, Column, Text).

// ESTA CLASSE DEFINE A TELA DE COMPROVANTE QUE APARECE QUANDO O USUÁRIO CLICA EM UMA TRANSAÇÃO NO HISTÓRICO.
class TransactionDetailsScreen extends StatelessWidget { // Widget fixo (não muda de estado).
  final Map<String, dynamic> transacao; 
  //Aqui dentro está o valor, a data e o tipo que vieram da outra tela.
  final String ticker; // Armazena o código da empresa recebido.

  const TransactionDetailsScreen({ // Construtor da tela de comprovante.
    super.key, // Chave padrão, boa pratica,O super.key está apenas passando o "crachá" 
    //de identificação para o Flutter gerenciar a tela internamente.
    required this.transacao, // Transação obrigatória.
    required this.ticker, // Ticker obrigatório.
  }); // Fim do construtor.

  // ESTA FUNÇÃO É RESPONSÁVEL POR CONSTRUIR A INTERFACE VISUAL DO COMPROVANTE DE TRANSAÇÃO, EXIBINDO VALORES, DATA E STATUS.
  @override // Indica que estamos substituindo o método original de construção.
  Widget build(BuildContext context) { // Início da construção do layout da tela de comprovante.
    return Scaffold( // Estrutura da página.
      backgroundColor: Colors.white, // Fundo branco.
      appBar: AppBar( // Barra superior.
        leading: IconButton( // Botão de voltar.
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Seta preta.
          onPressed: () => Navigator.pop(context), // Volta para a tela anterior.
        ), // Fim do ícone.
        title: const Text("Detalhes", style: TextStyle(color: Colors.black)), // Título fixo "Detalhes" em preto.
        backgroundColor: Colors.white, // Barra branca.
        elevation: 0, // Sem sombra.
      ), // Fim da barra superior.
      body: Padding( // Adiciona margens ao conteúdo central.
        padding: const EdgeInsets.all(24.0), // 24 pixels de margem em todos os lados.
        child: Column( // Organiza as informações em coluna vertical.
          children: [ // Filhos da tela de comprovante.
            const SizedBox(height: 20), // Espaço de 20 pixels no topo.
            Text( // Exibe o valor da transação em destaque.
              "${transacao['valor']} $ticker", // Texto formatado (ex: "+10 AGRI3").
              style: const TextStyle( // Estilo grande.
                fontSize: 32, // Tamanho 32.
                fontWeight: FontWeight.bold, // Negrito.
                color: Color(0xFF512DA8), // Cor roxa escura.
              ), // Fim do estilo.
            ), // Fim do texto do valor.
            const Text( // Exibe o valor aproximado em Reais.
              "R\$ 2.102,34", // Valor financeiro simulado da transação.
              style: TextStyle(color: Colors.grey), // Cor cinza discreta.
            ), // Fim do texto.
            const SizedBox(height: 40), // Espaço de 40 pixels.
            Container( // Caixa cinza que contém os dados técnicos da operação.
              padding: const EdgeInsets.all(20), // Margem interna de 20 pixels.
              decoration: BoxDecoration( // Estilo da caixa de dados.
                color: const Color(0xFFF8F9FB), // Fundo cinza bem clarinho.
                borderRadius: BorderRadius.circular(20), // Cantos bem arredondados raio 20.
              ), // Fim da decoração.
              child: Column( // Organiza as linhas de detalhe em coluna.
                children: [ // Lista de linhas informativas.
                //builddetailrow é uma função auxiliar que cria cada linha de detalhe.
                //Ela recebe um rótulo (label) e um valor (value) e retorna uma linha de texto.
                  _buildDetailRow("Data", "May 05, 01:07 PM"), // Linha que mostra a data da operação.
                  _buildDetailRow("Status", "Sucesso", isStatus: true), // Linha que mostra o status (verde).
                  _buildDetailRow("Hash", "0x56bc...d82f"), // Linha que mostra o código técnico da transação.
                  _buildDetailRow("Taxa", "0.001 ETH"), // Linha que mostra a taxa paga.
                ], // Fim das linhas de detalhe.
              ), // Fim da coluna interna.
            ), // Fim do Container cinza.
            ], // Fim dos filhos do comprovante.
          ), // Fim da coluna principal.
      ), // Fim do preenchimento central.
    ); // Fim do Scaffold.
  } // Fim do método build do comprovante.

  // ESTA FUNÇÃO AUXILIAR CRIA CADA UMA DAS LINHAS DE INFORMAÇÃO NO COMPROVANTE (EX: DATA, STATUS), ALINHANDO RÓTULO E VALOR.
  Widget _buildDetailRow(String label, String value, {bool isStatus = false}) { 
    /**Com Map: A função teria que saber que a data está na chave ['data'] e o hash 
    na chave ['hash']. Se amanhã você quiser usar essa mesma função para mostrar o
     perfil de um usuário (que não tem nada a ver com transação), a função não serviria.
Com Strings: A função não quer saber de onde o dado veio. Ela só diz: "Me dê um texto 
para a esquerda e um para a direita que
 eu os desenho lindamente". Você pode usar ela para qualquer coisa! */
    return Padding( // Adiciona margem vertical para separar as linhas.
      padding: const EdgeInsets.symmetric(vertical: 12), // 12 pixels de espaço vertical.
      child: Row( // Organiza o rótulo e o valor em uma linha horizontal.
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Empurra cada um para um lado oposto.
        children: [ // Filhos da linha.
          Text(label, style: const TextStyle(color: Colors.grey)), // Texto do rótulo (ex: "Data") em cinza.
          Text( // Texto do valor (ex: "May 05...").
            value, // Conteúdo dinâmico.
            style: TextStyle( // Estilo do valor.
              fontWeight: FontWeight.bold, // Sempre em negrito.
              color: isStatus ? Colors.green : Colors.black, // Se for status, fica verde; senão, preto.
            ), // Fim do estilo.
          ), // Fim do texto do valor.
        ], // Fim dos filhos da linha.
      ), // Fim da linha.
    ); // Fim do Padding.
  } // Fim da função auxiliar _buildDetailRow.
} // Fim da classe do comprovante.
