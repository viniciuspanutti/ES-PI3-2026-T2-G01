import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderBookWidget extends StatelessWidget {
  final String ticker;

  const OrderBookWidget({
    super.key,
    required this.ticker,
  });

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
    final startupId = _getStartupId(ticker);
    
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
                .doc(startupId)
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
                    const TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Nenhuma transação ainda.',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        SizedBox(),
                        SizedBox(),
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
}
