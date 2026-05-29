import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../transaction_details_screen.dart';

class TransactionHistoryWidget extends StatefulWidget {
  //transactionhistorywidget é uma classe que representa o widget de histórico de transações.
  //aqui estamos configurando o widget de histórico de transações.
  final String ticker;
  //O Ticker é o apelido da ação ou startup na bolsa (ex: AGRI3).
  final List<Map<String, dynamic>> history;
  //isto é uma lista de mapas, 
  /**Isso aqui é uma Lista de Mapas.
O que tem dentro? Imagine uma lista de papéis, onde cada papel é um "Mapa" contendo:
tipo: "Compra"
quantidade: 50
data: 20/05/2024 */

  const TransactionHistoryWidget({
    super.key,
    required this.ticker,
    required this.history,
  });
  //Aqui você recebe a lista inicial de transações do histórico de transações.

  @override
  State<TransactionHistoryWidget> createState() => _TransactionHistoryWidgetState();
  //o arroz = Quando alguém rodar essa função, devolva (retorne) imediatamente uma nova instância 
  //da classe _TransactionHistoryWidgetState"
}

class _TransactionHistoryWidgetState extends State<TransactionHistoryWidget> {
  bool _verTodos = false;
  //começa c false pois por padrão, não queremos exibir todas as transações.

  String _getStartupId(String ticker) {
    //getstartupid e uma funcao que retorna o id da startup a partir do ticker.
    //ex: AGRI3 -> agrisense
    //ex: DEVM3 -> devmatch
    //ex: ECYC1 -> ecocycle
    //ex: HBIT3 -> healthbit
    //ex: SCMP3 -> smartcampus
    switch (ticker) {
      case 'AGRI3': return 'agrisense';
      case 'DEVM3': return 'devmatch';
      case 'ECYC1': return 'ecocycle';
      case 'HBIT3': return 'healthbit';
      case 'SCMP3': return 'smartcampus';
      default: return 'agrisense';
    }
  }

  @override
  Widget build(BuildContext context) {
    //aqui serve para construir o widget de histórico de transações.
    final uid = FirebaseAuth.instance.currentUser?.uid;
    //uid é o usuário atual logado.
    final startupId = _getStartupId(widget.ticker);
    //startupid é o id da startup a partir do ticker.
    //Como você está dentro da classe _TransactionHistoryWidgetState (o Estado), 
    //para acessar uma variável que foi definida 
    //lá na classe de cima (TransactionHistoryWidget), você precisa usar o prefixo widget..

    return Padding(
      //paddingqui estamos configurando o padding do widget de histórico de transações.
      padding: const EdgeInsets.symmetric(horizontal: 20),
      //child: é o conteúdo do widget de histórico de transações.
      child: Column(
        //crossaxisalignment: CrossAxisAlignment.start, significa que os widgets serão alinhados à esquerda.
        crossAxisAlignment: CrossAxisAlignment.start,
        //children: são os widgets que estão dentro do widget de histórico de transações.
        children: [
          //isto é o título do histórico de transações.
          const Text(
            "Histórico",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          //isto é a lista de transações do histórico de transações.
          StreamBuilder<QuerySnapshot>(
            /**FutureBuilder: Busca o dado uma vez (como tirar uma foto). 
            Se o dado mudar no banco, a tela não mexe.
              StreamBuilder: Abre um canal ao vivo (como uma chamada de vídeo). 
             Se você comprar uma ação agora, a lista atualiza na hora na sua mão.
             Snapshot significa "foto do momento".
             Query significa "consulta" */
            stream: FirebaseFirestore.instance
                .collection('startups')
                //Você está dizendo: "Vá para a área onde ficam guardados todos os dados das empresas (startups)".
                .doc(startupId)
                //Nesta seção de startups, pegue apenas a prateleira da AgriSense"
                .collection('Histórico')
                //É uma Subcoleção. Imagine que dentro da prateleira da AgriSense 
                //existe uma pasta específica só para as transações.
                .where('uid', isEqualTo: uid)
                //isequal to é necessario pois tem vários usuários no banco de dados.
                //Isso impede que você veja as compras de outros usuários.
                //Desta pasta cheia de papéis, me mostre apenas os que pertencem à Camila". 
                //Isso impede que você veja as compras de outros usuários
                .orderBy('data', descending: true)
                /**data': O campo que diz quando a compra foi feita.
               descending: true: Significa "Ordem Decrescente".
              Ação: "Coloque os papéis em ordem de data, deixando a transação mais
               recente no topo */
                .snapshots(),
                //"Não apenas me entregue esses papéis agora, mas fique vigiando. Se alguém adicionar um papel
                // novo ou mudar algo, me mande uma foto nova imediatamente
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
               //Se a conexão está em espera, retorna um CircularProgressIndicator.
                return const Center(child: CircularProgressIndicator());
              }

              final docs = snapshot.data?.docs ?? [];
              //aqaui nao ha operador ternario, mas sim dois null-safety
              //?. vez de ser um "se/então", ele é um "acesse se não for nulo".
              //SE fosse ternario: final docs = snapshot.data != null ? snapshot.data!.docs : [];
              //se nao ha um documento, retorna um texto dizendo que não há transações.

              if (docs.isEmpty) {
                //final docs = snapshot.data != null ? snapshot.data!.docs : [];
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Nenhuma transação encontrada.',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                );
              }

              final exibir = _verTodos ? docs : docs.take(2).toList();
             //nos inicializamos o vertodos como false pois por padrão,
             // não queremos exibir todas as transações.
             /**Se _verTodos for true (o usuário clicou no botão "Ver mais"), o Flutter pega a lista docs inteira, 
             com todas as transações que vieram do Firebase, e coloca na variável exibir.
             Se _verTodos for false (estado inicial), o código faz um "corte" na lista:
               .take(2): Ele diz ao Flutter: "Dê todos os papéis que você tem, mas eu só quero os 2 primeiros".
             .toList(): Como o take devolve um formato especial (Iterable), precisamos transformar de volta 
             em uma List para o Flutter conseguir desenhar na tela. */

              return Column(
                //isto: são os widgets que estão dentro do widget de histórico de transações.
                children: [
                  ...exibir.map((doc) {
                    //O .map faz exatamente isso: ele percorre a lista exibir e, 
                    //para cada item lá dentro, ele "fabrica" um Widget.
                    //doc é o apelido que demos para oq o MAP esta acessando naquele segundo
                    //para cada chamada do doc, executa o que esta dentro 
                    final data = doc.data() as Map<String, dynamic>;
                    /**O doc (que veio do Firebase) é um objeto complexo.
                     Quando você chama .data(), você está extraindo apenas os campos de texto e números (os dados puros).
                     O as Map<String, dynamic> é um aviso para o Flutter: "Ei, trate isso aqui como 
                     um mapa onde as chaves são nomes (Strings) e os valores podem ser 
                       qualquer coisa (dynamic)". Isso permite que você acesse data['valor'] depois. */
                    return _buildTransactionTile(data);
                    //Você entrega o "ingrediente" (data) 
                    //e essa função devolve o "prato pronto" (o Widget da linha do histórico).
                  }),
                  if (docs.length > 2)
                  //Se tem mais de 2 transações, exibe o botão "Ver mais".
                  //Se tem 2 ou menos transações, não exibe o botão.
                    TextButton(
                      onPressed: () => setState(() => _verTodos = !_verTodos),
                      child: Text(
                        _verTodos ? 'Ver menos' : 'Ver mais',
                        /**_verTodos é true? Então a lista já está toda aberta.
                         O que o usuário quer fazer agora? "Ver menos" (fechar).
                        _verTodos é false? Então a lista está escondida (mostrando só 2). 
                        O que o usuário quer fazer agora? "Ver mais" (abrir). */
                        style: const TextStyle(color: Color(0xFF512DA8)),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(Map<String, dynamic> item) {
    //O Firebase guarda os dados em formato JSON (Chave e Valor). 
    //Quando você busca esses dados, o Flutter os transforma em um Map.
    //String: Representa a "Chave" (o nome do campo, como 'tipo', 'valor', 'data').
    //dynamic: Representa o "Valor". Como o valor pode ser um texto, um número ou uma data, usamos dynamic porque ele aceita qualquer tipo.
    
    final tipo = item['tipo'] ?? 'Compra';
    /**O ?? 'Compra' diz o seguinte: "Vá no banco e pegue o tipo. Se o campo estiver lá,
     use o que estiver escrito (seja 'Compra', 'Venda', 'Troca').
     Se o campo estiver vazio ou der erro, por segurança, finja que foi uma 'Compra'". */
    final isCompra = tipo == 'Compra';
    /**O valor da variável tipo é exatamente igual ao texto 'Compra'?
    SIM (true): O isCompra vira verdadeiro. O app vai pintar de Verde e botar o Carrinho.
    NÃO (false): O isCompra vira falso. O app entende que é qualquer outra coisa
    (como uma 'Venda') e pinta de Vermelho com o ícone de Etiqueta. */
    final color = isCompra ? Colors.green : Colors.red;
    final icon = isCompra ? Icons.shopping_cart : Icons.sell;
    //Se for uma compra, o ícone é o Carrinho.
    //Se for uma venda, o ícone é a Etiqueta.

    final dataFormatada = item['data'] != null
    //Se a data não for nula, formata a data para exibir na tela.
    //Se a data for nula, não exibe nada.
        ? DateFormat('MMM dd, hh:mm a').format((item['data'] as Timestamp).toDate())
        /**O as Timestamp: É um "Type Cast". Você está garantindo ao Dart: 
        "Olha, eu sei que esse dado que veio do Map é um objeto 
        Timestamp do Firebase, pode tratar ele como tal".
O Timestamp do Firebase é ótimo para o banco de dados, mas o Dart (a linguagem do Flutter) 
tem seu próprio jeito de lidar com datas, que é o objeto DateTime.
Ação: Esse comando converte o formato do Firebase para o formato padrão do Dart.
 Agora o dado virou uma "data de verdade" para o sistema. */
        //
        : '';

    return ListTile(
      //Quando o usuário tocar na linha, ele vai para a tela de detalhes da transação.
      onTap: () {
        //
        Navigator.push(
          //
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailsScreen(
              //aqui passa os valores pra tela de details, caso o usario decida trocar de
              //tela para ver os DETALHES 
              transacao: {
                //É AQUI NESSE TRANSACAO QUE FAZEMOS A PASSAGEM PRA DETAILSCREENS
                ...item,
                'valor': item['Tokens Comprados'] ?? item['Tokens Vendidos'] ?? 0,
                //Se for uma compra, o valor é o número de Tokens Comprados.
                //Se for uma venda, o valor é o número de Tokens Vendidos.
                //Se for uma troca, o valor é 0.
                //
              },
              ticker: widget.ticker,
              /**"Ei, vá lá na minha classe 'mãe' e pegue o valor do ticker (ex: AgriSense)
               que foi passado quando esse componente foi criado."
Sem o widget., o seu código não saberia de qual startup estamos falando, 
porque essa informação geralmente chega pelo construtor da tela */
              //
            ),
          ),
        );
      },
      //aqui pra baixo é a parte do ListTile que exibe as informações da transação.
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 18),
      ),
      title: Text(
        tipo,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Text(
        dataFormatada,
        style: const TextStyle(fontSize: 11, color: Colors.grey),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            //aqui escreve superficialmente os detalhes caso o usuario n troque de tela 
            "${item['Tokens Comprados'] ?? item['Tokens Vendidos'] ?? 0}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            widget.ticker,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
