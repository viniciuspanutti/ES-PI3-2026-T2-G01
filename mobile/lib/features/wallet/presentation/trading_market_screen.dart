// feito por camila fernandes costacurta RA:25012949 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/core/routes/app_routes.dart';
import 'package:mobile/features/wallet/presentation/trade_market.dart' as camila_market;

class BalcaoNegociacaoPage extends StatefulWidget {
  final String startupId;
  const BalcaoNegociacaoPage({super.key, required this.startupId});

  @override
  State<BalcaoNegociacaoPage> createState() => _BalcaoNegociacaoPageState();
}

class _BalcaoNegociacaoPageState extends State<BalcaoNegociacaoPage> {
  final TextEditingController _quantidadeController = TextEditingController();
  double _saldo = 0;
  final List<Map<String, dynamic>> _transacoes = [];
  bool _loading = true;

  late Stream<List<Map<String, dynamic>>> _ofertasStream;

  @override
  void initState() {
    super.initState();
    _loadCarteira();
    _ofertasStream = FirebaseFirestore.instance
        .collection('startups')
        .doc(widget.startupId)
        .collection('Histórico')
        .orderBy('data', descending: true)
        .limit(5)
        .snapshots()
        .map((snap) => snap.docs.map<Map<String, dynamic>>((doc) {
              final data = doc.data();
              final tipo = data['tipo'] ?? 'Compra';
              final qtd = tipo == 'Venda' ? data['Tokens Vendidos'] : data['Tokens Comprados'];
              final valor = data['Valor Token'];
              return {
                'tipo': tipo,
                'qtd': (qtd ?? 0).toString(),
                'valor': (valor as num).toStringAsFixed(2),
                'cor': tipo == 'Venda' ? Colors.red : Colors.green,
              };
            }).toList());
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
    super.dispose();
  }

  Future<void> _loadCarteira() async {
    try {
      final callable = FirebaseFunctions.instance.httpsCallable('buscarSaldo');
      final result = await callable.call();
      if (!mounted) return;
      setState(() {
        _saldo = (result.data['saldo'] as num).toDouble();
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao buscar saldo')),
      );
    }
  }

  Future<void> _registrarOrdem({
    required String acao,
    required double quantidade,
  }) async {
    final isCompra = acao == 'Comprar';

    if (!isCompra) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Venda ainda não implementada.')),
      );
      return;
    }

    try {
      final callable = FirebaseFunctions.instance.httpsCallable('exchange-buyTokens');
      await callable.call({
        'startupId': widget.startupId,
        'quantidade': quantidade.toInt(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Compra realizada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      _loadCarteira();
    } on FirebaseFunctionsException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? e.details?.toString() ?? 'Erro na transação'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro inesperado: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showDialogNegociacao(String acao) {
    _quantidadeController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$acao Tokens'),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.mainRoute,
              (route) => false,
            );
          },
        ),
        title: Text('Balcao de Negociacao', style: GoogleFonts.lora()),
        actions: [],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Saldo atual: ${_saldo.toStringAsFixed(2)}',
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
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _ofertasStream,
              builder: (context, snapshot) {
                final ofertas = snapshot.data ?? [];
                return Column(
                  children: [
                    _headerTabela(),
                    if (ofertas.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Nenhuma transação ainda.', style: TextStyle(color: Colors.grey)),
                      )
                    else
                      ...ofertas.map(_itemOferta),
                  ],
                );
              },
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
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const camila_market.BalcaoNegociacaoPage()),
              );
            },
            icon: const Icon(Icons.storefront, color: Colors.white),
            label: const Text('Acessar Mercado de Startups', style: TextStyle(color: Colors.white, fontSize: 16)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[800],
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
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
          Text('Qtd', style: TextStyle(fontWeight: FontWeight.bold)),
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
