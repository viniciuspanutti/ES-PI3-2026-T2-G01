import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/features/startups/data/services/token_sale_service.dart';

class StartupValuationScreen extends StatefulWidget {
  final String startupId;
  final String startupName;

  const StartupValuationScreen({
    super.key,
    required this.startupId,
    required this.startupName,
  });

  @override
  State<StartupValuationScreen> createState() => _StartupValuationScreenState();
}

class _StartupValuationScreenState extends State<StartupValuationScreen> {
  final TokenSaleService _saleService = TokenSaleService();
  
  // Períodos exigidos pelo escopo (5.4)
  final List<String> _periodos = ['D', 'S', 'M', '6M', 'YTD'];
  String _periodoSelecionado = 'M';
  
  // Dados de valorização
  Map<String, dynamic>? _valuationData;
  List<Map<String, dynamic>> _chartData = [];
  double _currentPrice = 0.0;
  double _previousPrice = 0.0;
  double _variation = 0.0;
  bool _isLoading = true;
  
  // Estatísticas da startup
  int _totalTransactions = 0;
  int _totalVolume = 0;
  double _totalValue = 0.0;

  @override
  void initState() {
    super.initState();
    _loadValuationData();
  }

  Future<void> _loadValuationData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Carregar dados de valorização
      final valuationResponse = await _saleService.getStartupValuation(
        startupId: widget.startupId,
        period: _periodoSelecionado,
      );

      // Carregar estatísticas de transações
      final transactionsResponse = await _saleService.getStartupTransactionHistory(
        startupId: widget.startupId,
        limit: 100,
      );

      setState(() {
        _valuationData = valuationResponse;
        _chartData = List<Map<String, dynamic>>.from(valuationResponse['chartData'] ?? []);
        _currentPrice = (valuationResponse['currentPrice'] ?? 0.0).toDouble();
        _previousPrice = (valuationResponse['previousPrice'] ?? 0.0).toDouble();
        _variation = (valuationResponse['variation'] ?? 0.0).toDouble();
        
        _totalTransactions = transactionsResponse['count'] ?? 0;
        _totalVolume = transactionsResponse['volume'] ?? 0;
        _totalValue = (transactionsResponse['totalValue'] ?? 0.0).toDouble();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar dados: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.startupName} - Valorização', style: GoogleFonts.lora()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadValuationData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho com preço atual e variação
                  _buildPriceHeader(),
                  const SizedBox(height: 24),
                  
                  // Cartão de estatísticas
                  _buildStatisticsCard(),
                  const SizedBox(height: 24),
                  
                  // Gráfico principal
                  _buildChartCard(),
                  const SizedBox(height: 24),
                  
                  // Seletor de períodos
                  _buildPeriodSelector(),
                  const SizedBox(height: 24),
                  
                  // Informações da metodologia
                  _buildMethodologyInfo(),
                ],
              ),
            ),
    );
  }

  Widget _buildPriceHeader() {
    final isPositive = _variation >= 0;
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'R\$ ${_currentPrice.toStringAsFixed(2)}',
              style: GoogleFonts.lora(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: isPositive ? Colors.green[700] : Colors.red[700],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isPositive ? Icons.trending_up : Icons.trending_down,
                  color: isPositive ? Colors.green[700] : Colors.red[700],
                ),
                const SizedBox(width: 8),
                Text(
                  '${isPositive ? '+' : ''}${_variation.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: isPositive ? Colors.green[700] : Colors.red[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Text(
              _getPeriodDescription(_periodoSelecionado),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estatísticas da Startup',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Transações',
                    _totalTransactions.toString(),
                    Icons.swap_horiz,
                    Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Volume',
                    '${(_totalVolume / 1000).toStringAsFixed(1)}K',
                    Icons.token,
                    Colors.purple,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Valor Total',
                    'R\$ ${(_totalValue / 1000).toStringAsFixed(1)}K',
                    Icons.attach_money,
                    Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildChartCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Histórico de Preços',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: _chartData.isEmpty
                  ? const Center(child: Text('Sem dados disponíveis'))
                  : LineChart(
                      _createChartData(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Período de Análise',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            ToggleButtons(
              isSelected: _periodos.map((p) => p == _periodoSelecionado).toList(),
              onPressed: (index) {
                setState(() {
                  _periodoSelecionado = _periodos[index];
                });
                _loadValuationData();
              },
              borderRadius: BorderRadius.circular(10),
              selectedColor: Colors.white,
              fillColor: Colors.deepPurple,
              constraints: const BoxConstraints(minWidth: 50, minHeight: 40),
              children: _periodos.map((p) => Text(p)).toList(),
            ),
            const SizedBox(height: 12),
            Text(
              _getPeriodDescription(_periodoSelecionado),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodologyInfo() {
    return Card(
      color: Colors.amber[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info, color: Colors.amber[700]),
                const SizedBox(width: 8),
                Text(
                  'Metodologia de Cálculo',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.amber[700],
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'A valorização é calculada com base nas transações registradas no sistema simulado. '
              'Cada transação impacta o preço através de uma fórmula de variação baseada no volume: '
              '\n\n• Impacto = (Quantidade / 1000) × 0.5%'
              '\n• Novo Preço = Preço Anterior × (1 + Impacto)'
              '\n\nEsta metodologia simula a dinâmica de mercado real onde o volume de negociação '
              'influencia a percepção de valor dos tokens.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    height: 1.4,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData _createChartData() {
    final spots = _chartData.map((point) => FlSpot(
      (point['x'] ?? 0).toDouble(),
      (point['y'] ?? 0).toDouble(),
    )).toList();

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey[300]!,
          strokeWidth: 1,
        ),
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Text(
                'R\$ ${value.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 10),
              );
            },
            reservedSize: 40,
          ),
        ),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              if (value.toInt() % 5 == 0) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                );
              }
              return const Text('');
            },
            reservedSize: 22,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: Colors.deepPurple,
          barWidth: 3,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: Colors.deepPurple.withOpacity(0.2),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                'R\$ ${spot.y.toStringAsFixed(2)}',
                const TextStyle(color: Colors.white, fontSize: 12),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  String _getPeriodDescription(String period) {
    switch (period) {
      case 'D':
        return 'Variação diária - últimas 24 horas';
      case 'S':
        return 'Variação semanal - últimos 7 dias';
      case 'M':
        return 'Variação mensal - últimos 30 dias';
      case '6M':
        return 'Variação semestral - últimos 6 meses';
      case 'YTD':
        return 'Variação acumulada no ano (Year to Date)';
      default:
        return 'Período não especificado';
    }
  }
}
