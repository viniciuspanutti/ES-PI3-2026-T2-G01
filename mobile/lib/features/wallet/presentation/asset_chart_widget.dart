// feito por camila fernandes costacurta RA:25012949

import 'package:flutter/material.dart'; // Biblioteca base do Flutter (permite usar widgets como Padding, Column, ChoiceChip).
import 'package:fl_chart/fl_chart.dart'; // Biblioteca de gráficos (permite usar LineChart, FlSpot).
import 'package:cloud_firestore/cloud_firestore.dart'; // Biblioteca do Banco de Dados (permite usar FirebaseFirestore, collection).

/**
 * CLASSE: AssetChartWidget
 * TIPO: StatefulWidget (Widget com Estado)
 * O QUE FAZ: Desenha o gráfico de variação de preço de um ativo.
 * Permite selecionar diferentes períodos (Diário, Semanal, Mensal, etc) e atualiza os dados em tempo real.
 */
class AssetChartWidget extends StatefulWidget { // Widget com estado para gerenciar o período selecionado.
  final Map<String, dynamic> startup; // Os dados da startup para buscar o histórico de preços.

  const AssetChartWidget({super.key, required this.startup}); // Construtor do widget do gráfico.

  @override // Indica sobrescrita.
  State<AssetChartWidget> createState() => _AssetChartWidgetState(); // Cria o estado do gráfico.
} // Fim da classe.

class _AssetChartWidgetState extends State<AssetChartWidget> { // Classe de estado do gráfico.
  String _selectedPeriod = 'Diário'; // Período padrão inicial.

  /**
   * FUNÇÃO: _getStartupId
   * O QUE FAZ: Traduz o Ticker para o ID do banco de dados.
   */
  String _getStartupId(String ticker) {
    switch (ticker) {
      case 'AGRI3': return 'agrisense';
      case 'DEVM3': return 'devmatch';
      case 'ECYC1': return 'ecocycle';
      case 'HBIT3': return 'healthbit';
      case 'SCMP3': return 'smartcampus';
      default: return 'agrisense';
    }
  }

  @override // Indica sobrescrita do método de construção.
  Widget build(BuildContext context) { // Início da construção.
    return Padding( // Adiciona margens laterais.
      padding: const EdgeInsets.symmetric(horizontal: 20), // 20 pixels.
      child: Column( // Organiza título, seletores e gráfico em coluna.
        crossAxisAlignment: CrossAxisAlignment.start, // Alinha à esquerda.
        children: [ // Filhos da seção.
          const Text( // Título da seção.
            "Variação do Ativo", // Conteúdo.
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), // Negrito tamanho 16.
          ), // Fim do título.
          const SizedBox(height: 15), // Espaço de 15 pixels.
          // SELETOR DE PERÍODOS
          SingleChildScrollView( // Permite rolar os botões horizontalmente se não couberem na tela.
            scrollDirection: Axis.horizontal, // Rola para os lados.
            child: Row( // Organiza os botões em linha.
              children: ['Diário', 'Semanal', 'Mensal', '6 meses', 'YTD'].map(( // Transforma cada período em um botão.
                periodo, // Variável que representa o período atual no loop.
              ) { // Início do mapeamento.
                return Padding( // Espaço entre botões.
                  padding: const EdgeInsets.only(right: 8), // 8 pixels à direita.
                  child: ChoiceChip( // Botão de escolha arredondado.
                    label: Text( // Texto do período.
                      periodo, // Ex: "Diário".
                      style: TextStyle( // Estilo do texto.
                        fontSize: 12, // Tamanho 12.
                        color: _selectedPeriod == periodo // Se estiver selecionado.
                            ? Colors.white // Texto branco.
                            : Colors.black, // Caso contrário, texto preto.
                      ), // Fim do estilo.
                    ), // Fim do texto.
                    selected: _selectedPeriod == periodo, // Indica se este botão é o selecionado.
                    selectedColor: const Color(0xFF512DA8), // Fundo roxo se selecionado.
                    onSelected: (selected) { // Ação ao clicar.
                      setState(() => _selectedPeriod = periodo); // Atualiza a variável e redesenha a tela.
                    }, // Fim do clique.
                  ), // Fim do ChoiceChip.
                ); // Fim do preenchimento.
              }).toList(), // Converte o mapeamento em lista.
            ), // Fim da linha de botões.
          ), // Fim do rolável horizontal.
          const SizedBox(height: 20), // Espaço de 20 pixels.
          // GRÁFICO DE LINHA EM TEMPO REAL
          StreamBuilder<QuerySnapshot>( // Widget que carrega os pontos do gráfico do banco de dados ao vivo.
            stream: FirebaseFirestore.instance // Pega o Firestore.
                .collection('exchange') // Pasta de mercado.
                .doc(_getStartupId(widget.startup['ticker'])) // Documento da empresa atual.
                .collection('historicoPrecos') // Pasta de preços históricos.
                .orderBy('data', descending: false) // Ordena pela data (do mais antigo ao mais novo).
                .snapshots(), // Abre o canal de dados.
            builder: (context, snapshot) { // Construtor visual do gráfico.
              if (snapshot.connectionState == ConnectionState.waiting) { // Se estiver ainda carregando.
                return const SizedBox( // Caixa temporária.
                  height: 200, // Altura 200.
                  child: Center(child: CircularProgressIndicator()), // Giro de carregamento no centro.
                ); // Fim da caixa.
              } // Fim do check de espera.
              if (snapshot.hasError) { // Se houve algum erro no banco.
                return const SizedBox( // Caixa de erro.
                  height: 200, // Altura 200.
                  child: Center(child: Text("Erro ao carregar gráfico")), // Mensagem de erro.
                ); // Fim da caixa de erro.
              } // Fim do check de erro.

              final docs = snapshot.data?.docs ?? []; // Pega a lista de documentos ou lista vazia.
              if (docs.isEmpty) { // Se não houver nenhum preço salvo ainda.
                return const SizedBox( // Caixa vazia.
                  height: 200, // Altura 200.
                  child: Center(child: Text("Sem dados históricos")), // Mensagem informativa.
                ); // Fim da caixa vazia.
              } // Fim do check de vazio.

              // LÓGICA DE FILTRAGEM POR DATA (Simplificada para o exemplo)
              final now = DateTime.now(); // Pega a data e hora de agora.
              DateTime dataLimite; // Cria variável para saber até onde o gráfico volta no tempo.
              switch (_selectedPeriod) { // Define a data limite baseada no botão clicado.
                case 'Diário': // Se escolheu Diário.
                  dataLimite = now.subtract(const Duration(days: 7)); // Mostra os últimos 7 dias.
                  break;
                case 'Semanal': dataLimite = now.subtract(const Duration(days: 84)); break;
                case 'Mensal': dataLimite = now.subtract(const Duration(days: 30)); break;
                case '6 meses': dataLimite = now.subtract(const Duration(days: 180)); break;
                case 'YTD': dataLimite = DateTime(now.year, 1, 1); break;
                default: dataLimite = now.subtract(const Duration(days: 7));
              }

              final filteredDocs = docs.where((doc) {
                final data = doc['data'] as Timestamp;
                return data.toDate().isAfter(dataLimite) || data.toDate().isAtSameMomentAs(dataLimite);
              }).toList();

              // Converte os documentos do Firestore em pontos (spots) para o gráfico.
              final spots = filteredDocs.asMap().entries.map((entry) {
                final index = entry.key;
                final doc = entry.value;
                final preco = (doc['preco'] as num).toDouble();
                return FlSpot(index.toDouble(), preco);
              }).toList();

              return SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots.isEmpty ? [const FlSpot(0, 0)] : spots,
                        isCurved: true,
                        color: const Color(0xFF512DA8),
                        barWidth: 3,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: const Color(0xFF512DA8).withValues(alpha: 0.1),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
} // Fim do método build.
