import 'package:flutter/material.dart'; 
 import 'package:fl_chart/fl_chart.dart'; 
 import 'package:google_fonts/google_fonts.dart'; 
 import 'package:mobile/services/local_storage_service.dart'; 
 
 class WalletDashboardPage extends StatefulWidget { 
   const WalletDashboardPage({super.key}); 
 
   @override 
   State<WalletDashboardPage> createState() => _WalletDashboardPageState(); 
 } 
 
 class _WalletDashboardPageState extends State<WalletDashboardPage> { 
   double _saldoByd = 0; 
   List<Map<String, dynamic>> _transacoes = []; 
   bool _loading = true; 
 
   @override 
   void initState() { 
     super.initState(); 
     _loadCarteira(); 
   } 
 
   Future<void> _loadCarteira() async { 
     final saldo = await AppStorage.getWalletBalance(); 
     final txs = await AppStorage.getWalletTransactions(); 
     setState(() { 
       _saldoByd = saldo; 
       _transacoes = txs; 
       _loading = false; 
     }); 
   } 
 
   Future<void> _irParaBalcao() async { 
     await Navigator.pushNamed(context, '/balcao'); 
     _loadCarteira(); 
   } 
 
   @override 
   Widget build(BuildContext context) { 
     if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator())); 
 
     return Scaffold( 
       backgroundColor: Colors.white, 
       body: SingleChildScrollView( 
         child: Column( 
           children: [ 
             // Cabeçalho Roxo - Mantendo o padrão das outras telas 
             Container( 
               width: double.infinity, 
               padding: const EdgeInsets.fromLTRB(20, 60, 20, 40), 
               decoration: const BoxDecoration( 
                 color: Color(0xFF4B0082), 
                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)), 
               ), 
               child: Column( 
                 children: [ 
                   Text('PATRIMÔNIO ESTIMADO', style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white70, letterSpacing: 1.2)), 
                   const SizedBox(height: 10), 
                   Text('R\$ ${(_saldoByd * 6.10).toStringAsFixed(2)}', 
                        style: GoogleFonts.philosopher(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)), 
                   const SizedBox(height: 20), 
                   ElevatedButton.icon( 
                     onPressed: _irParaBalcao, 
                     style: ElevatedButton.styleFrom( 
                       backgroundColor: Colors.white, 
                       foregroundColor: const Color(0xFF4B0082), 
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), 
                     ), 
                     icon: const Icon(Icons.account_balance_wallet_outlined), 
                     label: const Text('Negociar no Balcão'), 
                   ), 
                 ], 
               ), 
             ), 
 
             // Dashboard Gráfico (Escopo 5.4) 
             Padding( 
               padding: const EdgeInsets.all(20), 
               child: Column( 
                 crossAxisAlignment: CrossAxisAlignment.start, 
                 children: [ 
                   Text('Variação do Ativo (BYD)', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16)), 
                   const SizedBox(height: 20), 
                   SizedBox( 
                     height: 180, 
                     child: LineChart( 
                       LineChartData( 
                         gridData: const FlGridData(show: false), 
                         titlesData: const FlTitlesData(show: false), 
                         borderData: FlBorderData(show: false), 
                         lineBarsData: [ 
                           LineChartBarData( 
                             spots: [ 
                               const FlSpot(0, 5.8), 
                               const FlSpot(1, 5.9), 
                               const FlSpot(2, 6.1), 
                               const FlSpot(3, 6.0), 
                               const FlSpot(4, 6.10), // Cotação atual 
                             ], 
                             isCurved: true, 
                             color: const Color(0xFF4B0082), 
                             barWidth: 4, 
                             dotData: const FlDotData(show: true), 
                             belowBarData: BarAreaData(show: true, color: const Color(0xFF4B0082).withOpacity(0.1)), 
                           ), 
                         ], 
                       ), 
                     ), 
                   ), 
                 ], 
               ), 
             ), 
 
             // Histórico 
             Padding( 
               padding: const EdgeInsets.symmetric(horizontal: 20), 
               child: Column( 
                 crossAxisAlignment: CrossAxisAlignment.start, 
                 children: [ 
                   const Divider(), 
                   Text('Movimentações Recentes', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)), 
                   const SizedBox(height: 10), 
                   _transacoes.isEmpty 
                     ? const Padding(padding: EdgeInsets.all(20), child: Text("Nenhuma transação registrada.")) 
                     : ListView.builder( 
                         shrinkWrap: true, 
                         physics: const NeverScrollableScrollPhysics(), 
                         itemCount: _transacoes.length, 
                         itemBuilder: (context, index) { 
                           final tx = _transacoes[index]; 
                           // CURA PARA O ERRO VERMELHO: Garantir que tratamos como String e temos fallback 
                           final String valorStr = tx['valor']?.toString() ?? '0.00'; 
                           final bool isPositivo = valorStr.contains('+'); 
 
                           return ListTile( 
                             contentPadding: EdgeInsets.zero, 
                             leading: Icon(isPositivo ? Icons.arrow_upward : Icons.arrow_downward, 
                                          color: isPositivo ? Colors.green : Colors.red), 
                             title: Text("${tx['tipo'] ?? 'Transação'}", style: const TextStyle(fontWeight: FontWeight.w600)), 
                             subtitle: Text("${tx['data'] ?? ''}"), 
                             trailing: Text( 
                               valorStr, 
                               style: GoogleFonts.montserrat( 
                                 color: isPositivo ? Colors.green : Colors.red, 
                                 fontWeight: FontWeight.bold, 
                                 fontSize: 14 
                               ), 
                             ), 
                           ); 
                         }, 
                       ), 
                   const SizedBox(height: 50), 
                 ], 
               ), 
             ), 
           ], 
         ), 
       ), 
     ); 
   } 
 }
