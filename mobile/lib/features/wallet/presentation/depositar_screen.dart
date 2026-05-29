import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class DepositarScreen extends StatefulWidget {
  const DepositarScreen({super.key});

  @override
  State<DepositarScreen> createState() => _DepositarScreenState();
}

class _DepositarScreenState extends State<DepositarScreen> {
  static const primaryPurple = Color(0xFF6B33B4);
  final _valorController = TextEditingController();
  String? _metodoSelecionado;
  bool _enviando = false; 

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  void _setValor(double valor) {
    setState(() {
      _valorController.text = valor.toStringAsFixed(2);
    });
  }

  void _confirmar() async {
  final valor = double.tryParse(_valorController.text);
  if (valor == null || valor <= 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Informe um valor válido.')),
    );
    return;
  }
  if (_metodoSelecionado == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Selecione um método de pagamento.')),
    );
    return;
  }

  setState(() => _enviando = true);

  try {
    final functions = FirebaseFunctions.instanceFor(region: 'us-central1');
    final resultado = await functions.httpsCallable('depositar').call({
      'valor': valor,
    });

    if (resultado.data['success'] == true) {
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultado.data['message'])),
      );
    }
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Erro ao realizar depósito.')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: primaryPurple,
        elevation: 0,
        centerTitle: true,
        title: const Text('Depositar'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardValor(),
            const SizedBox(height: 16),
            _cardMetodo(),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _enviando ? null : _confirmar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: _enviando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Confirmar depósito',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardValor() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Valor do depósito',
            style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12, width: 0.5),
            ),
            child: Row(
              children: [
                const Text(
                  'R\$',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF888888),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _valorController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1A1A),
                    ),
                    decoration: const InputDecoration(
                      hintText: '0,00',
                      hintStyle: TextStyle(color: Color(0xFFBBBBBB)),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [50.0, 100.0, 250.0, 500.0].map((v) {
              return GestureDetector(
                onTap: () => _setValor(v),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black12, width: 0.5),
                  ),
                  child: Text(
                    'R\$ ${v.toInt()}',
                    style: const TextStyle(fontSize: 13, color: Color(0xFF666666)),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _cardMetodo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Método de pagamento',
            style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
          ),
          const SizedBox(height: 12),
          _MetodoItem(
            id: 'debito',
            nome: 'Débito',
            descricao: 'Saldo disponível imediatamente',
            icon: Icons.credit_card,
            iconBg: const Color(0xFFEEEDFE),
            iconColor: const Color(0xFF534AB7),
            selecionado: _metodoSelecionado == 'debito',
            onTap: () => setState(() => _metodoSelecionado = 'debito'),
          ),
          const SizedBox(height: 10),
          _MetodoItem(
            id: 'credito',
            nome: 'Crédito',
            descricao: 'Parcelamento disponível',
            icon: Icons.wallet,
            iconBg: const Color(0xFFFBEAF0),
            iconColor: const Color(0xFF993556),
            selecionado: _metodoSelecionado == 'credito',
            onTap: () => setState(() => _metodoSelecionado = 'credito'),
          ),
          const SizedBox(height: 10),
          _MetodoItem(
            id: 'pix',
            nome: 'Pix',
            descricao: 'Transferência instantânea',
            icon: Icons.qr_code,
            iconBg: const Color(0xFFE1F5EE),
            iconColor: const Color(0xFF0F6E56),
            selecionado: _metodoSelecionado == 'pix',
            onTap: () => setState(() => _metodoSelecionado = 'pix'),
          ),
        ],
      ),
    );
  }
}

class _MetodoItem extends StatelessWidget {
  const _MetodoItem({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.selecionado,
    required this.onTap,
  });

  final String id;
  final String nome;
  final String descricao;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final bool selecionado;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selecionado ? const Color(0xFF6B33B4) : Colors.black12,
            width: selecionado ? 2 : 0.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nome,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  Text(
                    descricao,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selecionado ? const Color(0xFF6B33B4) : Colors.black26,
                  width: 2,
                ),
              ),
              child: selecionado
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF6B33B4),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}