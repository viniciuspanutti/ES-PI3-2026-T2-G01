// feito por camila fernandes costacurta RA:25012949

import 'package:flutter/material.dart'; // Biblioteca base do Flutter (permite usar widgets como Container, Column, Row).
import 'package:cloud_firestore/cloud_firestore.dart'; // Biblioteca do Banco de Dados (permite usar FirebaseFirestore, snapshots).

/**
 * CLASSE: OrderBookWidget
 * TIPO: StatelessWidget (Widget Fixo/Estático)
 * O QUE FAZ: Exibe o Livro de Ofertas do mercado para uma startup específica.
 * Ele mostra as últimas 4 transações de compra/venda registradas no sistema.
 */
class OrderBookWidget extends StatelessWidget {
  final Map<String, dynamic> startup; // Os dados da startup para buscar o histórico.

  const OrderBookWidget({
    super.key,
    required this.startup,
    //required é um modificador de parametro 
  });

  /**
   * FUNÇÃO: _getStartupId
   * O QUE FAZ: Traduz o Ticker (ex: AGRI3) de volta para o ID do banco de dados (ex: agrisense).
   */
  String _getStartupId(String ticker) {
    // Mapeia o ticker para o ID da startup no Firestore 
    switch (ticker) {
      case 'AGRI3': return 'agrisense'; // AGRI3 mapeia para agrisense. 
      case 'DEVM3': return 'devmatch'; // DEVM3 mapeia para devmatch. 
      case 'ECYC1': return 'ecocycle'; // ECYC1 mapeia para ecocycle. 
      case 'HBIT3': return 'healthbit'; // HBIT3 mapeia para healthbit. 
      case 'SCMP3': return 'smartcampus'; // SCMP3 mapeia para smartcampus. 
      default: return 'agrisense'; // Retorno padrão caso não encontre. 
    } // Fim do switch. 
  }

  /**
   * MÉTODO: build
   * O QUE FAZ: Conecta ao banco de dados em tempo real e desenha uma tabela com as ofertas.
   */
  @override
  Widget build(BuildContext context) {
    //aqui a startupId guarda o nome do ticker que esta no banco de dados 
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Livro de Ofertas (Mercado)",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF4B0082), // Roxo escuro para o título.
            ),
          ),
          const SizedBox(height: 15),
          StreamBuilder<QuerySnapshot>(
            // BUSCA: Ouve as últimas 4 transações na subcoleção 'Histórico' da startup selecionada.
            stream: FirebaseFirestore.instance
                .collection('startups')
                .doc(startup['id'] ?? _getStartupId(startup['ticker']))
                .collection('Histórico')
                .orderBy('data', descending: true)
                //descending é um parametro que define se a ordenação será decrescente ou crescente 
                .limit(4)
                //limit é um parametro que define a quantidade de documentos que serão retornados 
                //nesse caso, 4 
                .snapshots(),
            builder: (context, snapshot) {
              final docs = snapshot.data?.docs ?? [];
              //aqui a docs guarda os documentos que foram retornados pelo Firestore 
              //se data for nulo, ele usa uma lista vazia 
              //se fosse ternario final docs = snapshot.data != null ? snapshot.data!.docs : []; 
              
              // Widget de Tabela para alinhar perfeitamente as colunas.
              return Table(
                //aqui a tabela é criada 
                //a tabela tem 3 colunas 
                //a primeira coluna é o tipo da transação 
                //a segunda coluna é a quantidade de tokens 
                //a terceira coluna é o preço do token 
                //a tabela tem 4 linhas 
                columnWidths: const {
                  0: FlexColumnWidth(1), // Coluna Tipo.
                  1: FlexColumnWidth(1), // Coluna Quantidade.
                  2: FlexColumnWidth(1.2), // Coluna Preço (um pouco mais larga).
                },
                children: [
                  // CABEÇALHO DA TABELA
                  TableRow(
                    children: [
                      _tableHeader("Tipo"),
                      _tableHeader("Qtd"),
                      _tableHeader("Preço (R\$)"),
                    ],
                  ),
                  // MENSAGEM SE NÃO HOUVER DADOS
                  if (docs.isEmpty)
                    const TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Nenhuma transação ainda.',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        SizedBox(),
                        //este sizedbox é usado para separar as colunas 
                        //sem ele, as colunas ficariam muito proximas 
                        //nesse caso, ele é usado para separar as colunas 
                        //para que sejam mais legiveis 
                        SizedBox(),
                      ],
                    )
                  // LISTA DE OFERTAS REAIS
                  else
                    //se docs nao estiver vazio, ele usa o map para criar as linhas da tabela 
                    ...docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      //este map nao e uma ação, é um tipo de objeto, e um conjunto de chave e valor 
                      final tipo = data['tipo'] ?? 'Compra';
                      //aqui a tipo guarda o tipo da transação 
                      //se tipo for nulo, ele usa 'Compra' 
                      //se fosse ternario final tipo = data['tipo'] != null ? data['tipo'] : 'Compra'; 

                      // Verifica se o campo é 'Tokens Vendidos' ou 'Tokens Comprados' dependendo da operação.
                      final qtd = tipo == 'Venda'
                          ? data['Tokens Vendidos']
                          : data['Tokens Comprados'];
                          //aqui a qtd guarda a quantidade de tokens 
                          //se tipo for 'Venda', ele usa o valor de 'Tokens Vendidos' 
                          //se tipo for 'Compra', ele usa o valor de 'Tokens Comprados' 
                          
                      final valor = data['Valor Token'];
                      //aqui a valor guarda o valor do token 
                      
                      return _orderRow(
                        // Chama a função auxiliar que cria e retorna uma linha (TableRow) para a tabela 
                        
                        tipo,
                        // Passa o texto do tipo da transação (ex: 'Compra' ou 'Venda') para a primeira coluna 

                        (qtd ?? 0).toString(),
                        // Pega a quantidade de tokens. Se o valor for nulo (??), usa 0 como padrão. 
                        // Converte o número para String (texto) para ser exibido no widget Text. 

                        (valor as num).toStringAsFixed(2),
                        // Garante que 'valor' seja tratado como número (num) e força a exibição, o tostring exige isso.. 
                        // de exatamente 2 casas decimais (ex: 5.00), ideal para valores monetários. 

                        tipo == 'Venda' ? Colors.red : Colors.green, // Vermelho para venda, Verde para compra.
                        // Usa um operador ternário para decidir a cor: se o tipo for 'Venda', 
                        // envia Vermelho; caso contrário (Compra), envia Verde. 
                      );
                    }),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  /**
   * AUXILIAR: _tableHeader
   * O QUE FAZ: Cria o estilo padrão para as etiquetas do topo da tabela.
   */
  Widget _tableHeader(String label) => Padding(
        //label é o texto que será exibido na tabela 
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  /**
   * AUXILIAR: _orderRow
   * O QUE FAZ: Cria uma linha visual de dados (Tipo, Qtd, Preço) para a tabela.
   */
  TableRow _orderRow(String tipo, String qtd, String preco, Color color) {
    //tipo é o tipo da transação 
    //qtd é a quantidade de tokens 
    //preco é o preço do token 
    //color é a cor da linha 
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            tipo,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(qtd, style: const TextStyle(fontSize: 12)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text("R\$ $preco", style: const TextStyle(fontSize: 12)),
        ),
      ],
    );
  }
}
