//feito por camila fernandes costacurta RA:25012949
import 'package:fl_chart/fl_chart.dart'; 
 import 'package:flutter/material.dart'; 
 
 class ValorizacaoPage extends StatefulWidget { 
   const ValorizacaoPage({super.key}); 
 
   @override 
   State<ValorizacaoPage> createState() => _ValorizacaoPageState(); 
 } 
 
 class _ValorizacaoPageState extends State<ValorizacaoPage> { 
   static const _periods = <String>['D', 'S', 'M', '6M', 'YTD']; 
   static const _purple = Color(0xFF4D2A8D); 
 
   String _selectedPeriod = 'M'; 
 
   List<FlSpot> _spotsForPeriod(String period) { 
     switch (period) { 
       case 'D': 
         return const [ 
           FlSpot(0, 6.02), 
           FlSpot(1, 6.05), 
           FlSpot(2, 6.04), 
           FlSpot(3, 6.08), 
           FlSpot(4, 6.10), 
         ]; 
       case 'S': 
         return const [ 
           FlSpot(0, 5.88), 
           FlSpot(1, 5.92), 
           FlSpot(2, 5.97), 
           FlSpot(3, 6.01), 
           FlSpot(4, 6.04), 
           FlSpot(5, 6.06), 
           FlSpot(6, 6.10), 
         ]; 
       case '6M': 
         return const [ 
           FlSpot(0, 4.70), 
           FlSpot(1, 4.95), 
           FlSpot(2, 5.10), 
           FlSpot(3, 5.30), 
           FlSpot(4, 5.65), 
           FlSpot(5, 6.10), 
         ]; 
       case 'YTD': 
         return const [ 
           FlSpot(0, 5.15), 
           FlSpot(1, 5.08), 
           FlSpot(2, 5.22), 
           FlSpot(3, 5.40), 
           FlSpot(4, 5.55), 
           FlSpot(5, 5.81), 
           FlSpot(6, 6.10), 
         ]; 
       case 'M': 
       default: 
         return const [ 
           FlSpot(0, 5.40), 
           FlSpot(1, 5.48), 
           FlSpot(2, 5.52), 
           FlSpot(3, 5.60), 
           FlSpot(4, 5.75), 
           FlSpot(5, 5.91), 
           FlSpot(6, 6.10), 
         ]; 
     } 
   } 
 
   String _variationText() { 
     switch (_selectedPeriod) { 
       case 'D': 
         return '+1.3% hoje'; 
       case 'S': 
         return '+3.8% na semana'; 
       case '6M': 
         return '+29.7% em 6 meses'; 
       case 'YTD': 
         return '+18.4% no ano'; 
       case 'M': 
       default: 
         return '+12.4% no mes'; 
     } 
   } 
 
   @override 
   Widget build(BuildContext context) { 
     return Scaffold( 
       backgroundColor: const Color(0xFFF6F6F8), 
       body: SafeArea( 
         child: Padding( 
           padding: const EdgeInsets.fromLTRB(20, 12, 20, 20), 
           child: Column( 
             crossAxisAlignment: CrossAxisAlignment.start, 
             children: [ 
               Row( 
                 children: [ 
                   InkResponse( 
                     onTap: () => Navigator.pop(context), 
                     radius: 20, 
                     child: const Icon(Icons.arrow_back, size: 22), 
                   ), 
                   const SizedBox(width: 8), 
                   const Text( 
                     'Voltar', 
                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700), 
                   ), 
                 ], 
               ), 
               const SizedBox(height: 22), 
               const Center( 
                 child: Text( 
                   'Valorizacao do Token', 
                   style: TextStyle( 
                     color: Color(0xFF202024), 
                     fontSize: 21, 
                     fontWeight: FontWeight.w600, 
                   ), 
                 ), 
               ), 
               const SizedBox(height: 20), 
               Center( 
                 child: Column( 
                   children: [ 
                     const Text( 
                       'R\$ 6,10', 
                       style: TextStyle( 
                         color: _purple, 
                         fontSize: 42, 
                         fontWeight: FontWeight.w600, 
                       ), 
                     ), 
                     const SizedBox(height: 2), 
                     Text( 
                       _variationText(), 
                       style: const TextStyle( 
                         color: Color(0xFF15A95F), 
                         fontSize: 16, 
                         fontWeight: FontWeight.w600, 
                       ), 
                     ), 
                   ], 
                 ), 
               ), 
               const SizedBox(height: 24), 
               Container( 
                 height: 300, 
                 padding: const EdgeInsets.fromLTRB(16, 14, 16, 10), 
                 decoration: BoxDecoration( 
                   color: Colors.white, 
                   borderRadius: BorderRadius.circular(18), 
                   border: Border.all(color: const Color(0xFFE9E9ED)), 
                 ), 
                 child: LineChart( 
                   LineChartData( 
                     minY: 4.5, 
                     maxY: 6.4, 
                     gridData: FlGridData( 
                       show: true, 
                       drawVerticalLine: false, 
                       getDrawingHorizontalLine: (value) => 
                           const FlLine(color: Color(0xFFEFEFF3), strokeWidth: 1), 
                     ), 
                     borderData: FlBorderData(show: false), 
                     titlesData: const FlTitlesData(show: false), 
                     lineBarsData: [ 
                       LineChartBarData( 
                         spots: _spotsForPeriod(_selectedPeriod), 
                         isCurved: true, 
                         color: _purple, 
                         barWidth: 3.2, 
                         dotData: const FlDotData(show: false), 
                         belowBarData: BarAreaData( 
                           show: true, 
                           color: _purple.withOpacity(0.16), 
                         ), 
                       ), 
                     ], 
                   ), 
                 ), 
               ), 
               const SizedBox(height: 18), 
               Wrap( 
                 spacing: 8, 
                 runSpacing: 8, 
                 children: _periods.map((period) { 
                   final selected = period == _selectedPeriod; 
                   return GestureDetector( 
                     onTap: () => setState(() => _selectedPeriod = period), 
                     child: AnimatedContainer( 
                       duration: const Duration(milliseconds: 160), 
                       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), 
                       decoration: BoxDecoration( 
                         color: selected ? _purple : Colors.white, 
                         borderRadius: BorderRadius.circular(12), 
                         border: Border.all( 
                           color: selected ? _purple : const Color(0xFFDCDCE2), 
                         ), 
                       ), 
                       child: Text( 
                         period, 
                         style: TextStyle( 
                           color: selected ? Colors.white : const Color(0xFF4B4B50), 
                           fontSize: 14, 
                           fontWeight: FontWeight.w600, 
                         ), 
                       ), 
                     ), 
                   ); 
                 }).toList(), 
               ), 
               const SizedBox(height: 20), 
               Container( 
                 width: double.infinity, 
                 padding: const EdgeInsets.all(14), 
                 decoration: BoxDecoration( 
                   color: const Color(0xFFF8F8FB), 
                   borderRadius: BorderRadius.circular(14), 
                   border: Border.all(color: const Color(0xFFE8E8EE)), 
                 ), 
                 child: const Text( 
                   'Calculo de valorizacao baseado em variacao percentual de transacoes simuladas no periodo selecionado.', 
                   style: TextStyle( 
                     color: Color(0xFF5A5A60), 
                     fontSize: 12.5, 
                     fontWeight: FontWeight.w500, 
                     height: 1.4, 
                   ), 
                 ), 
               ), 
             ], 
           ), 
         ), 
       ), 
     ); 
   } 
 }
