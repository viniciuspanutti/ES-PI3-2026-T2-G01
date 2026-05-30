import 'package:flutter/material.dart'; // Biblioteca base do Flutter (permite usar widgets como Padding, Column, ChoiceChip).
import 'package:fl_chart/fl_chart.dart'; // Biblioteca de gráficos (permite usar LineChart, FlSpot).
import 'package:cloud_firestore/cloud_firestore.dart'; // Biblioteca do Banco de Dados (permite usar FirebaseFirestore, collection).
import 'package:intl/intl.dart'; // Biblioteca de Formatação (permite usar DateFormat para arrumar datas).

// ESTA CLASSE DEFINE O COMPONENTE VISUAL DO GRÁFICO DE VARIAÇÃO DE PREÇO DO ATIVO.
class AssetChartWidget extends StatefulWidget { // Widget com estado para gerenciar o período selecionado.
  final String startupId; // ID da startup no banco de dados.
  final String ticker; // Código da bolsa da startup.

  const AssetChartWidget({ // Construtor do widget do gráfico.
    super.key, // Chave padrão.
    required this.startupId, // ID obrigatório.
    required this.ticker, // Ticker obrigatório.
  }); // Fim do construtor.

  @override // Indica sobrescrita.
  State<AssetChartWidget> createState() => _AssetChartWidgetState(); // Cria o estado do gráfico.
} // Fim da classe.

class _AssetChartWidgetState extends State<AssetChartWidget> { // Classe de estado do gráfico.
  String _selectedPeriod = 'Diário'; // Período padrão inicial.

  // ESTA FUNÇÃO CONSTRÓI A SEÇÃO QUE EXIBE O GRÁFICO DE VARIAÇÃO DE PREÇO, INCLUINDO OS BOTÕES DE PERÍODO (DIA, SEMANA, ETC).
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
          // ESTA FUNÇÃO BUSCA O HISTÓRICO DE PREÇOS NO FIREBASE E RECONSTRÓI O GRÁFICO SEMPRE QUE HÁ NOVIDADES.
          StreamBuilder<QuerySnapshot>( // Widget que carrega os pontos do gráfico do banco de dados ao vivo.
            stream: FirebaseFirestore.instance // Pega o Firestore.
                .collection('exchange') // Pasta de mercado.
                .doc(widget.startupId) // Documento da empresa atual.
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

              final now = DateTime.now(); // Pega a data e hora de agora.
              DateTime dataLimite; // Cria variável para saber até onde o gráfico volta no tempo.

              switch (_selectedPeriod) { // Define a data limite baseada no botão clicado.
                case 'Diário': // Se escolheu Diário.
                  dataLimite = now.subtract(const Duration(days: 7)); // Mostra os últimos 7 dias.
                  break;
                case 'Semanal':
                  dataLimite = now.subtract(const Duration(days: 84));
                  break;
                case 'Mensal':
                  dataLimite = now.subtract(const Duration(days: 30));
                  break;
                case '6 meses':
                  dataLimite = now.subtract(const Duration(days: 180));
                  break;
                case 'YTD':
                  dataLimite = DateTime(now.year, 1, 1);
                  break;
                default:
                  dataLimite = now.subtract(const Duration(days: 7));
              }

              final filteredDocs = docs.where((doc) {
                final data = doc['data'] as Timestamp;
                return data.toDate().isAfter(dataLimite) || data.toDate().isAtSameMomentAs(dataLimite);
              }).toList();

              List<QueryDocumentSnapshot> finalDocs = filteredDocs;
              if (_selectedPeriod == 'Semanal') {
                finalDocs = [];
                for (int i = 0; i < filteredDocs.length; i += 7) {
                  finalDocs.add(filteredDocs[i]);
                }
                if (finalDocs.isNotEmpty && filteredDocs.isNotEmpty && finalDocs.last.id != filteredDocs.last.id) {
                  finalDocs.add(filteredDocs.last);
                }
              }

              final spots = finalDocs.map((doc) {
                final data = (doc['data'] as Timestamp).toDate();
                final preco = (doc['preco'] as num).toDouble();
                return FlSpot(data.millisecondsSinceEpoch.toDouble(), preco);
              }).toList();

              if (spots.isEmpty) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: Text("Sem dados para o período")),
                );
              }

              final precos = spots.map((s) => s.y).toList();
              final precoMin = precos.reduce((a, b) => a < b ? a : b);
              final precoMax = precos.reduce((a, b) => a > b ? a : b);
              final margemY = (precoMax - precoMin) * 0.05;
              final double chartMinY = (precoMin - margemY).clamp(0, double.infinity);
              final double chartMaxY = precoMax + margemY;

              final double chartMinX = spots.first.x;
              final double chartMaxX = spots.last.x;

              return SizedBox(
                height: 220,
                child: LineChart(
                  LineChartData(
                    minX: chartMinX,
                    maxX: chartMaxX,
                    minY: chartMinY,
                    maxY: chartMaxY,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      drawHorizontalLine: true,
                      horizontalInterval: (chartMaxY - chartMinY) / 4,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.grey.withOpacity(0.15),
                        strokeWidth: 0.5,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval: (chartMaxX - chartMinX) / 4,
                          getTitlesWidget: (value, meta) {
                            if (value == meta.min || value == meta.max) {
                              return const SizedBox.shrink();
                            }
                            final dt = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                            String label;
                            if (_selectedPeriod == 'Diário') {
                              label = DateFormat('HH:mm').format(dt);
                            } else if (_selectedPeriod == '6 meses' || _selectedPeriod == 'YTD') {
                              label = DateFormat('MMM').format(dt);
                            } else {
                              label = DateFormat('dd/MM').format(dt);
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                label,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 45,
                          interval: (chartMaxY - chartMinY) / 4,
                          getTitlesWidget: (value, meta) {
                            if (value == meta.min || value == meta.max) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Text(
                                'R\$${value.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        color: const Color(0xFF512DA8),
                        barWidth: 3,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: const Color(0xFF512DA8).withOpacity(0.1),
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
}
