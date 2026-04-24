// feito por camila fernandes costacurta RA:25012949 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'storage.dart';

class BalcaoNegociacaoPage extends StatefulWidget {
  const BalcaoNegociacaoPage({super.key});

  @override
  State<BalcaoNegociacaoPage> createState() => _BalcaoNegociacaoPageState();
}

class _BalcaoNegociacaoPageState extends State<BalcaoNegociacaoPage> {
  final TextEditingController _quantidadeController = TextEditingController();
  double _saldoByd = 0;
  List<Map<String, dynamic>> _transacoes = [];
  bool _loading = true;

  final List<Map<String, dynamic>> _ofertas = [
    {'tipo': 'Venda', 'qtd': '50', 'valor': '6.15', 'cor': Colors.red},
    {'tipo': 'Venda', 'qtd': '120', 'valor': '6.12', 'cor': Colors.red},
    {'tipo': 'Compra', 'qtd': '80', 'valor': '6.08', 'cor': Colors.green},
    {'tipo': 'Compra', 'qtd': '200', 'valor': '6.05', 'cor': Colors.green},
  ];

  @override
  void initState() {
    super.initState();
    _loadCarteira();
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
    super.dispose();
  }

  Future<void> _loadCarteira() async {
    final saldo = await AppStorage.getWalletBalance();
    final txs = await AppStorage.getWalletTransactions();
    if (!mounted) return;
    setState(() {
      _saldoByd = saldo;
      _transacoes = txs;
      _loading = false;
    });
  }

  Future<void> _persistCarteira() async {
    await AppStorage.setWalletBalance(_saldoByd);
    await AppStorage.setWalletTransactions(_transacoes);
  }

  Future<void> _registrarOrdem({
    required String acao,
    required double quantidade,
  }) async {
    final isCompra = acao == 'Comprar';
    final novoSaldo = isCompra ? _saldoByd - quantidade : _saldoByd + quantidade;
    if (novoSaldo < 0) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saldo insuficiente para compra')),
      );
      return;
    }

    setState(() {
      _saldoByd = novoSaldo;
      _transacoes.insert(0, {
        'title': isCompra ? 'Compra no balcao' : 'Venda no balcao',
        'subtitle': 'Ordem simulada executada',
        'value': '${isCompra ? '-' : '+'}${quantidade.toStringAsFixed(2)} BYD',
        'kind': isCompra ? 'buy' : 'sell',
        'createdAt': DateTime.now().toIso8601String(),
      });
    });
    await _persistCarteira();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ordem de $acao enviada ao Balcao!')),
    );
  }

  void _showDialogNegociacao(String acao) {
    _quantidadeController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$acao Tokens BYD'),
        content: TextField(
          controller: _quantidadeController,
          decoration: const InputDecoration(labelText: 'Quantidade de Tokens'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final quantidade =
                  double.tryParse(_quantidadeController.text.replaceAll(',', '.')) ?? 0;
              Navigator.pop(context);
              if (quantidade <= 0) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Informe uma quantidade valida')),
                );
                return;
              }
              await _registrarOrdem(acao: acao, quantidade: quantidade);
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Balcao de Negociacao', style: GoogleFonts.lora()),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/profile-security'),
            icon: const Icon(Icons.security_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Saldo atual: ${_saldoByd.toStringAsFixed(2)} BYD',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            'Livro de Ofertas (Mercado)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple[900],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                _headerTabela(),
                ..._ofertas.map(_itemOferta),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _showDialogNegociacao('Comprar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Comprar', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _showDialogNegociacao('Vender'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Vender', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerTabela() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.grey[100],
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Tipo', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Qtd (BYD)', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Preco (R\$)', style: TextStyle(fontWeight: FontWeight.bold)),
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
          Text(
            oferta['tipo'] as String,
            style: TextStyle(
              color: oferta['cor'] as Color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(oferta['qtd'] as String),
          Text('R\$ ${oferta['valor']}'),
        ],
      ),
    );
  }
}
