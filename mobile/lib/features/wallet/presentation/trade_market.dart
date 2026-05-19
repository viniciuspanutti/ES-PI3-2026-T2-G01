// feito por camila fernandes costacurta RA:25012949

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/wallet/presentation/token.dart' as token_page;

class BalcaoNegociacaoPage extends StatefulWidget {
  const BalcaoNegociacaoPage({super.key});

  @override
  State<BalcaoNegociacaoPage> createState() => _BalcaoNegociacaoPageState();
}

class _BalcaoNegociacaoPageState extends State<BalcaoNegociacaoPage> {
  String _filtroSelecionado = 'Todas';

  final List<Map<String, dynamic>> _startups = [
    {
      'nome': 'AgriSense',
      'ticker': 'AGRI3',
      'logo': 'assets/images/logos/logotipoAgriSense.png',
      'preco': 1.75,
      'valorizacao': '+10.0%',
      'qtd': 500,
      'setor': 'Agronegócio',
    },
    {
      'nome': 'DevMatch',
      'ticker': 'DEVM3',
      'logo': 'assets/images/logos/logotipoDevMatch.png',
      'preco': 1.20,
      'valorizacao': '+5.4%',
      'qtd': 1200,
      'setor': 'Tecnologia',
    },
    {
      'nome': 'EcoCycle',
      'ticker': 'ECYC1',
      'logo': 'assets/images/logos/logotipoEcoCycle.png',
      'preco': 0.50,
      'valorizacao': '+12.1%',
      'qtd': 3000,
      'setor': 'Sustentabilidade',
    },
    {
      'nome': 'HealthBit',
      'ticker': 'HBIT3',
      'logo': 'assets/images/logos/logotipoHealthBit.png',
      'preco': 2.10,
      'valorizacao': '+8.2%',
      'qtd': 850,
      'setor': 'Saúde',
    },
    {
      'nome': 'SmartCampus',
      'ticker': 'SCMP3',
      'logo': 'assets/images/logos/logotipoSmartCampus.png',
      'preco': 0.95,
      'valorizacao': '+3.5%',
      'qtd': 1500,
      'setor': 'Educação',
    },
  ];
  /// Usando o Filtro de Catálogo que faltou de implementar

  void _abrirFiltros() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Filtrar por Setor",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                    [
                      'Todas',
                      'Agronegócio',
                      'Tecnologia',
                      'Sustentabilidade',
                      'Saúde',
                      'Educação',
                    ].map((label) {
                      final bool isSelected = _filtroSelecionado == label;
                      return ChoiceChip(
                        label: Text(label),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _filtroSelecionado = label;
                          });
                          Navigator.pop(context);
                        },
                        selectedColor: const Color(0xFF512DA8),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fechar", style: TextStyle(color: Colors.grey)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Aplica o filtro sobre a lista
    final listaFiltrada = _filtroSelecionado == 'Todas'
        ? _startups
        : _startups.where((s) => s['setor'] == _filtroSelecionado).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'BALCÃO DE NEGOCIAÇÕES',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.black),
            onPressed: _abrirFiltros,
          ),
        ],
      ),
      body: Column(
        children: [
          if (_filtroSelecionado != 'Todas')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Text(
                    "Filtrado por: ",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  Chip(
                    label: Text(
                      _filtroSelecionado,
                      style: const TextStyle(fontSize: 10),
                    ),
                    onDeleted: () =>
                        setState(() => _filtroSelecionado = 'Todas'),
                  ),
                ],
              ),
            ),
          Expanded(
            child: listaFiltrada.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Nenhuma startup encontrada\nneste setor.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: listaFiltrada.length,
                    itemBuilder: (context, index) {
                      final startup = listaFiltrada[index];
                      final double total = startup['preco'] * startup['qtd'];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AssetDetailsScreen(startup: startup),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        startup['logo'],
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                                  Icons.business,
                                                  color: Colors.grey,
                                                ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          startup['ticker'],
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          startup['nome'],
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'R\$ ${startup['preco'].toStringAsFixed(2)}',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        startup['valorizacao'],
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Qtd: ${startup['qtd']}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    'Total: R\$ ${total.toStringAsFixed(2)}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF512DA8),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class AssetDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> startup;
  const AssetDetailsScreen({super.key, required this.startup});

  @override
  State<AssetDetailsScreen> createState() => _AssetDetailsScreenState();
}

class _AssetDetailsScreenState extends State<AssetDetailsScreen> {
  String _selectedPeriod = 'Diário';
  final TextEditingController _quantidadeController = TextEditingController();
  bool _isLoading = false;

  // --- ESTRUTURA PARA O BACKEND ---
  // Seu amigo vai substituir essas listas estáticas por dados do Firebase/API
  final List<Map<String, dynamic>> _historicoFake = [
    {
      "titulo": "Compra",
      "sub": "Via Balcão",
      "valor": "+10",
      "icon": Icons.shopping_cart,
    },
    {
      "titulo": "Troca",
      "sub": "Conversão Simulada",
      "valor": "-5",
      "icon": Icons.swap_horiz,
    },
  ];

  @override
  void dispose() {
    _quantidadeController.dispose();
    super.dispose();
  }

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

  // Integração real com a Cloud Function exchange-buyTokens (AMM)
  void _abrirModalInvestir() {
    _quantidadeController.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (builderContext, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Investir em ${widget.startup['ticker']}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _quantidadeController,
                      decoration: InputDecoration(
                        labelText: "Quantidade de Tokens",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.add_chart),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF512DA8),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: _isLoading
                            ? null
                            : () async {
                                final quantidadeTexto = _quantidadeController.text.replaceAll(',', '.');
                                final quantidade = int.tryParse(quantidadeTexto) ?? 0;

                                if (quantidade <= 0) {
                                  ScaffoldMessenger.of(builderContext).showSnackBar(
                                    const SnackBar(
                                      content: Text('Informe uma quantidade válida (número inteiro > 0).'),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                  return;
                                }

                                setModalState(() => _isLoading = true);

                                try {
                                  final startupId = _getStartupId(widget.startup['ticker']);
                                  final callable = FirebaseFunctions.instance
                                      .httpsCallable('exchange-buyTokens');
                                  await callable.call({
                                    'startupId': startupId,
                                    'quantidade': quantidade,
                                  });

                                  if (!mounted) return;
                                  Navigator.pop(builderContext);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Ordem de compra executada com sucesso!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } on FirebaseFunctionsException catch (e) {
                                  setModalState(() => _isLoading = false);
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(builderContext).showSnackBar(
                                    SnackBar(
                                      content: Text(e.message ?? e.details?.toString() ?? 'Erro na transação.'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } catch (e) {
                                  setModalState(() => _isLoading = false);
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(builderContext).showSnackBar(
                                    SnackBar(
                                      content: Text('Erro inesperado: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                "Confirmar Compra",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _abrirModalTroca() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permite que o modal suba com o teclado
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(
            context,
          ).viewInsets.bottom, // Ajusta para o teclado
          top: 24,
          left: 24,
          right: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Troca Rápida (Swap)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Converta seus ativos instantaneamente.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Campo "DE"
            _buildSwapField(
              label: "De",
              ticker: widget.startup['ticker'],
              value: "10.0",
            ),

            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Icon(Icons.arrow_downward, color: Color(0xFF512DA8)),
              ),
            ),

            // Campo "PARA"
            _buildSwapField(label: "Para", ticker: "REAIS", value: "200.00"),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF512DA8),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Troca realizada com sucesso!"),
                    ),
                  );
                },
                child: const Text(
                  "Confirmar Conversão",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para os campos de troca
  Widget _buildSwapField({
    required String label,
    required String ticker,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              ticker,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.startup['nome'],
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Valor grande do Token
            Text(
              "${widget.startup['qtd']} ${widget.startup['ticker']}",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF512DA8),
              ),
            ),
            const SizedBox(height: 30),

            // 1. Botões com Funções Implementadas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(
                  Icons.auto_graph,
                  "Investir",
                  _abrirModalInvestir,
                ),
                const SizedBox(width: 40),
                _buildActionButton(
                  Icons.swap_horiz,
                  "Trocar",
                  _abrirModalTroca,
                ),
              ],
            ),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const token_page.ValorizacaoPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.insights, color: Colors.white),
                label: const Text(
                  "Ver Performance Detalhada",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF512DA8),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 2. Dashboard preparado para novos valores
            _buildDashboard(),

            const SizedBox(height: 30),

            // 3. Livro de Ofertas (Mantive sua estrutura de Table)
            _buildOrderBook(),

            const SizedBox(height: 30),

            // 4. Histórico Dinâmico (Fácil para o Backend mudar)
            _buildDynamicHistory(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget de Dashboard (Gráfico + Seletor)
  Widget _buildDashboard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Variação do Ativo",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Diário', 'Semanal', 'Mensal', '6 meses', 'YTD'].map((
                periodo,
              ) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      periodo,
                      style: TextStyle(
                        fontSize: 12,
                        color: _selectedPeriod == periodo
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    selected: _selectedPeriod == periodo,
                    selectedColor: const Color(0xFF512DA8),
                    onSelected: (selected) {
                      setState(() => _selectedPeriod = periodo);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('exchange')
                .doc(_getStartupId(widget.startup['ticker']))
                .collection('historicoPrecos')
                .orderBy('data', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasError) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: Text("Erro ao carregar gráfico")),
                );
              }

              final docs = snapshot.data?.docs ?? [];
              if (docs.isEmpty) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: Text("Sem dados históricos")),
                );
              }

              final now = DateTime.now();
              DateTime dataLimite;

              switch (_selectedPeriod) {
                case 'Diário':
                  dataLimite = now.subtract(const Duration(days: 7));
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

              final spots = finalDocs.asMap().entries.map((entry) {
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

  // Livro de Ofertas conforme solicitado
  Widget _buildOrderBook() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Livro de Ofertas (Mercado)",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF4B0082),
            ),
          ),
          const SizedBox(height: 15),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                children: [
                  _tableHeader("Tipo"),
                  _tableHeader("Qtd (BYD)"),
                  _tableHeader("Preço (R\$)"),
                ],
              ),
              _orderRow("Venda", "50", "6.15", Colors.red),
              _orderRow("Venda", "120", "6.12", Colors.red),
              _orderRow("Compra", "80", "6.08", Colors.green),
              _orderRow("Compra", "200", "6.05", Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  // Widget de Histórico que usa a lista _historicoFake
  Widget _buildDynamicHistory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hoje",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          // Passando o item completo do Map para a função
          ..._historicoFake.map((item) => _buildTransactionTile(item)),
        ],
      ),
    );
  }



  Widget _tableHeader(String label) => Padding(
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

  TableRow _orderRow(String tipo, String qtd, String preco, Color color) {
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

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[100],
            child: Icon(icon, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(Map<String, dynamic> item) {
    // Mudei para receber o Map inteiro
    return ListTile(
      onTap: () {
        // Aqui acontece a mágica: navega para a tela de detalhes
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailsScreen(
              transacao: item,
              ticker: widget.startup['ticker'],
            ),
          ),
        );
      },
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(item['icon'], color: Colors.green, size: 18),
      ),
      title: Text(
        item['titulo'],
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Text(
        item['sub'],
        style: const TextStyle(fontSize: 11, color: Colors.grey),
      ),
      trailing: Row(
        mainAxisSize:
            MainAxisSize.min, // Garante que a Row não ocupe a tela toda
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline
            .alphabetic, // Alinha os textos pela base (linha de escrita)
        children: [
          Text(
            "${item['valor']}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16, // Valor um pouco maior
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 4), // Espacinho entre o número e o ticker
          Text(
            "${widget.startup['ticker']}",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12, // Ticker menor
              color: Colors.grey, // Cor diferente para separar visualmente
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> transacao;
  final String ticker;

  const TransactionDetailsScreen({
    super.key,
    required this.transacao,
    required this.ticker,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Detalhes", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "${transacao['valor']} $ticker",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF512DA8),
              ),
            ),
            const Text(
              "R\$ 2.102,34",
              style: TextStyle(color: Colors.grey),
            ), // Valor simulado
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildDetailRow("Data", "May 05, 01:07 PM"),
                  _buildDetailRow("Status", "Sucesso", isStatus: true),
                  _buildDetailRow("Hash", "0x56bc...d82f"),
                  _buildDetailRow("Taxa", "0.001 ETH"),
                ],
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Ver no explorador",
                style: TextStyle(color: Color(0xFF512DA8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isStatus ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
