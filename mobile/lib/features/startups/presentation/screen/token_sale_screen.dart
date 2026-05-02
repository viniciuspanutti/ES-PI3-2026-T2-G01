import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/startups/data/models/token_sale_models.dart';
import 'package:flutter_application_1/features/startups/data/services/token_sale_service.dart';
import 'package:flutter_application_1/features/startups/presentation/screens/app_storage.dart';
import 'package:flutter_application_1/features/startups/presentation/screens/startup_valuation_screen.dart';

class TokenSaleScreen extends StatefulWidget {
  final String startupId;
  final String startupName;

  const TokenSaleScreen({
    super.key,
    required this.startupId,
    required this.startupName,
  });

  @override
  State<TokenSaleScreen> createState() => _TokenSaleScreenState();
}

class _TokenSaleScreenState extends State<TokenSaleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TokenSaleService _saleService = TokenSaleService();
  late String _userId;
  bool _isLoading = false;

  // Variáveis de estado da venda
  int _selectedQuantity = 1;
  double _pricePerToken = 0.0;
  UserPortfolio? _userPortfolio;
  List<SaleOffer> _availableOffers = [];
  List<Transaction> _transactionHistory = [];
  double _walletBalance = 0.0;

  late final Future<void> _initializeFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _initializeFuture = _initialize();
  }

  Future<void> _initialize() async {
    _userId = (await AppStorage.getCurrentEmail()) ?? '';
    if (_userId.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário não autenticado')),
        );
      }
      return;
    }

    await Future.wait([
      _loadPortfolio(),
      _loadAvailableOffers(),
      _loadTransactionHistory(),
      _loadWalletBalance(),
    ]);
  }

  Future<void> _loadPortfolio() async {
    try {
      final portfolio = await _saleService.getUserPortfolio(userId: _userId);
      final startup =
          portfolio.firstWhere((p) => p.startupId == widget.startupId,
              orElse: () => UserPortfolio(
                    userId: _userId,
                    startupId: widget.startupId,
                    tokenQuantity: 0,
                    averageBuyPrice: 0,
                    currentValue: 0,
                    acquiredAt: DateTime.now(),
                  ));

      setState(() {
        _userPortfolio = startup;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar portfólio: $e')),
        );
      }
    }
  }

  Future<void> _loadAvailableOffers() async {
    try {
      final offers =
          await _saleService.listAvailableSaleOffers(startupId: widget.startupId);
      setState(() {
        _availableOffers = offers;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar ofertas: $e')),
        );
      }
    }
  }

  Future<void> _loadTransactionHistory() async {
    try {
      final history = await _saleService.getUserTransactionHistory(userId: _userId);
      setState(() {
        _transactionHistory =
            history.where((t) => t.startupId == widget.startupId).toList();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar histórico: $e')),
        );
      }
    }
  }

  Future<void> _loadWalletBalance() async {
    try {
      final balance = await _saleService.getWalletBalance(userId: _userId);
      setState(() {
        _walletBalance = balance;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar saldo: $e')),
        );
      }
    }
  }

  Future<void> _executeDirectSale() async {
    if (_userPortfolio == null || _selectedQuantity <= 0 || _pricePerToken <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados inválidos')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _saleService.executeDirectSale(
        userId: _userId,
        startupId: widget.startupId,
        quantity: _selectedQuantity,
        pricePerToken: _pricePerToken,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Venda executada com sucesso!')),
        );

        // Recarregar dados
        await _loadPortfolio();
        await _loadWalletBalance();
        await _loadTransactionHistory();

        // Limpar formulário
        setState(() {
          _selectedQuantity = 1;
          _pricePerToken = 0.0;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro na venda: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _createListing() async {
    if (_selectedQuantity <= 0 || _pricePerToken <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados inválidos')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _saleService.createSaleOffer(
        userId: _userId,
        startupId: widget.startupId,
        quantity: _selectedQuantity,
        pricePerToken: _pricePerToken,
        saleType: 'LISTING',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Oferta criada com sucesso!')),
        );

        await _loadAvailableOffers();

        setState(() {
          _selectedQuantity = 1;
          _pricePerToken = 0.0;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao criar oferta: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _buyFromOffer(SaleOffer offer, int quantity) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _saleService.executePurchaseFromListing(
        buyerId: _userId,
        offerId: offer.id,
        quantity: quantity,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Compra executada com sucesso!')),
        );

        await Future.wait([
          _loadPortfolio(),
          _loadAvailableOffers(),
          _loadWalletBalance(),
          _loadTransactionHistory(),
        ]);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro na compra: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.startupName} - Negociação de Tokens'),
        actions: [
          IconButton(
            icon: const Icon(Icons.trending_up),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StartupValuationScreen(
                    startupId: widget.startupId,
                    startupName: widget.startupName,
                  ),
                ),
              );
            },
            tooltip: 'Ver Valorização',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Vender Direto'),
            Tab(text: 'Listar'),
            Tab(text: 'Comprar'),
            Tab(text: 'Histórico'),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _initializeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildDirectSaleTab(),
              _buildListingTab(),
              _buildBuyTab(),
              _buildHistoryTab(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDirectSaleTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Informações do portfólio
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seu Portfólio',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Tokens Disponíveis'),
                          Text(
                            '${_userPortfolio?.tokenQuantity ?? 0}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Valor Total'),
                          Text(
                            'R\$ ${(_userPortfolio?.currentValue ?? 0).toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Informações da carteira
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sua Carteira',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Saldo: R\$ ${_walletBalance.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Formulário de venda direta
          Text(
            'Vender Direto',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Quantidade de Tokens',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _selectedQuantity = int.tryParse(value) ?? 0;
              });
            },
          ),
          const SizedBox(height: 16),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Preço por Token (R\$)',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _pricePerToken = double.tryParse(value) ?? 0.0;
              });
            },
          ),
          const SizedBox(height: 16),

          // Resumo da transação
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resumo da Venda',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Quantidade:'),
                      Text('$_selectedQuantity tokens'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Preço Unitário:'),
                      Text('R\$ ${_pricePerToken.toStringAsFixed(2)}'),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total a Receber:',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        'R\$ ${(_selectedQuantity * _pricePerToken).toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Botão de venda
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _executeDirectSale,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green,
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : const Text(
                      'Vender Agora',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Criar Listagem',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tokens Disponíveis: ${_userPortfolio?.tokenQuantity ?? 0}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Quantidade de Tokens',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedQuantity = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Preço por Token (R\$)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _pricePerToken = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _createListing,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blue,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : const Text(
                              'Listar Tokens',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuyTab() {
    if (_availableOffers.isEmpty) {
      return const Center(
        child: Text('Nenhuma oferta disponível'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _availableOffers.length,
      itemBuilder: (context, index) {
        final offer = _availableOffers[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Oferta #${offer.id.substring(0, 8)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'R\$ ${offer.pricePerToken.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Tokens Disponíveis: ${offer.quantity - (offer as dynamic)['reservedQuantity'] ?? 0}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Total: R\$ ${offer.totalValue.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () => _buyFromOffer(
                              offer,
                              (offer.quantity -
                                  ((offer as dynamic)['reservedQuantity'] ?? 0)).toInt(),
                            ),
                    child: const Text('Comprar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHistoryTab() {
    if (_transactionHistory.isEmpty) {
      return const Center(
        child: Text('Nenhuma transação registrada'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _transactionHistory.length,
      itemBuilder: (context, index) {
        final tx = _transactionHistory[index];
        final isSell = tx.sellerId == _userId;

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isSell ? 'Venda' : 'Compra',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: isSell ? Colors.green : Colors.red,
                          ),
                    ),
                    Text(
                      '${tx.quantity} tokens',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Preço Unitário:'),
                    Text('R\$ ${tx.pricePerToken.toStringAsFixed(2)}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:'),
                    Text(
                      'R\$ ${tx.totalValue.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSell ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Data: ${tx.executedAt.toString().substring(0, 19)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
