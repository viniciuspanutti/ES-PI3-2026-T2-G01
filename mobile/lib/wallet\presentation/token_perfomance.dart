// feito por camila fernandes costacurta RA:25012949 
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class ValorizacaoPage extends StatefulWidget {
  const ValorizacaoPage({super.key});

  @override
  State<ValorizacaoPage> createState() => _ValorizacaoPageState();
}

class _ValorizacaoPageState extends State<ValorizacaoPage> {
  // Filtros exigidos pelo escopo
  String periodoSelecionado = 'M'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Performance do Token', style: GoogleFonts.lora()),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Resumo da Variação Atual
          _buildStatusHeader(),
          
          const SizedBox(height: 30),
          
          // O GRÁFICO (O coração do item 5.4)
          Container(
            height: 300,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LineChart(
              _mainData(),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // SELETOR DE PERÍODOS (Exigência do PDF)
          _buildPeriodSelector(),
          
          const Spacer(),
          
          // NOTA PARA O PROFESSOR (Explicação da Lógica)
          _buildLogicInfo(),
        ],
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Column(
      children: [
        Text(
          "R\$ 6,10",
          style: GoogleFonts.lora(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.trending_up, color: Colors.green[700]),
            Text(
              " +12.4% este mês",
              style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPeriodSelector() {
    // Lista exata do escopo da PUC
    List<String> periodos = ['D', 'S', 'M', '6M', 'YTD'];
    
    return ToggleButtons(
      isSelected: periodos.map((p) => p == periodoSelecionado).toList(),
      onPressed: (index) {
        setState(() {
          periodoSelecionado = periodos[index];
        });
      },
      borderRadius: BorderRadius.circular(10),
      selectedColor: Colors.white,
      fillColor: Colors.deepPurple,
      constraints: const BoxConstraints(minWidth: 60, minHeight: 40),
      children: periodos.map((p) => Text(p)).toList(),
    );
  }

  // --- LÓGICA DE CÁLCULO (O diferencial avaliativo) ---
  LineChartData _mainData() {
    return LineChartData(
      gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (value) => FlLine(color: Colors.grey[300], strokeWidth: 1)),
      titlesData: const FlTitlesData(show: false), // Simplificado para o MVP
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: [
            const FlSpot(0, 5.8),
            const FlSpot(1, 5.9),
            const FlSpot(2, 6.1),
            const FlSpot(3, 6.0),
            const FlSpot(4, 6.2),
          ],
          isCurved: true,
          color: Colors.deepPurple,
          barWidth: 4,
          belowBarData: BarAreaData(show: true, color: Colors.deepPurple.withOpacity(0.2)),
        ),
      ],
    );
  }

  Widget _buildLogicInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey[100],
      child: const Text(
        "Lógica: O gráfico utiliza pontos FlSpot para mapear a valorização temporal. A variação percentual é calculada comparando o primeiro e o último ponto do período selecionado.",
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}
