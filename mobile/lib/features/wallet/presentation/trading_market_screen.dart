import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/core/routes/app_routes.dart';

class BalcaoNegociacaoPage extends StatefulWidget {
  const BalcaoNegociacaoPage({super.key});

  @override
  State<BalcaoNegociacaoPage> createState() => _BalcaoNegociacaoPageState();
}

class _BalcaoNegociacaoPageState extends State<BalcaoNegociacaoPage> {
  final TextEditingController _quantidadeController = TextEditingController();
  double _saldoByd = 345.71;
  
  final List<Map<String, dynamic>> _ofertas = [
    {'tipo': 'Venda', 'qtd': '50', 'valor': '6.15', 'cor': Colors.red},
    {'tipo': 'Venda', 'qtd': '120', 'valor': '6.12', 'cor': Colors.red},
    {'tipo': 'Compra', 'qtd': '80', 'valor': '6.08', 'cor': Colors.green},
    {'tipo': 'Compra', 'qtd': '200', 'valor': '6.05', 'cor': Colors.green},
  ];

  @override
  void dispose() {
    _quantidadeController.dispose();
    super.dispose();
  }

  Future<void> _registrarOrdem({required String acao, required double quantidade}) async {
    final isCompra = acao == 'Comprar';
    final novoSaldo = isCompra ? _saldoByd - quantidade : _saldoByd + quantidade;
    if (novoSaldo < 0) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saldo insuficiente')));
      return;
    }
    setState(() => _saldoByd = novoSaldo);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ordem de $acao enviada!')));
  }

  void _showDialogNegociacao(String acao) {
    _quantidadeController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$acao Tokens BYD'),
        content: TextField(
          controller: _quantidadeController,
          decoration: const InputDecoration(labelText: 'Quantidade'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              final q = double.tryParse(_quantidadeController.text.replaceAll(',', '.')) ?? 0;
              Navigator.pop(context);
              if (q > 0) _registrarOrdem(acao: acao, quantidade: q);
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // CORREÇÃO: Restaurada a seta e usando o Smart Back para não fechar o app
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => AppRoutes.smartBack(context),
        ),
        title: Text('Balcão de Negociação', style: GoogleFonts.lora()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Saldo: ${_saldoByd.toStringAsFixed(2)} BYD', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(15)),
            child: Column(children: _ofertas.map(_itemOferta).toList()),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: ElevatedButton(onPressed: () => _showDialogNegociacao('Comprar'), style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text('Comprar', style: TextStyle(color: Colors.white)))),
              const SizedBox(width: 12),
              Expanded(child: ElevatedButton(onPressed: () => _showDialogNegociacao('Vender'), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text('Vender', style: TextStyle(color: Colors.white)))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _itemOferta(Map<String, dynamic> oferta) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(oferta['tipo'], style: TextStyle(color: oferta['cor'], fontWeight: FontWeight.bold)),
          Text(oferta['qtd']),
          Text('R\$ ${oferta['valor']}'),
        ],
      ),
    );
  }
}
