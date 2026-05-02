import 'package:flutter/material.dart';
import '../../data/exchange_service.dart';

class TradingFloorScreen extends StatefulWidget {
  const TradingFloorScreen({super.key});

  @override
  State<TradingFloorScreen> createState() => _TradingFloorScreenState();
}

class _TradingFloorScreenState extends State<TradingFloorScreen> {
  final _exchangeService = ExchangeService();
  String _selectedStartup = '5bfozOLJ0a93No2wuWni'; // BYD
  bool _isLoading = false;
  Map<String, dynamic>? _orderBook;
  Map<String, dynamic>? _startupInfo;

  @override
  void initState() {
    super.initState();
    _loadOrderBook();
  }

  Future<void> _loadOrderBook() async {
    setState(() => _isLoading = true);
    try {
      // Simulação - deveria chamar o backend real
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _isLoading = false;
        _orderBook = {
          'sellOrders': [
            {'id': '1', 'quantity': 10, 'desiredPrice': 6.05, 'totalValue': 60.5},
            {'id': '2', 'quantity': 25, 'desiredPrice': 6.08, 'totalValue': 152.0},
            {'id': '3', 'quantity': 50, 'desiredPrice': 6.10, 'totalValue': 305.0},
          ],
          'totalOrders': 3,
          'totalVolume': 85
        };
        _startupInfo = {
          'name': 'BYD',
          'currentTokenPrice': 6.09,
          'lastTradePrice': 6.08,
          'lastTradeVolume': 15,
          'lastTradeTime': DateTime.now().subtract(const Duration(minutes: 5))
        };
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ${e.toString()}')),
      );
    }
  }

  void _showBuyDialog() {
    showDialog(
      context: context,
      builder: (context) => _BuyOrderDialog(
        startupId: _selectedStartup,
        startupName: _startupInfo?['name'] ?? 'Startup',
        currentPrice: _startupInfo?['currentTokenPrice'] ?? 0.0,
        onBuy: _executeBuy,
      ),
    );
  }

  void _showSellDialog() {
    showDialog(
      context: context,
      builder: (context) => _SellOrderDialog(
        startupId: _selectedStartup,
        startupName: _startupInfo?['name'] ?? 'Startup',
        ownedTokens: 345, // Simulação
        currentPrice: _startupInfo?['currentTokenPrice'] ?? 0.0,
        onSell: _executeSell,
      ),
    );
  }

  Future<void> _executeBuy(int quantity, double maxPrice) async {
    setState(() => _isLoading = true);
    try {
      // await _exchangeService.matchOrders(_selectedStartup, quantity, maxPrice);
      await Future.delayed(const Duration(seconds: 2)); // Simulação
      await _loadOrderBook();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Compra executada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro na compra: ${e.toString()}'),
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

  Future<void> _executeSell(int quantity, String sellType, double? desiredPrice) async {
    setState(() => _isLoading = true);
    try {
      // await _exchangeService.sellTokens(_selectedStartup, quantity, sellType, desiredPrice);
      await Future.delayed(const Duration(seconds: 2)); // Simulação
      await _loadOrderBook();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(sellType == 'direct' 
                ? 'Venda direta realizada!' 
                : 'Oferta registrada no balcão!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro na venda: ${e.toString()}'),
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

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Balcão de Negociação'),
        backgroundColor: roxoMescla,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isLoading && _orderBook == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header com informações da startup
                  _buildStartupHeader(),
                  const SizedBox(height: 24),

                  // Botões de ação
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _showBuyDialog,
                          icon: const Icon(Icons.trending_up),
                          label: const Text('Comprar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _showSellDialog,
                          icon: const Icon(Icons.trending_down),
                          label: const Text('Vender'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Livro de Ofertas
                  _buildOrderBook(),
                ],
              ),
            ),
    );
  }

  Widget _buildStartupHeader() {
    if (_startupInfo == null) return const SizedBox.shrink();

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _startupInfo!['name'],
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF512DA8),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '+2.3%',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Preço Atual',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'R\$ ${_startupInfo!['currentTokenPrice'].toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Última Negociação',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${_startupInfo!['lastTradeVolume']} tokens',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'R\$ ${_startupInfo!['lastTradePrice'].toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderBook() {
    if (_orderBook == null) return const SizedBox.shrink();

    final sellOrders = _orderBook!['sellOrders'] as List<dynamic>;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Livro de Ofertas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${sellOrders.length} ordens • ${_orderBook!['totalVolume']} tokens',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sellOrders.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final order = sellOrders[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${order['quantity']} tokens',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'R\$ ${order['desiredPrice'].toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF512DA8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'R\$ ${order['totalValue'].toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Diálogos simplificados para compra e venda
class _BuyOrderDialog extends StatefulWidget {
  final String startupId;
  final String startupName;
  final double currentPrice;
  final Function(int, double) onBuy;

  const _BuyOrderDialog({
    required this.startupId,
    required this.startupName,
    required this.currentPrice,
    required this.onBuy,
  });

  @override
  State<_BuyOrderDialog> createState() => _BuyOrderDialogState();
}

class _BuyOrderDialogState extends State<_BuyOrderDialog> {
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Comprar ${widget.startupName}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF512DA8),
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantidade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Preço Máximo (R\$)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final quantity = int.tryParse(_quantityController.text) ?? 0;
                      final price = double.tryParse(_priceController.text) ?? 0;
                      if (quantity > 0 && price > 0) {
                        widget.onBuy(quantity, price);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Comprar'),
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

class _SellOrderDialog extends StatefulWidget {
  final String startupId;
  final String startupName;
  final int ownedTokens;
  final double currentPrice;
  final Function(int, String, double?) onSell;

  const _SellOrderDialog({
    required this.startupId,
    required this.startupName,
    required this.ownedTokens,
    required this.currentPrice,
    required this.onSell,
  });

  @override
  State<_SellOrderDialog> createState() => _SellOrderDialogState();
}

class _SellOrderDialogState extends State<_SellOrderDialog> {
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  String _sellType = 'direct';

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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Vender ${widget.startupName}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF512DA8),
              ),
            ),
            Text(
              'Você possui: ${widget.ownedTokens} tokens',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            RadioListTile<String>(
              title: const Text('Venda Direta'),
              value: 'direct',
              groupValue: _sellType,
              onChanged: (value) => setState(() => _sellType = value!),
            ),
            RadioListTile<String>(
              title: const Text('Balcão de Negociação'),
              value: 'orderbook',
              groupValue: _sellType,
              onChanged: (value) => setState(() => _sellType = value!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantidade',
                border: OutlineInputBorder(),
              ),
            ),
            if (_sellType == 'orderbook') ...[
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Preço Desejado (R\$)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final quantity = int.tryParse(_quantityController.text) ?? 0;
                      final price = double.tryParse(_priceController.text);
                      if (quantity > 0 && quantity <= widget.ownedTokens) {
                        widget.onSell(
                          quantity,
                          _sellType,
                          _sellType == 'orderbook' ? price : null,
                        );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Vender'),
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
