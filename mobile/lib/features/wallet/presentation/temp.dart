import 'package:flutter/material.dart'; 
 import 'package:google_fonts/google_fonts.dart'; 
 import 'package:mobile/services/local_storage_service.dart'; 
 
 class BalcaoNegociacaoPage extends StatefulWidget { 
   const BalcaoNegociacaoPage({super.key}); 
 
   @override 
   State<BalcaoNegociacaoPage> createState() => _BalcaoNegociacaoPageState(); 
 } 
 
 class _BalcaoNegociacaoPageState extends State<BalcaoNegociacaoPage> { 
   final TextEditingController _qtdController = TextEditingController(); 
   double _saldoByd = 0; 
 
   @override 
   void initState() { 
     super.initState(); 
     _refresh(); 
   } 
 
   Future<void> _refresh() async { 
     _saldoByd = await AppStorage.getWalletBalance(); 
     setState(() {}); 
   } 
 
   Future<void> _processar(String tipo) async { 
     double qtd = double.tryParse(_qtdController.text) ?? 0; 
     if (qtd <= 0) return; 
 
     List<Map<String, dynamic>> txs = await AppStorage.getWalletTransactions(); 
     
     if (tipo == 'Venda' && _saldoByd < qtd) { 
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Saldo insuficiente!"))); 
       return; 
     } 
 
     setState(() { 
       _saldoByd = (tipo == 'Compra') ? _saldoByd + qtd : _saldoByd - qtd; 
       txs.insert(0, { 
         'tipo': tipo, 
         'valor': '${tipo == 'Compra' ? '+' : '-'}${qtd.toStringAsFixed(2)} BYD', 
         'data': DateTime.now().toString().substring(0, 16), 
       }); 
     }); 
 
     await AppStorage.setWalletBalance(_saldoByd); 
     await AppStorage.setWalletTransactions(txs); 
     Navigator.pop(context); 
   } 
 
   @override 
   Widget build(BuildContext context) { 
     return Scaffold( 
       appBar: AppBar( 
         title: Text('Balcão de Ofertas', style: GoogleFonts.philosopher(color: Colors.white)), 
         backgroundColor: const Color(0xFF4B0082), 
         iconTheme: const IconThemeData(color: Colors.white), 
       ), 
       body: Padding( 
         padding: const EdgeInsets.all(25), 
         child: Column( 
           children: [ 
             Container( 
               padding: const EdgeInsets.all(20), 
               decoration: BoxDecoration( 
                 color: Colors.grey[100], 
                 borderRadius: BorderRadius.circular(15), 
               ), 
               child: Row( 
                 mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                 children: [ 
                   const Text("Saldo Atual:", style: TextStyle(fontWeight: FontWeight.bold)), 
                   Text("${_saldoByd.toStringAsFixed(2)} BYD", style: const TextStyle(color: Color(0xFF4B0082), fontWeight: FontWeight.bold)), 
                 ], 
               ), 
             ), 
             const SizedBox(height: 30), 
             TextField( 
               controller: _qtdController, 
               keyboardType: TextInputType.number, 
               decoration: InputDecoration( 
                 labelText: "Quantidade de Tokens", 
                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), 
                 prefixIcon: const Icon(Icons.toll), 
               ), 
             ), 
             const SizedBox(height: 20), 
             Row( 
               children: [ 
                 Expanded( 
                   child: ElevatedButton( 
                     onPressed: () => _processar('Compra'), 
                     style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 15)), 
                     child: const Text("COMPRAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), 
                   ), 
                 ), 
                 const SizedBox(width: 15), 
                 Expanded( 
                   child: ElevatedButton( 
                     onPressed: () => _processar('Venda'), 
                     style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: const EdgeInsets.symmetric(vertical: 15)), 
                     child: const Text("VENDER", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), 
                   ), 
                 ), 
               ], 
             ), 
           ], 
         ), 
       ), 
     ); 
   } 
 }
