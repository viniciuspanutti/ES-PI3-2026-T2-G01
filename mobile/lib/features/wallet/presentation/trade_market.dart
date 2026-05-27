// feito por camila fernandes costacurta RA:25012949

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:intl/intl.dart';

class BalcaoNegociacaoPage extends StatefulWidget {
  const BalcaoNegociacaoPage({super.key});

  @override
  State<BalcaoNegociacaoPage> createState() => _BalcaoNegociacaoPageState();
}

class _BalcaoNegociacaoPageState extends State<BalcaoNegociacaoPage> {
  String _filtroSelecionado = 'Todas';


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
  Widget build(BuildContext context) {    return Scaffold(
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
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('startups').get(),
              builder: (context, startupsSnap) {
                if (!startupsSnap.hasData) return const Center(child: CircularProgressIndicator());

                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('exchange').snapshots(),
                  builder: (context, exchangeSnap) {
                    if (!exchangeSnap.hasData) return const Center(child: CircularProgressIndicator());

                    final userId = FirebaseAuth.instance.currentUser?.uid;
                    final investStream = userId != null
                        ? FirebaseFirestore.instance.collection('users').doc(userId).collection('investimentos').snapshots()
                        : const Stream<QuerySnapshot>.empty();

                    return StreamBuilder<QuerySnapshot>(
                      stream: investStream,
                      builder: (context, investSnap) {
                        final startupsDocs = startupsSnap.data!.docs;
                        final exchangeDocs = exchangeSnap.data!.docs;
                        final investDocs = investSnap.data?.docs ?? [];

                        final List<Map<String, dynamic>> combinedList = [];

                        for (var s in startupsDocs) {
                          final sData = s.data() as Map<String, dynamic>;
                          final ex = exchangeDocs.where((e) => e.id == s.id).firstOrNull?.data() as Map<String, dynamic>?;
                          final inv = investDocs.where((i) => i.id == s.id).firstOrNull?.data() as Map<String, dynamic>?;

                          final preco = ex?['precoAtual'] ?? (sData['currentTokenPriceCents'] ?? 0) / 100.0;
                          final qtd = inv?['tokensComprados'] ?? 0;
                          final double variacao = (ex?['variacao'] ?? 0.0).toDouble();

                          String ticker = s.id.toUpperCase();
                          switch (s.id) {
                            case 'agrisense': ticker = 'AGRI3'; break;
                            case 'devmatch': ticker = 'DEVM3'; break;
                            case 'ecocycle': ticker = 'ECYC1'; break;
                            case 'healthbit': ticker = 'HBIT3'; break;
                            case 'smartcampus': ticker = 'SCMP3'; break;
                          }

                          combinedList.add({
                            'nome': sData['name'] ?? 'Desconhecido',
                            'ticker': ticker,
                            'logo': sData['coverImageUrl'] ?? 'assets/images/logos/logotipoAgriSense.png',
                            'preco': preco.toDouble(),
                            'valorizacao': variacao > 0 ? '+${variacao.toStringAsFixed(1)}%' : '${variacao.toStringAsFixed(1)}%',
                            'qtd': qtd,
                            'setor': sData['tags']?.isNotEmpty == true ? sData['tags'][0] : 'Desconhecido',
                            'id': s.id,
                          });
                        }

                        final listaFiltrada = _filtroSelecionado == 'Todas'
                            ? combinedList
                            : combinedList.where((s) {
                                final setor = (s['setor'] as String).toLowerCase();
                                final filtro = _filtroSelecionado.toLowerCase();
                                // Aproximação de filtro pois os dados do firebase são tags em inglês/outros
                                if (filtro == 'agronegócio' && setor.contains('agro')) return true;
                                if (filtro == 'tecnologia' && setor.contains('tech')) return true;
                                if (filtro == 'sustentabilidade' && (setor.contains('clean') || setor.contains('green'))) return true;
                                if (filtro == 'saúde' && setor.contains('health')) return true;
                                if (filtro == 'educação' && setor.contains('edtech')) return true;
                                return s['setor'] == _filtroSelecionado;
                              }).toList();

                        return listaFiltrada.isEmpty
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
                                                  child: startup['logo'].toString().startsWith('http')
                                                      ? Image.network(
                                                          startup['logo'],
                                                          fit: BoxFit.contain,
                                                          errorBuilder: (context, error, stackTrace) =>
                                                              const Icon(Icons.business, color: Colors.grey),
                                                        )
                                                      : Image.asset(
                                                          'assets/images/logos/${startup['logo']}',
                                                          fit: BoxFit.contain,
                                                          errorBuilder: (context, error, stackTrace) =>
                                                              Image.asset(
                                                                startup['logo'],
                                                                fit: BoxFit.contain,
                                                                errorBuilder: (context, error, stackTrace) =>
                                                                    const Icon(Icons.business, color: Colors.grey),
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
                              );
                      }
                    );
                  }
                );
              }
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
  bool _verTodos = false;

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

  // Integração real com a Cloud Function exchange-sellTokens (AMM)
  void _abrirModalVender() {
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
                      "Vender ${widget.startup['ticker']}",
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
                        prefixIcon: const Icon(Icons.sell),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700],
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
                                      .httpsCallable('exchange-sellTokens');
                                  await callable.call({
                                    'startupId': startupId,
                                    'quantidade': quantidade,
                                  });

                                  if (!mounted) return;
                                  Navigator.pop(builderContext);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Venda realizada com sucesso!'),
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
                                "Confirmar Venda",
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
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseAuth.instance.currentUser != null
                  ? FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('investimentos')
                      .doc(widget.startup['id'] ?? _getStartupId(widget.startup['ticker']))
                      .snapshots()
                  : const Stream.empty(),
              builder: (context, snapshot) {
                final qtdReal = snapshot.data?.data() != null
                    ? (snapshot.data!.data() as Map<String, dynamic>)['tokensComprados'] ?? 0
                    : widget.startup['qtd']; // Fallback

                return Text(
                  "$qtdReal ${widget.startup['ticker']}",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF512DA8),
                  ),
                );
              }
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
                  Icons.sell,
                  "Vender",
                  _abrirModalVender,
                ),
              ],
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

              // 1. Mapeamento Temporal — X = milissegundos do Timestamp
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

              // 2. Cálculo de Escala — Padding de 5% no eixo Y
              final precos = spots.map((s) => s.y).toList();
              final precoMin = precos.reduce((a, b) => a < b ? a : b);
              final precoMax = precos.reduce((a, b) => a > b ? a : b);
              final margemY = (precoMax - precoMin) * 0.05;
              final double chartMinY = (precoMin - margemY).clamp(0, double.infinity);
              final double chartMaxY = precoMax + margemY;

              // Limites do eixo X a partir dos dados reais
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

                    // 5. Grid Visual Limpo — apenas linhas horizontais
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      drawHorizontalLine: true,
                      horizontalInterval: (chartMaxY - chartMinY) / 4,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.grey.withValues(alpha: 0.15),
                        strokeWidth: 0.5,
                      ),
                    ),

                    // 3 & 4. Eixos X (bottom) e Y (left) dinâmicos
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

                      // Eixo X — Formatação contextual por _selectedPeriod
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval: (chartMaxX - chartMinX) / 4,
                          getTitlesWidget: (value, meta) {
                            // Evitar rótulos nas bordas extremas que cortam
                            if (value == meta.min || value == meta.max) {
                              return const SizedBox.shrink();
                            }
                            final dt = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                            String label;
                            if (_selectedPeriod == 'Diário') {
                              // Hora:minuto para a janela mais curta
                              label = DateFormat('HH:mm').format(dt);
                            } else if (_selectedPeriod == '6 meses' || _selectedPeriod == 'YTD') {
                              // Mês abreviado para janelas longas
                              label = DateFormat('MMM', 'pt_BR').format(dt);
                            } else {
                              // dia/mês para janelas intermediárias (Semanal, Mensal)
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

                      // Eixo Y — Preço formatado em R$
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
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('startups')
              .doc(widget.startup['id'] ?? _getStartupId(widget.startup['ticker']))
              .collection('Histórico')
              .orderBy('data', descending: true)
              .limit(4)
              .snapshots(),
          builder: (context, snapshot) {
            final docs = snapshot.data?.docs ?? [];
            return Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: [
                    _tableHeader("Tipo"),
                    _tableHeader("Qtd"),
                    _tableHeader("Preço (R\$)"),
                  ],
                ),
                if (docs.isEmpty)
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Nenhuma transação ainda.',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      const SizedBox(),
                      const SizedBox(),
                    ],
                  )
                else
                  ...docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final tipo = data['tipo'] ?? 'Compra';
                    final qtd = tipo == 'Venda'
                        ? data['Tokens Vendidos']
                        : data['Tokens Comprados'];
                    final valor = data['Valor Token'];
                    return _orderRow(
                      tipo,
                      (qtd ?? 0).toString(),
                      (valor as num).toStringAsFixed(2),
                      tipo == 'Venda' ? Colors.red : Colors.green,
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

  // Widget de Histórico que usa a lista _historicoFake
  Widget _buildDynamicHistory() {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final startupId = widget.startup['id'] ??
      _getStartupId(widget.startup['ticker']);

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Histórico",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('startups')
              .doc(startupId)
              .collection('Histórico')
              .where('uid', isEqualTo: uid)
              .orderBy('data', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final docs = snapshot.data?.docs ?? [];

            if (docs.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Nenhuma transação encontrada.',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              );
            }

            // mostra só 4, ou todos se _verTodos for true
            final exibir = _verTodos ? docs : docs.take(2).toList();

            return Column(
              children: [
                ...exibir.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return _buildTransactionTile(data);
                }),
                if (docs.length > 2)
                  TextButton(
                    onPressed: () => setState(() => _verTodos = !_verTodos),
                    child: Text(
                      _verTodos ? 'Ver menos' : 'Ver mais',
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
    final tipo = item['tipo'] ?? 'Compra';
    final isCompra = tipo == 'Compra';
    final color = isCompra ? Colors.green : Colors.red;
    final icon = isCompra ? Icons.shopping_cart : Icons.sell;

    final dataFormatada = item['data'] != null
        ? DateFormat('MMM dd, hh:mm a')
            .format((item['data'] as Timestamp).toDate())
        : '';

    return ListTile(
      onTap: () {
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
          color: color.withValues(alpha: 0.1),
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
            "${item['Tokens Comprados'] ?? item['Tokens Vendidos'] ?? 0}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            "${widget.startup['ticker']}",
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
    final dataFormatada = transacao['data'] != null
        ? DateFormat('MMM dd, hh:mm a')
            .format((transacao['data'] as Timestamp).toDate())
        : 'Data não disponível';

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
              "${transacao['Tokens Comprados'] ?? transacao['Tokens Vendidos'] ?? 0} $ticker",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF512DA8),
              ),
            ),
            Text(
              "R\$ ${(transacao['Preco Pago'] as num?)?.toStringAsFixed(2) ?? '0.00'}",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildDetailRow("Data", dataFormatada),
                  _buildDetailRow("Status", transacao['status'] ?? '-', isStatus: true),
                  _buildDetailRow("Preço Pago", "R\$ ${(transacao['Preco Pago'] as num?)?.toStringAsFixed(2) ?? '0.00'}"),
                  _buildDetailRow("Tokens Comprados", "${transacao['Tokens Comprados'] ?? transacao['Tokens Vendidos'] ?? 0}"),
                  _buildDetailRow("Valor do Token", "R\$ ${(transacao['Valor Token'] as num?)?.toStringAsFixed(2) ?? '0.00'}"),
                ],
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