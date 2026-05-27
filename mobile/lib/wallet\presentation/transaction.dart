import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../transaction_details_screen.dart';

class TransactionHistoryWidget extends StatefulWidget {
  final String ticker;
  final List<Map<String, dynamic>> history;

  const TransactionHistoryWidget({
    super.key,
    required this.ticker,
    required this.history,
  });

  @override
  State<TransactionHistoryWidget> createState() => _TransactionHistoryWidgetState();
}

class _TransactionHistoryWidgetState extends State<TransactionHistoryWidget> {
  bool _verTodos = false;

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

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final startupId = _getStartupId(widget.ticker);

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

  Widget _buildTransactionTile(Map<String, dynamic> item) {
    final tipo = item['tipo'] ?? 'Compra';
    final isCompra = tipo == 'Compra';
    final color = isCompra ? Colors.green : Colors.red;
    final icon = isCompra ? Icons.shopping_cart : Icons.sell;

    final dataFormatada = item['data'] != null
        ? DateFormat('MMM dd, hh:mm a').format((item['data'] as Timestamp).toDate())
        : '';

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailsScreen(
              transacao: {
                ...item,
                'valor': item['Tokens Comprados'] ?? item['Tokens Vendidos'] ?? 0,
              },
              ticker: widget.ticker,
            ),
          ),
        );
      },
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
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
            widget.ticker,
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
