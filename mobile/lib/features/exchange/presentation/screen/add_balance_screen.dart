import 'package:flutter/material.dart';
import '../../data/exchange_service.dart';

class AddBalanceScreen extends StatefulWidget {
  const AddBalanceScreen({super.key});

  @override
  State<AddBalanceScreen> createState() => _AddBalanceScreenState();
}

class _AddBalanceScreenState extends State<AddBalanceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _exchangeService = ExchangeService();
  bool _isLoading = false;
  double _currentBalance = 0.0;
  static const Color roxoMescla = Color(0xFF512DA8);

  @override
  void initState() {
    super.initState();
    _loadCurrentBalance();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentBalance() async {
    // Simulação - deveria buscar do backend real
    setState(() {
      _currentBalance = 1500.0; // Saldo simulado
    });
  }

  Future<void> _addBalance() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final amount = double.parse(_amountController.text);
      
      // await _exchangeService.addBalance(amount);
      
      // Simulação
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _currentBalance += amount;
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Saldo de R\$ ${amount.toStringAsFixed(2)} adicionado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        
        _amountController.clear();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color roxoMescla = Color(0xFF512DA8);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Carregar Saldo'),
        backgroundColor: roxoMescla,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card de saldo atual
            _buildBalanceCard(),
            const SizedBox(height: 32),

            // Formulário
            _buildAddBalanceForm(),
            const SizedBox(height: 32),

            // Valores sugeridos
            _buildSuggestedAmounts(),
            const SizedBox(height: 32),

            // Informações importantes
            _buildImportantInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: roxoMescla,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: roxoMescla.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Saldo Atual',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'R\$ ${_currentBalance.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddBalanceForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adicionar Saldo Fictício',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF512DA8),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
                hintText: '0,00',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Digite um valor';
                }
                final amount = double.tryParse(value.replaceAll(',', '.'));
                if (amount == null || amount <= 0) {
                  return 'Valor inválido';
                }
                if (amount > 10000) {
                  return 'Valor máximo permitido: R\$ 10.000,00';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _addBalance,
                style: ElevatedButton.styleFrom(
                  backgroundColor: roxoMescla,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('Processando...'),
                        ],
                      )
                    : const Text(
                        'Adicionar Saldo',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestedAmounts() {
    final suggestedAmounts = [50.0, 100.0, 250.0, 500.0, 1000.0];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Valores Sugeridos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF512DA8),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: suggestedAmounts.map((amount) {
              return GestureDetector(
                onTap: () {
                  _amountController.text = amount.toStringAsFixed(2);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: roxoMescla.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: roxoMescla.withOpacity(0.3)),
                  ),
                  child: Text(
                    'R\$ ${amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF512DA8),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildImportantInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.orange[700]),
              const SizedBox(width: 8),
              Text(
                'Informações Importantes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...[
            '• Este é um ambiente de simulação',
            '• O saldo adicionado é fictício e serve apenas para testes',
            '• Valor máximo por operação: R\$ 10.000,00',
            '• O saldo pode ser usado para comprar tokens de startups',
            '• Todas as transações são registradas para auditoria',
          ].map((info) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              info,
              style: TextStyle(
                color: Colors.orange[700],
                fontSize: 14,
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }
}
