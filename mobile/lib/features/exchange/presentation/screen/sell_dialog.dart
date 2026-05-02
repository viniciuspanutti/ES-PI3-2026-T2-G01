import 'package:flutter/material.dart';
import '../../data/exchange_service.dart';
import '../../data/simple_transaction_service.dart';

class SellTokensDialog extends StatefulWidget {
  final String startupId;
  final String startupName;
  final int ownedTokens;
  final double currentPrice;

  const SellTokensDialog({
    super.key,
    required this.startupId,
    required this.startupName,
    required this.ownedTokens,
    required this.currentPrice,
  });

  @override
  State<SellTokensDialog> createState() => _SellTokensDialogState();
}

class _SellTokensDialogState extends State<SellTokensDialog> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  String _sellType = 'direct'; // 'direct' ou 'orderbook'
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _priceController.text = widget.currentPrice.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  double get _totalValue {
    final quantity = double.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0;
    return quantity * price;
  }

  Future<void> _sellTokens() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final quantity = int.parse(_quantityController.text);
      final desiredPrice = _sellType == 'orderbook' 
          ? double.tryParse(_priceController.text) 
          : null;

      await ExchangeService().sellTokens(
        widget.startupId,
        quantity,
        _sellType,
        desiredPrice,
      );

      // Registrar transação local para atualização em tempo real
      SimpleTransactionService().addTransaction(
        type: 'VENDA',
        amount: quantity.toString(),
        price: desiredPrice ?? widget.currentPrice,
      );

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_sellType == 'direct' 
                ? 'Venda realizada com sucesso!' 
                : 'Oferta registrada no balcão!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color roxoMescla = Color(0xFF512DA8);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vender ${widget.startupName}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: roxoMescla,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Você possui: ${widget.ownedTokens} tokens',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),

              // Tipo de Venda
              const Text('Tipo de Venda', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Venda Direta'),
                      subtitle: const Text('Vende para o sistema', style: TextStyle(fontSize: 12)),
                      value: 'direct',
                      groupValue: _sellType,
                      onChanged: (value) {
                        setState(() {
                          _sellType = value!;
                          _priceController.text = widget.currentPrice.toStringAsFixed(2);
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Balcão'),
                      subtitle: const Text('Oferece para outros', style: TextStyle(fontSize: 12)),
                      value: 'orderbook',
                      groupValue: _sellType,
                      onChanged: (value) {
                        setState(() {
                          _sellType = value!;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Quantidade
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantidade de Tokens',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.token),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite a quantidade';
                  }
                  final quantity = int.tryParse(value);
                  if (quantity == null || quantity <= 0) {
                    return 'Quantidade inválida';
                  }
                  if (quantity > widget.ownedTokens) {
                    return 'Você não possui essa quantidade';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Preço (apenas para orderbook)
              if (_sellType == 'orderbook')
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Preço Desejado (R\$)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite o preço';
                    }
                    final price = double.tryParse(value);
                    if (price == null || price <= 0) {
                      return 'Preço inválido';
                    }
                    return null;
                  },
                ),
              if (_sellType == 'orderbook') const SizedBox(height: 16),

              // Resumo
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resumo da Venda',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Quantidade:'),
                        Text('${_quantityController.text} tokens'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Preço:'),
                        Text('R\$ ${_priceController.text}'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'R\$ ${_totalValue.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: roxoMescla,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Botões
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isLoading ? null : () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _sellTokens,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: roxoMescla,
                        foregroundColor: Colors.white,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Confirmar Venda'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
