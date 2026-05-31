// feito por camila fernandes costacurta RA:25012949

// Importa os widgets básicos e o framework Material Design
import 'package:flutter/material.dart';
// Importa serviços do sistema como formatadores e vibração
import 'package:flutter/services.dart';
// Importa a biblioteca para utilização de fontes personalizadas do Google
import 'package:google_fonts/google_fonts.dart';
// Importa a biblioteca para criação de gráficos estatísticos
import 'package:fl_chart/fl_chart.dart';
// Importa o suporte para chamadas de funções serverless do Firebase
import 'package:cloud_functions/cloud_functions.dart';
// Importa o cliente para o banco de dados NoSQL Cloud Firestore
import 'package:cloud_firestore/cloud_firestore.dart';
// Importa o sistema de autenticação de usuários do Firebase
import 'package:firebase_auth/firebase_auth.dart';

// Importa utilitários para formatação de datas e moedas internacionais
import 'package:intl/intl.dart';

// Define a classe principal da página como um widget que possui estado
class BalcaoNegociacaoPage extends StatefulWidget {
  // Construtor da classe com suporte a chaves para identificação do widget
  const BalcaoNegociacaoPage({super.key});

  // Sobrescreve o método para criar o estado interno da página
  @override
  State<BalcaoNegociacaoPage> createState() => _BalcaoNegociacaoPageState();
}

// Define a classe de estado privada que gerencia a lógica da página
class _BalcaoNegociacaoPageState extends State<BalcaoNegociacaoPage> {
  // Variável que armazena o valor do filtro de setor selecionado pelo usuário
  String _filtroSelecionado = 'Todas';

  // Método responsável por exibir o diálogo de seleção de filtros de setor
  void _abrirFiltros() {
    // Exibe um alerta na tela usando o contexto atual
    showDialog(
      context: context,
      // Constrói o conteúdo visual do diálogo de alerta
      builder: (context) {
        // Retorna um widget de diálogo com bordas arredondadas
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          // Define o título do diálogo com estilo negrito
          title: const Text(
            "Filtrar por Setor",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Organiza os elementos internos do diálogo em uma coluna compacta
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Adiciona um espaçamento vertical de 10 pixels
              const SizedBox(height: 10),
              // Organiza as opções de filtro em uma disposição flexível (Wrap)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                // Mapeia a lista de strings para widgets de escolha (ChoiceChip)
                children:
                    [
                      'Todas',
                      'Agronegócio',
                      'Tecnologia',
                      'Sustentabilidade',
                      'Saúde',
                      'Educação',
                    ].map((label) {
                      // Verifica se o item atual é o que está selecionado
                      final bool isSelected = _filtroSelecionado == label;
                      // Retorna o widget de chip configurado com a ação de seleção
                      return ChoiceChip(
                        label: Text(label),
                        selected: isSelected,
                        // Atualiza o estado e fecha o diálogo ao selecionar
                        onSelected: (selected) {
                          setState(() {
                            _filtroSelecionado = label;
                          });
                          Navigator.pop(context);
                        },
                        // Define a cor roxa para o item selecionado
                        selectedColor: const Color(0xFF512DA8),
                        // Define a cor do texto baseada na seleção
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
          // Define os botões de ação na parte inferior do diálogo
          actions: [
            // Botão para fechar o diálogo sem realizar alterações extras
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fechar", style: TextStyle(color: Colors.grey)),
            ),
          ],
        );
      },
    );
  }

  // Sobrescreve o método principal de construção da interface visual
  @override
  // Método central onde a interface do widget é descrita
  Widget build(BuildContext context) {
    return Scaffold(
      // Define a cor de fundo cinza claro para toda a tela
      backgroundColor: const Color(0xFFF8F9FB),
      // Define a barra superior da aplicação
      appBar: AppBar(
        // Define a cor de fundo branca para a barra superior
        backgroundColor: Colors.white,
        // Remove a sombra abaixo da barra superior
        elevation: 0,
        // Centraliza o título da barra superior
        centerTitle: true,
        // Define o título da página com a fonte Montserrat em negrito
        title: Text(
          'BALCÃO DE NEGOCIAÇÕES',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.black,
          ),
        ),
        // Adiciona um botão de ícone para abrir os filtros
        actions: [
          // Widget de botão que exibe um ícone e executa uma ação
          IconButton(
            // Define o ícone de ajuste (tune) na cor preta
            icon: const Icon(Icons.tune, color: Colors.black),
            // Chama o método _abrirFiltros ao ser pressionado
            onPressed: _abrirFiltros,
          ),
        ],
      ),
      // Organiza o conteúdo principal da tela em uma coluna
      body: Column(
        children: [
          // Exibe a etiqueta de filtro ativo se for diferente de 'Todas'
          if (_filtroSelecionado != 'Todas')
            // Adiciona preenchimento em volta da etiqueta de filtro
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              // Exibe o rótulo e o chip do filtro em uma linha
              child: Row(
                children: [
                  // Exibe o texto estático informativo
                  Text(
                    "Filtrado por: ",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  // Chip que permite remover o filtro atual ao clicar no 'X'
                  Chip(
                    // Exibe o nome do filtro selecionado
                    label: Text(
                      _filtroSelecionado,
                      style: const TextStyle(fontSize: 10),
                    ),
                    // Reseta o filtro para 'Todas' ao clicar no ícone de exclusão
                    onDeleted: () =>
                        setState(() => _filtroSelecionado = 'Todas'),
                  ),
                ],
              ),
            ),
          // Faz com que a lista de startups ocupe o espaço restante
          Expanded(
            // Busca a lista de startups do Firestore uma única vez
            child: FutureBuilder<QuerySnapshot>(
              // Define a fonte de dados como a coleção 'startups'
              future: FirebaseFirestore.instance.collection('startups').get(),
              // Constrói a interface com base no estado da busca de startups
              builder: (context, startupsSnap) {
                // Exibe um indicador de carregamento enquanto os dados não chegam
                if (!startupsSnap.hasData)
                  return const Center(child: CircularProgressIndicator());

                final currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser == null) return const SizedBox.shrink();

                return StreamBuilder<QuerySnapshot>(
                  // Define o fluxo de dados em tempo real da coleção 'exchange'
                  stream: FirebaseFirestore.instance
                      .collection('exchange')
                      .snapshots(),
                  // Constrói a interface com base nos dados de mercado
                  builder: (context, exchangeSnap) {
                    // Exibe carregamento se os dados de mercado não estiverem prontos
                    if (!exchangeSnap.hasData)
                      return const Center(child: CircularProgressIndicator());
                    // Define o fluxo de dados de investimentos se o usuário estiver logado
                    final investStream = FirebaseFirestore.instance
                        .collection('users')
                        .doc(currentUser.uid)
                        .collection('investimentos')
                        .snapshots();

                    // Monitora os investimentos do usuário em tempo real
                    return StreamBuilder<QuerySnapshot>(
                      // Define o fluxo de dados de investimentos do usuário
                      stream: investStream,
                      // Une todos os dados (startups, mercado e investimentos)
                      builder: (context, investSnap) {
                        // Extrai as listas de documentos dos snapshots recebidos
                        final startupsDocs = startupsSnap.data!.docs;
                        final exchangeDocs = exchangeSnap.data!.docs;
                        final investDocs = investSnap.data?.docs ?? [];

                        // Inicializa a lista que conterá os dados combinados e processados
                        final List<Map<String, dynamic>> combinedList = [];

                        // Itera sobre cada startup para montar o objeto de dados completo
                        for (var s in startupsDocs) {
                          // Converte os dados brutos do documento da startup em um mapa
                          final sData = s.data() as Map<String, dynamic>;
                          // Busca os dados de mercado correspondentes ao ID da startup
                          final ex =
                              exchangeDocs
                                      .where((e) => e.id == s.id)
                                      .firstOrNull
                                      ?.data()
                                  as Map<String, dynamic>?;
                          // Busca os dados de investimento do usuário para esta startup específica
                          final inv =
                              investDocs
                                      .where((i) => i.id == s.id)
                                      .firstOrNull
                                      ?.data()
                                  as Map<String, dynamic>?;

                          // Define o preço atual vindo do mercado ou o preço base da startup
                          final preco =
                              ex?['precoAtual'] ??
                              (sData['currentTokenPriceCents'] ?? 0) / 100.0;
                          // Define a quantidade de tokens que o usuário possui desta startup
                          final qtd = inv?['tokensComprados'] ?? 0;
                          // Converte e extrai a variação percentual do preço
                          final double variacao = (ex?['variacao'] ?? 0.0)
                              .toDouble();

                          // Define a variável para o ticker (código de negociação)
                          String ticker = s.id.toUpperCase();
                          // Mapeia IDs internos para tickers personalizados amigáveis ao mercado
                          switch (s.id) {
                            // Caso Agrisense, define o ticker AGRI3
                            case 'agrisense':
                              ticker = 'AGRI3';
                              break;
                            // Caso Devmatch, define o ticker DEVM3
                            case 'devmatch':
                              ticker = 'DEVM3';
                              break;
                            // Caso Ecocycle, define o ticker ECYC1
                            case 'ecocycle':
                              ticker = 'ECYC1';
                              break;
                            // Caso Healthbit, define o ticker HBIT3
                            case 'healthbit':
                              ticker = 'HBIT3';
                              break;
                            // Caso Smartcampus, define o ticker SCMP3
                            case 'smartcampus':
                              ticker = 'SCMP3';
                              break;
                          }

                          // Adiciona o mapa de dados processados da startup à lista combinada
                          combinedList.add({
                            'nome': sData['name'] ?? 'Desconhecido',
                            'ticker': ticker,
                            'logo':
                                sData['coverImageUrl'] ??
                                'assets/images/logos/logotipoAgriSense.png',
                            'preco': preco.toDouble(),
                            'valorizacao': variacao > 0
                                ? '+${variacao.toStringAsFixed(1)}%'
                                : '${variacao.toStringAsFixed(1)}%',
                            'qtd': qtd,
                            'setor': sData['tags']?.isNotEmpty == true
                                ? sData['tags'][0]
                                : 'Desconhecido',
                            'id': s.id,
                          });
                        }

                        // Filtra a lista combinada baseada no setor selecionado pelo usuário
                        final listaFiltrada = _filtroSelecionado == 'Todas'
                            // Se 'Todas' estiver selecionado, mantém a lista completa
                            ? combinedList
                            // Caso contrário, filtra os itens que correspondem ao setor
                            : combinedList.where((s) {
                                // Normaliza o nome do setor para comparação em minúsculas
                                final setor = (s['setor'] as String)
                                    .toLowerCase();
                                // Normaliza o filtro selecionado para comparação em minúsculas
                                final filtro = _filtroSelecionado.toLowerCase();
                                // Aproximação de filtro pois os dados do firebase são tags em inglês/outros
                                // Verifica se o filtro é Agronegócio e o setor contém a palavra 'agro'
                                if (filtro == 'agronegócio' &&
                                    setor.contains('agro'))
                                  return true;
                                // Verifica se o filtro é Tecnologia e o setor contém a palavra 'tech'
                                if (filtro == 'tecnologia' &&
                                    setor.contains('tech'))
                                  return true;
                                // Verifica se o filtro é Sustentabilidade e o setor contém palavras relacionadas
                                if (filtro == 'sustentabilidade' &&
                                    (setor.contains('clean') ||
                                        setor.contains('green')))
                                  return true;
                                // Verifica se o filtro é Saúde e o setor contém a palavra 'health'
                                if (filtro == 'saúde' &&
                                    setor.contains('health'))
                                  return true;
                                // Verifica se o filtro é Educação e o setor contém a palavra 'edtech'
                                if (filtro == 'educação' &&
                                    setor.contains('edtech'))
                                  return true;
                                // Retorno padrão comparando a string exata do setor com o filtro
                                return s['setor'] == _filtroSelecionado;
                              }).toList();

                        // Verifica se a lista filtrada está vazia para exibir mensagem de erro
                        return listaFiltrada.isEmpty
                            // Retorna um widget centralizado informando que nada foi encontrado
                            ? Center(
                                // Organiza o ícone e a mensagem em uma coluna vertical
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Exibe um ícone de busca sem resultados em cinza claro
                                    Icon(
                                      Icons.search_off,
                                      size: 64,
                                      color: Colors.grey.shade300,
                                    ),
                                    // Adiciona um espaçamento vertical de 16 pixels
                                    const SizedBox(height: 16),
                                    // Exibe o texto informativo de "Nenhuma startup encontrada"
                                    Text(
                                      "Nenhuma startup encontrada\nneste setor.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            // Retorna a lista de startups se houver itens para exibir
                            : ListView.builder(
                                // Adiciona um preenchimento interno de 20 pixels em todos os lados
                                padding: const EdgeInsets.all(20),
                                // Define a quantidade total de itens na lista
                                itemCount: listaFiltrada.length,
                                // Constrói cada item da lista baseado no índice
                                itemBuilder: (context, index) {
                                  // Obtém os dados da startup correspondente ao índice atual
                                  final startup = listaFiltrada[index];
                                  // Calcula o valor total investido pelo usuário nesta startup
                                  final double total =
                                      startup['preco'] * startup['qtd'];

                                  // Widget que detecta toques e navega para a tela de detalhes
                                  return GestureDetector(
                                    onTap: () {
                                      // Executa a navegação para a tela AssetDetailsScreen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          // Passa os dados da startup como parâmetro para a nova tela
                                          builder: (context) =>
                                              AssetDetailsScreen(
                                                startup: startup,
                                              ),
                                        ),
                                      );
                                    },
                                    // Container principal que estiliza o cartão da startup
                                    child: Container(
                                      // Adiciona uma margem inferior de 16 pixels entre os cartões
                                      margin: const EdgeInsets.only(bottom: 16),
                                      // Adiciona preenchimento interno de 16 pixels no cartão
                                      padding: const EdgeInsets.all(16),
                                      // Define a decoração visual com fundo branco e bordas arredondadas
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        // Adiciona uma sombra suave para dar profundidade ao cartão
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.04,
                                            ),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      // Organiza o conteúdo do cartão em uma coluna
                                      child: Column(
                                        children: [
                                          // Primeira linha contendo logo, ticker e preço
                                          Row(
                                            children: [
                                              // Container que envolve o logotipo da startup
                                              Container(
                                                width: 48,
                                                height: 48,
                                                // Estiliza o fundo do logo em cinza quase branco
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[50],
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                // Recorta a imagem para respeitar as bordas arredondadas
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  // Carrega a imagem da internet ou dos ativos locais
                                                  child:
                                                      startup['logo']
                                                          .toString()
                                                          .startsWith('http')
                                                      // Se for URL, utiliza Image.network
                                                      ? Image.network(
                                                          startup['logo'],
                                                          fit: BoxFit.contain,
                                                          // Exibe ícone de fallback em caso de erro no carregamento
                                                          errorBuilder:
                                                              (
                                                                context,
                                                                error,
                                                                stackTrace,
                                                              ) => const Icon(
                                                                Icons.business,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                        )
                                                      // Se for caminho local, utiliza Image.asset
                                                      : Image.asset(
                                                          'assets/images/logos/${startup['logo']}',
                                                          fit: BoxFit.contain,
                                                          // Tenta carregar o caminho alternativo se o primeiro falhar
                                                          errorBuilder:
                                                              (
                                                                context,
                                                                error,
                                                                stackTrace,
                                                              ) => Image.asset(
                                                                startup['logo'],
                                                                fit: BoxFit
                                                                    .contain,
                                                                // Exibe ícone de fallback final
                                                                errorBuilder:
                                                                    (
                                                                      context,
                                                                      error,
                                                                      stackTrace,
                                                                    ) => const Icon(
                                                                      Icons
                                                                          .business,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                              ),
                                                        ),
                                                ),
                                              ),
                                              // Adiciona um espaçamento horizontal de 12 pixels
                                              const SizedBox(width: 12),
                                              // Expande o conteúdo de texto para ocupar o espaço central
                                              Expanded(
                                                // Organiza ticker e nome da startup em uma coluna
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Exibe o ticker da startup em negrito
                                                    Text(
                                                      startup['ticker'],
                                                      style:
                                                          GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                    ),
                                                    // Exibe o nome completo da startup em cinza
                                                    Text(
                                                      startup['nome'],
                                                      style:
                                                          GoogleFonts.montserrat(
                                                            fontSize: 12,
                                                            color: Colors
                                                                .grey[600],
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Coluna da direita contendo preço e valorização
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  // Exibe o preço unitário atual formatado em Reais
                                                  Text(
                                                    'R\$ ${startup['preco'].toStringAsFixed(2)}',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                  // Exibe a porcentagem de valorização em verde negrito
                                                  Text(
                                                    startup['valorizacao'],
                                                    style:
                                                        GoogleFonts.montserrat(
                                                          fontSize: 12,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          // Desenha uma linha divisória horizontal no cartão
                                          const Divider(height: 24),
                                          // Linha inferior contendo quantidade e valor total investido
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Exibe a quantidade de tokens possuída pelo usuário
                                              Text(
                                                'Qtd: ${startup['qtd']}',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              // Exibe o valor total financeiro da posição em roxo negrito
                                              Text(
                                                'Total: R\$ ${total.toStringAsFixed(2)}',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color(
                                                    0xFF512DA8,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Define a tela de detalhes do ativo como um widget com estado
class AssetDetailsScreen extends StatefulWidget {
  // Declara uma variável final para armazenar os dados da startup
  final Map<String, dynamic> startup;
  // Construtor da tela que exige os dados da startup e suporta chaves
  const AssetDetailsScreen({super.key, required this.startup});

  // Sobrescreve o método para criar o estado interno desta tela
  @override
  // Retorna uma nova instância do estado privado da tela de detalhes
  State<AssetDetailsScreen> createState() => _AssetDetailsScreenState();
}

// Define a classe de estado privada para gerenciar a lógica dos detalhes
class _AssetDetailsScreenState extends State<AssetDetailsScreen> {
  // Variável para controlar o período selecionado no gráfico de variação
  String _selectedPeriod = 'Diário';
  // Controlador para gerenciar o texto inserido no campo de quantidade
  final TextEditingController _quantidadeController = TextEditingController();
  // Booleano para indicar se uma operação assíncrona está em progresso
  bool _isLoading = false;
  // Booleano para alternar entre visualizar poucas ou todas as transações
  bool _verTodos = false;

  // --- ESTRUTURA PARA O BACKEND ---
  // Seu amigo vai substituir essas listas estáticas por dados do Firebase/API

  // Método chamado quando o widget é removido permanentemente da árvore
  @override
  void dispose() {
    // Libera os recursos do controlador de texto para evitar vazamentos
    _quantidadeController.dispose();
    // Chama a implementação da classe pai para finalizar o descarte
    super.dispose();
  }

  // Método auxiliar para converter tickers amigáveis em IDs do banco
  String _getStartupId(String ticker) {
    // Avalia o ticker fornecido para retornar o ID correspondente
    switch (ticker) {
      // Caso seja AGRI3, retorna o identificador interno agrisense
      case 'AGRI3':
        return 'agrisense';
      // Caso seja DEVM3, retorna o identificador interno devmatch
      case 'DEVM3':
        return 'devmatch';
      // Caso seja ECYC1, retorna o identificador interno ecocycle
      case 'ECYC1':
        return 'ecocycle';
      // Caso seja HBIT3, retorna o identificador interno healthbit
      case 'HBIT3':
        return 'healthbit';
      // Caso seja SCMP3, retorna o identificador interno smartcampus
      case 'SCMP3':
        return 'smartcampus';
      // Retorno padrão caso o ticker não seja reconhecido
      default:
        return 'agrisense';
    }
  }

  // Integração real com a Cloud Function exchange-buyTokens (AMM)
  // Método para abrir o painel inferior de investimento em tokens
  void _abrirModalInvestir() {
    // Reseta o estado de carregamento para falso ao iniciar
    _isLoading = false;
    // Limpa o conteúdo do campo de texto da quantidade
    _quantidadeController.clear();
    // Exibe uma folha modal que desliza da parte inferior da tela
    showModalBottomSheet(
      // Utiliza o contexto atual para posicionar o modal
      context: context,
      // Permite que o modal ocupe mais espaço se necessário (teclado)
      isScrollControlled: true,
      // Define o estilo visual com bordas arredondadas no topo
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      // Constrói o conteúdo interno do painel inferior
      builder: (bottomSheetContext) {
        // Widget que permite gerenciar estado local dentro do modal
        return StatefulBuilder(
          // Construtor que fornece uma função específica para atualizar o modal
          builder: (builderContext, setModalState) {
            // Adiciona preenchimento para evitar sobreposição com o teclado
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
              ),
              // Container principal que agrupa os elementos do modal
              child: Container(
                padding: const EdgeInsets.all(24),
                // Organiza os campos e botões em uma coluna vertical
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Exibe o título dinâmico com o ticker da startup
                    Text(
                      "Investir em ${widget.startup['ticker']}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Adiciona um espaçamento vertical de 20 pixels
                    const SizedBox(height: 20),
                    // Campo de entrada de texto para o usuário digitar a quantidade
                    TextField(
                      controller: _quantidadeController,
                      // Configura a decoração visual do campo de entrada
                      decoration: InputDecoration(
                        labelText: "Quantidade de Tokens",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.add_chart),
                      ),
                      // Define o tipo de teclado como numérico
                      keyboardType: TextInputType.number,
                    ),
                    // Adiciona um espaçamento vertical de 20 pixels
                    const SizedBox(height: 20),
                    // Widget que expande o botão para ocupar toda a largura
                    SizedBox(
                      width: double.infinity,
                      // Botão de ação para confirmar o investimento
                      child: ElevatedButton(
                        // Define o estilo visual do botão (cor roxa)
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF512DA8),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        // Define a ação de clique, desabilitada se estiver carregando
                        onPressed: _isLoading
                            ? null
                            : () async {
                                // Sanitiza o texto da quantidade substituindo vírgulas
                                final quantidadeTexto = _quantidadeController
                                    .text
                                    .replaceAll(',', '.');
                                // Tenta converter o texto sanitizado em um número inteiro
                                final quantidade =
                                    int.tryParse(quantidadeTexto) ?? 0;

                                // Valida se a quantidade inserida é maior que zero
                                if (quantidade <= 0) {
                                  // Exibe uma mensagem de erro se a quantidade for inválida
                                  ScaffoldMessenger.of(
                                    builderContext,
                                  ).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Informe uma quantidade válida (número inteiro > 0).',
                                      ),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                  // Interrompe a execução do método
                                  return;
                                }

                                // Atualiza o estado do modal para exibir o carregamento
                                setModalState(() => _isLoading = true);

                                try {
                                  // Obtém o ID interno da startup via ticker
                                  final startupId = _getStartupId(
                                    widget.startup['ticker'],
                                  );
                                  // Prepara a chamada para a função serverless de compra
                                  final callable = FirebaseFunctions.instance
                                      .httpsCallable('exchange-buyTokens');
                                  // Executa a função remota com os parâmetros necessários
                                  await callable.call({
                                    'startupId': startupId,
                                    'quantidade': quantidade,
                                  });

                                  // Verifica se o widget ainda está ativo antes de prosseguir
                                  if (!mounted) return;
                                  // Fecha o modal de investimento após o sucesso
                                  Navigator.pop(builderContext);
                                  // Exibe uma notificação de sucesso para o usuário
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Ordem de compra executada com sucesso!',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  // Captura erros específicos vindos do Firebase Functions
                                } on FirebaseFunctionsException catch (e) {
                                  // Remove o estado de carregamento em caso de falha
                                  setModalState(() => _isLoading = false);
                                  // Verifica se o widget ainda está ativo
                                  if (!mounted) return;
                                  // Exibe o erro detalhado retornado pelo servidor
                                  ScaffoldMessenger.of(
                                    builderContext,
                                  ).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        e.message ??
                                            e.details?.toString() ??
                                            'Erro na transação.',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  // Captura qualquer outro erro genérico
                                } catch (e) {
                                  // Remove o estado de carregamento
                                  setModalState(() => _isLoading = false);
                                  // Verifica se o widget ainda está ativo
                                  if (!mounted) return;
                                  // Exibe a descrição do erro inesperado
                                  ScaffoldMessenger.of(
                                    builderContext,
                                  ).showSnackBar(
                                    SnackBar(
                                      content: Text('Erro inesperado: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                        // Define o conteúdo do botão baseado no estado de carregamento
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                // Exibe um círculo de progresso se estiver processando
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                "Confirmar Compra",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Integração real com a Cloud Function exchange-sellTokens (AMM)
  // Método para abrir o painel inferior de venda de tokens
  void _abrirModalVender() {
    // Reseta o estado de carregamento para falso ao iniciar
    _isLoading = false;
    // Limpa o conteúdo do campo de texto da quantidade
    _quantidadeController.clear();
    // Exibe uma folha modal que desliza da parte inferior da tela
    showModalBottomSheet(
      // Utiliza o contexto atual para posicionar o modal
      context: context,
      // Permite que o modal ocupe mais espaço se necessário (teclado)
      isScrollControlled: true,
      // Define o estilo visual com bordas arredondadas no topo
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      // Constrói o conteúdo interno do painel inferior
      builder: (bottomSheetContext) {
        // Widget que permite gerenciar estado local dentro do modal
        return StatefulBuilder(
          // Construtor que fornece uma função específica para atualizar o modal
          builder: (builderContext, setModalState) {
            // Adiciona preenchimento para evitar sobreposição com o teclado
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
              ),
              // Container principal que agrupa os elementos do modal
              child: Container(
                padding: const EdgeInsets.all(24),
                // Organiza os campos e botões em uma coluna vertical
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Exibe o título dinâmico com o ticker da startup
                    Text(
                      "Vender ${widget.startup['ticker']}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Adiciona um espaçamento vertical de 20 pixels
                    const SizedBox(height: 20),
                    // Campo de entrada de texto para o usuário digitar a quantidade
                    TextField(
                      controller: _quantidadeController,
                      // Configura a decoração visual do campo de entrada
                      decoration: InputDecoration(
                        labelText: "Quantidade de Tokens",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.sell),
                      ),
                      // Define o tipo de teclado como numérico
                      keyboardType: TextInputType.number,
                    ),
                    // Adiciona um espaçamento vertical de 20 pixels
                    const SizedBox(height: 20),
                    // Widget que expande o botão para ocupar toda a largura
                    SizedBox(
                      width: double.infinity,
                      // Botão de ação para confirmar a venda
                      child: ElevatedButton(
                        // Define o estilo visual do botão (cor vermelha para venda)
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700],
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        // Define a ação de clique, desabilitada se estiver carregando
                        onPressed: _isLoading
                            ? null
                            : () async {
                                // Sanitiza o texto da quantidade substituindo vírgulas
                                final quantidadeTexto = _quantidadeController
                                    .text
                                    .replaceAll(',', '.');
                                // Tenta converter o texto sanitizado em um número inteiro
                                final quantidade =
                                    int.tryParse(quantidadeTexto) ?? 0;

                                // Valida se a quantidade inserida é maior que zero
                                if (quantidade <= 0) {
                                  // Exibe uma mensagem de erro se a quantidade for inválida
                                  ScaffoldMessenger.of(
                                    builderContext,
                                  ).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Informe uma quantidade válida (número inteiro > 0).',
                                      ),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                  // Interrompe a execução do método
                                  return;
                                }

                                // Atualiza o estado do modal para exibir o carregamento
                                setModalState(() => _isLoading = true);

                                try {
                                  // Obtém o ID interno da startup via ticker
                                  final startupId = _getStartupId(
                                    widget.startup['ticker'],
                                  );
                                  // Prepara a chamada para a função serverless de venda
                                  final callable = FirebaseFunctions.instance
                                      .httpsCallable('exchange-sellTokens');
                                  // Executa a função remota com os parâmetros necessários
                                  await callable.call({
                                    'startupId': startupId,
                                    'quantidade': quantidade,
                                  });

                                  // Verifica se o widget ainda está ativo antes de prosseguir
                                  if (!mounted) return;
                                  // Fecha o modal de venda após o sucesso
                                  Navigator.pop(builderContext);
                                  // Exibe uma notificação de sucesso para o usuário
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Venda realizada com sucesso!',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  // Captura erros específicos vindos do Firebase Functions
                                } on FirebaseFunctionsException catch (e) {
                                  // Remove o estado de carregamento em caso de falha
                                  setModalState(() => _isLoading = false);
                                  // Verifica se o widget ainda está ativo
                                  if (!mounted) return;
                                  // Exibe o erro detalhado retornado pelo servidor
                                  ScaffoldMessenger.of(
                                    builderContext,
                                  ).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        e.message ??
                                            e.details?.toString() ??
                                            'Erro na transação.',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  // Captura qualquer outro erro genérico
                                } catch (e) {
                                  // Remove o estado de carregamento
                                  setModalState(() => _isLoading = false);
                                  // Verifica se o widget ainda está ativo
                                  if (!mounted) return;
                                  // Exibe a descrição do erro inesperado
                                  ScaffoldMessenger.of(
                                    builderContext,
                                  ).showSnackBar(
                                    SnackBar(
                                      content: Text('Erro inesperado: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                        // Define o conteúdo do botão baseado no estado de carregamento
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                // Exibe um círculo de progresso se estiver processando
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                "Confirmar Venda",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Sobrescreve o método de construção da interface visual da tela
  @override
  Widget build(BuildContext context) {
    // Retorna a estrutura básica da página com suporte a cores e temas
    return Scaffold(
      backgroundColor: Colors.white,
      // Define a barra superior com botão de voltar e título
      appBar: AppBar(
        // Adiciona um botão de ícone para retornar à tela anterior
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          // Executa a navegação de retorno ao ser pressionado
          onPressed: () => Navigator.pop(context),
        ),
        // Define o título da barra com o nome da startup
        title: Text(
          widget.startup['nome'],
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      // Permite a rolagem do conteúdo caso ultrapasse o tamanho da tela
      body: SingleChildScrollView(
        // Organiza os componentes em uma coluna vertical
        child: Column(
          children: [
            // Adiciona um espaçamento vertical inicial de 20 pixels
            const SizedBox(height: 20),
            // Valor grande do Token
            // Widget que reconstrói parte da UI com base em fluxos de dados do Firestore
            StreamBuilder<DocumentSnapshot>(
              // Define o fluxo de dados baseado no investimento do usuário atual
              stream: FirebaseAuth.instance.currentUser != null
                  ? FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('investimentos')
                        .doc(
                          widget.startup['id'] ??
                              _getStartupId(widget.startup['ticker']),
                        )
                        .snapshots()
                  : const Stream.empty(),
              // Construtor da interface baseada no estado do snapshot de dados
              builder: (context, snapshot) {
                // Calcula a quantidade real de tokens possuídos pelo usuário
                final qtdReal = snapshot.data?.data() != null
                    ? (snapshot.data!.data()
                              as Map<String, dynamic>)['tokensComprados'] ??
                          0
                    : widget.startup['qtd'];

                // Extrai o preço atual do ativo
                final precoAtual = widget.startup['preco'] as double;
                // Calcula o valor financeiro total da posição do usuário
                final valorTotal = precoAtual * qtdReal;

                // Retorna uma coluna com as informações de quantidade e valor
                return Column(
                  children: [
                    // Exibe a quantidade de tokens com formatação plural/singular
                    Text(
                      "$qtdReal ${qtdReal == 1 ? 'Token' : 'Tokens'}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF512DA8),
                      ),
                    ),
                    // Adiciona um espaçamento vertical de 8 pixels
                    const SizedBox(height: 8),
                    // Organiza as informações de preço unitário e total em uma linha
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Exibe o preço atual por token formatado em Reais
                          Text(
                            "R\$ ${precoAtual.toStringAsFixed(2)} por token",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          // Adiciona um espaçamento horizontal de 16 pixels
                          const SizedBox(width: 16),
                          // Desenha uma linha vertical separadora
                          Container(width: 1, height: 18, color: Colors.black),
                          // Adiciona um espaçamento horizontal de 16 pixels
                          const SizedBox(width: 16),
                          // Exibe o valor total investido formatado em Reais
                          Text(
                            "R\$ ${valorTotal.toStringAsFixed(2)} total",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Adiciona um pequeno espaçamento vertical de 6 pixels
                    const SizedBox(height: 6),
                  ],
                );
              },
            ),
            // Adiciona um espaçamento vertical de 30 pixels
            const SizedBox(height: 30),

            // 1. Botões com Funções Implementadas
            // Organiza os botões de ação (Investir/Vender) em uma linha centralizada
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Constrói o botão de ação para Investir
                _buildActionButton(
                  Icons.auto_graph,
                  "Investir",
                  _abrirModalInvestir,
                ),
                // Adiciona um espaçamento horizontal largo entre os botões
                const SizedBox(width: 40),
                // Constrói o botão de ação para Vender
                _buildActionButton(Icons.sell, "Vender", _abrirModalVender),
              ],
            ),

            // Adiciona um espaçamento vertical de 30 pixels
            const SizedBox(height: 30),

            // 2. Dashboard preparado para novos valores
            // Chama o método para construir o gráfico de variação e dashboard
            _buildDashboard(),

            // Adiciona um espaçamento vertical de 30 pixels
            const SizedBox(height: 30),

            // 3. Livro de Ofertas (Mantive sua estrutura de Table)
            // Chama o método para construir a tabela de ofertas do mercado
            _buildOrderBook(),

            // Adiciona um espaçamento vertical de 16 pixels
            const SizedBox(height: 16),
            // Posiciona o botão de contraproposta alinhado à esquerda
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                // Botão com borda e ícone para iniciar uma contraproposta
                child: OutlinedButton.icon(
                  onPressed: _abrirContrapropostaInfo,
                  icon: const Icon(
                    Icons.handshake_outlined,
                    color: Color(0xFF512DA8),
                    size: 16,
                  ),
                  // Define o rótulo do botão de contraproposta
                  label: const Text(
                    "Contraproposta",
                    style: TextStyle(
                      color: Color(0xFF512DA8),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  // Configura o estilo visual do botão contornado
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    side: const BorderSide(color: Color(0xFF512DA8)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),

            // Adiciona um espaçamento vertical de 30 pixels
            const SizedBox(height: 30),

            // 4. Histórico Dinâmico (Fácil para o Backend mudar)
            // Chama o método para construir a lista de histórico de transações
            _buildDynamicHistory(),
            // Adiciona um espaçamento vertical final de 20 pixels
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget de Dashboard (Gráfico + Seletor)
  // Método que constrói a seção de dashboard com gráfico e filtros temporais
  Widget _buildDashboard() {
    // Adiciona preenchimento horizontal de 20 pixels nas laterais
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // Organiza o título e o conteúdo em uma coluna vertical
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exibe o título da seção de variação do ativo em negrito
          const Text(
            "Variação do Ativo",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          // Adiciona um espaçamento vertical de 15 pixels
          const SizedBox(height: 15),
          // Permite a rolagem horizontal dos chips de período
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // Organiza as opções de período em uma linha
            child: Row(
              // Mapeia a lista de strings para widgets de escolha (ChoiceChip)
              children: ['Diário', 'Semanal', 'Mensal', '6 meses', 'YTD'].map((
                periodo,
              ) {
                // Adiciona um espaçamento à direita de cada chip
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  // Widget de escolha que destaca a opção selecionada
                  child: ChoiceChip(
                    // Define o rótulo de texto do chip com cor dinâmica
                    label: Text(
                      periodo,
                      style: TextStyle(
                        fontSize: 12,
                        color: _selectedPeriod == periodo
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    // Indica se este chip é o que está selecionado atualmente
                    selected: _selectedPeriod == periodo,
                    // Define a cor de fundo roxa para o chip selecionado
                    selectedColor: const Color(0xFF512DA8),
                    // Atualiza o estado da tela ao selecionar um novo período
                    onSelected: (selected) {
                      setState(() => _selectedPeriod = periodo);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          // Adiciona um espaçamento vertical de 20 pixels
          const SizedBox(height: 20),
          // Adiciona outro espaçamento vertical de 20 pixels
          const SizedBox(height: 20),
          // Widget que monitora em tempo real o histórico de preços no Firestore
          StreamBuilder<QuerySnapshot>(
            // Define a consulta ao banco de dados ordenada por data crescente
            stream: FirebaseFirestore.instance
                .collection('exchange')
                .doc(_getStartupId(widget.startup['ticker']))
                .collection('historicoPrecos')
                .orderBy('data', descending: false)
                .snapshots(),
            // Construtor da interface baseada nos dados do histórico
            builder: (context, snapshot) {
              // Exibe um carregador se os dados ainda estiverem sendo buscados
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              // Exibe uma mensagem de erro se a busca falhar
              if (snapshot.hasError) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: Text("Erro ao carregar gráfico")),
                );
              }

              // Extrai a lista de documentos do snapshot de dados
              final docs = snapshot.data?.docs ?? [];
              // Exibe aviso se não houver dados históricos disponíveis
              if (docs.isEmpty) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: Text("Sem dados históricos")),
                );
              }

              // Captura a data e hora atual do sistema
              final now = DateTime.now();
              // Variável para armazenar o ponto de corte temporal dos dados
              DateTime dataLimite;

              // Define a janela de tempo retroativa baseada no filtro selecionado
              switch (_selectedPeriod) {
                // Caso Diário: retrocede 7 dias
                case 'Diário':
                  dataLimite = now.subtract(const Duration(days: 7));
                  break;
                // Caso Semanal: retrocede 84 dias (aprox. 3 meses)
                case 'Semanal':
                  dataLimite = now.subtract(const Duration(days: 84));
                  break;
                // Caso Mensal: retrocede 30 dias
                case 'Mensal':
                  dataLimite = now.subtract(const Duration(days: 30));
                  break;
                // Caso 6 meses: retrocede 180 dias
                case '6 meses':
                  dataLimite = now.subtract(const Duration(days: 180));
                  break;
                // Caso YTD: retrocede até o início do ano corrente
                case 'YTD':
                  dataLimite = DateTime(now.year, 1, 1);
                  break;
                // Padrão: retrocede 7 dias
                default:
                  dataLimite = now.subtract(const Duration(days: 7));
              }

              // Filtra os documentos que estão dentro da janela de tempo definida
              final filteredDocs = docs.where((doc) {
                final data = doc['data'] as Timestamp;
                return data.toDate().isAfter(dataLimite) ||
                    data.toDate().isAtSameMomentAs(dataLimite);
              }).toList();

              // Inicializa a lista final de documentos que serão plotados
              List<QueryDocumentSnapshot> finalDocs = filteredDocs;
              // Aplica uma amostragem esparsa se o período for semanal
              if (_selectedPeriod == 'Semanal') {
                finalDocs = [];
                // Pega um dado a cada 7 registros para simplificar a visualização
                for (int i = 0; i < filteredDocs.length; i += 7) {
                  finalDocs.add(filteredDocs[i]);
                }
                // Garante que o último ponto disponível seja sempre incluído
                if (finalDocs.isNotEmpty &&
                    filteredDocs.isNotEmpty &&
                    finalDocs.last.id != filteredDocs.last.id) {
                  finalDocs.add(filteredDocs.last);
                }
              }

              // 1. Mapeamento Temporal — X = milissegundos do Timestamp
              // Converte os documentos filtrados em pontos de coordenadas do gráfico
              final spots = finalDocs.map((doc) {
                final data = (doc['data'] as Timestamp).toDate();
                final preco = (doc['preco'] as num).toDouble();
                return FlSpot(data.millisecondsSinceEpoch.toDouble(), preco);
              }).toList();

              // Exibe aviso se não houver pontos suficientes após a filtragem
              if (spots.isEmpty) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: Text("Sem dados para o período")),
                );
              }

              // 2. Cálculo de Escala — Padding de 5% no eixo Y
              // Extrai apenas os valores de preço para calcular os limites do eixo Y
              final precos = spots.map((s) => s.y).toList();
              // Identifica o menor preço registrado no período
              final precoMin = precos.reduce((a, b) => a < b ? a : b);
              // Identifica o maior preço registrado no período
              final precoMax = precos.reduce((a, b) => a > b ? a : b);
              // Calcula uma margem de segurança para o topo e base do gráfico
              final margemY = (precoMax - precoMin) * 0.05;
              // Define o valor mínimo do eixo Y, garantindo que não seja negativo
              final double chartMinY = (precoMin - margemY).clamp(
                0,
                double.infinity,
              );
              // Define o valor máximo do eixo Y com a margem aplicada
              final double chartMaxY = precoMax + margemY;

              // Limites do eixo X a partir dos dados reais
              // Define o início do eixo X como o primeiro ponto temporal
              final double chartMinX = spots.first.x;
              // Define o fim do eixo X como o último ponto temporal
              final double chartMaxX = spots.last.x;
              final double hInterval = (chartMaxY - chartMinY) == 0 
                  ? 1.0 
                  : (chartMaxY - chartMinY) / 4;
              final double xInterval = (chartMaxX - chartMinX) == 0 
                  ? 1.0 
                  : (chartMaxX - chartMinX) / 4;

              // Retorna o widget do gráfico de linha com altura fixa
              return SizedBox(
                height: 220,
                child: LineChart(
                  // Configura os dados e o comportamento visual do gráfico de linha
                  LineChartData(
                    minX: chartMinX,
                    maxX: chartMaxX,
                    minY: chartMinY,
                    maxY: chartMaxY,

                    // 5. Grid Visual Limpo — apenas linhas horizontais
                    // Define a configuração das linhas de grade do gráfico
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      drawHorizontalLine: true,
                      // Divide o eixo Y em 4 faixas horizontais
                      horizontalInterval: hInterval,
                      // Define o estilo visual das linhas horizontais
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.grey.withValues(alpha: 0.15),
                        strokeWidth: 0.5,
                      ),
                    ),

                    // 3 & 4. Eixos X (bottom) e Y (left) dinâmicos
                    // Configura os títulos e rótulos dos eixos do gráfico
                    titlesData: FlTitlesData(
                      // Oculta os títulos superiores do gráfico
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      // Oculta os títulos do lado direito do gráfico
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),

                      // Eixo X — Formatação contextual por _selectedPeriod
                      // Configura a exibição das datas no eixo inferior
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          // Define o intervalo de tempo entre as etiquetas do eixo X
                          interval: xInterval,
                          // Função para gerar os widgets de texto do eixo X
                          getTitlesWidget: (value, meta) {
                            // Evitar rótulos nas bordas extremas que cortam
                            if (value == meta.min || value == meta.max) {
                              return const SizedBox.shrink();
                            }
                            // Converte o valor numérico de volta para objeto de data
                            final dt = DateTime.fromMillisecondsSinceEpoch(
                              value.toInt(),
                            );
                            String label;
                            // Formata o rótulo conforme o período selecionado
                            if (_selectedPeriod == 'Diário') {
                              // Hora:minuto para a janela mais curta
                              label = DateFormat('HH:mm').format(dt);
                            } else if (_selectedPeriod == '6 meses' ||
                                _selectedPeriod == 'YTD') {
                              // Mês abreviado para janelas longas
                              label = DateFormat('MMM', 'pt_BR').format(dt);
                            } else {
                              // dia/mês para janelas intermediárias (Semanal, Mensal)
                              label = DateFormat('dd/MM').format(dt);
                            }
                            // Retorna o texto formatado com estilo cinza suave
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                label,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Eixo Y — Preço formatado em R$
                      // Configura a exibição dos preços no eixo lateral esquerdo
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 45,
                          // Define o intervalo de valores entre as etiquetas do eixo Y
                          interval: hInterval,
                          // Função para gerar os widgets de texto do eixo Y
                          getTitlesWidget: (value, meta) {
                            // Oculta valores que ficariam cortados nas bordas
                            if (value == meta.min || value == meta.max) {
                              return const SizedBox.shrink();
                            }
                            // Retorna o valor do preço formatado como moeda brasileira
                            return Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Text(
                                'R\$${value.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Oculta as bordas externas do quadro do gráfico
                    borderData: FlBorderData(show: false),
                    // Define os dados reais da linha do gráfico
                    lineBarsData: [
                      LineChartBarData(
                        // Lista de pontos que formam a linha
                        spots: spots,
                        // Suaviza a linha transformando-a em uma curva
                        isCurved: true,
                        // Define a cor roxa característica da aplicação
                        color: const Color(0xFF512DA8),
                        // Define a espessura da linha do gráfico
                        barWidth: 3,
                        // Oculta os pontos (dots) individuais na linha
                        dotData: const FlDotData(show: false),
                        // Preenche a área abaixo da linha com uma cor translúcida
                        belowBarData: BarAreaData(
                          show: true,
                          color: const Color(0xFF512DA8).withValues(alpha: 0.1),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Livro de Ofertas conforme solicitado
  // Método que constrói a tabela visual do livro de ofertas do mercado
  Widget _buildOrderBook() {
    // Adiciona preenchimento horizontal de 20 pixels
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // Organiza o título e a tabela em uma coluna vertical
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exibe o título da seção com uma cor roxa específica
          const Text(
            "Livro de Ofertas (Mercado)",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF4B0082),
            ),
          ),
          // Adiciona um espaçamento vertical de 15 pixels
          const SizedBox(height: 15),
          // Widget que escuta em tempo real a subcoleção de ofertas da startup
          StreamBuilder<QuerySnapshot>(
            // Define a consulta ao Firestore limitada às 4 ofertas mais recentes
            stream: FirebaseFirestore.instance
                .collection('startups')
                .doc(
                  widget.startup['id'] ??
                      _getStartupId(widget.startup['ticker']),
                )
                .collection('Ofertas')
                .orderBy('data', descending: true)
                .limit(4)
                .snapshots(),
            // Construtor da interface baseada nos dados das ofertas
            builder: (context, snapshot) {
              // Extrai a lista de documentos do snapshot
              final docs = snapshot.data?.docs ?? [];
              // Retorna uma tabela organizada em colunas flexíveis
              return Table(
                columnWidths: const {
                  // Define que cada uma das 3 colunas ocupa o mesmo espaço proporcional
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                },
                // Define as linhas da tabela
                children: [
                  // Linha de cabeçalho da tabela
                  TableRow(
                    children: [
                      // Cabeçalho para a quantidade de tokens
                      _tableHeader("Qtd Tokens"),
                      // Cabeçalho para o valor unitário do token
                      _tableHeader("Valor Token"),
                      // Cabeçalho para o valor total da oferta
                      _tableHeader("Total Pago"),
                    ],
                  ),
                  // Exibe uma linha informativa caso não existam ofertas registradas
                  if (docs.isEmpty)
                    TableRow(
                      children: [
                        // Mensagem de ausência de dados ocupando a primeira célula
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Nenhuma oferta ainda.',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        // Célula vazia para manter o alinhamento da tabela
                        const SizedBox(),
                        // Outra célula vazia para manter o alinhamento
                        const SizedBox(),
                      ],
                    )
                  // Mapeia os documentos de ofertas para linhas da tabela se existirem
                  else
                    ...docs.map((doc) {
                      // Converte os dados do documento para um mapa chave-valor
                      final data = doc.data() as Map<String, dynamic>;
                      // Extrai e trata a quantidade de tokens como número
                      final tokens = (data['Tokens Comprados'] ?? 0) as num;
                      // Extrai e trata o valor unitário do token como número
                      final valorToken = (data['Valor Token'] ?? 0) as num;
                      // Extrai e trata o valor total pago como número
                      final totalPago = (data['Preco Pago'] ?? 0) as num;
                      // Retorna uma linha de oferta formatada
                      return _orderRow(
                        tokens.toString(),
                        'R\$ ${valorToken.toStringAsFixed(2)}',
                        'R\$ ${totalPago.toStringAsFixed(2)}',
                        Colors.black,
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

  // Método para abrir o diálogo de informações e criação de contraproposta
  void _abrirContrapropostaInfo() {
    // Controlador para o campo de texto da quantidade de tokens
    final qtdController = TextEditingController();
    // Controlador para o campo de texto do preço sugerido
    final precoController = TextEditingController();
    // Variável para armazenar a porcentagem calculada da participação
    double porcentagem = 0;
    // Controle de visibilidade do campo de preço baseado na validade da quantidade
    bool mostrarPreco = false;

    // Variável para armazenar o total de tokens emitidos pela startup
    num totalTokensIssued = 1;
    // Variável para acumular o total de tokens já negociados no mercado
    num totalVendidoGeral = 0;
    // Flag para evitar múltiplas buscas desnecessárias ao banco de dados
    bool dadosCarregados = false;
    // Valor inteiro representando a porcentagem de desconto concedida
    int desconto = 0;
    // Valor calculado do preço mínimo com desconto aplicado
    double valorComDesconto = 0;
    // Valor base do preço sem qualquer desconto aplicado
    double valorSemDesconto = 0;
    // Mensagem de erro para validação do preço inserido
    String? precoErro;
    // Estado para indicar se a contraproposta está sendo enviada ao servidor
    bool enviando = false;
    // Estado para indicar se os dados iniciais estão sendo carregados
    bool carregando = false;

    // Exibe o painel modal inferior configurado para entrada de dados
    showModalBottomSheet(
      context: context,
      // Permite que o modal se ajuste ao teclado e ocupe a tela necessária
      isScrollControlled: true,
      // Define o estilo visual com bordas superiores arredondadas
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      // Constrói o conteúdo dinâmico do painel modal
      builder: (context) {
        // Widget que permite atualizar o estado local do modal independentemente
        return StatefulBuilder(
          builder: (builderContext, setModalState) {
            // Define as margens e o comportamento de ajuste ao teclado
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 28,
                right: 28,
                top: 28,
              ),
              // Organiza os elementos do formulário em uma coluna compacta
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Barra visual decorativa no topo do modal
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  // Adiciona um espaçamento vertical de 24 pixels
                  const SizedBox(height: 24),
                  // Exibe o ícone de aperto de mãos simbolizando o acordo
                  const Icon(
                    Icons.handshake_outlined,
                    size: 48,
                    color: Color(0xFF512DA8),
                  ),
                  // Adiciona um espaçamento vertical de 16 pixels
                  const SizedBox(height: 16),
                  // Título principal do diálogo de contraproposta
                  const Text(
                    "Contraproposta",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // Adiciona um espaçamento vertical de 8 pixels
                  const SizedBox(height: 8),
                  // Texto explicativo sobre a regra mínima de 5% para contrapropostas
                  const Text(
                    "Você pode fazer uma contraproposta investindo no mínimo em 5% ou mais das ações da startup.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFFFA000),
                      height: 1.5,
                    ),
                  ),
                  // Adiciona um espaçamento vertical de 20 pixels
                  const SizedBox(height: 20),
                  // Campo de entrada para a quantidade de tokens desejada
                  TextField(
                    controller: qtdController,
                    // Filtros para garantir que apenas números inteiros positivos sejam aceitos
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        if (newValue.text.isEmpty) return newValue;
                        final n = int.tryParse(newValue.text);
                        if (n == null || n <= 0) return oldValue;
                        return newValue.copyWith(text: n.toString());
                      }),
                    ],
                    // Configuração visual e rótulo do campo de quantidade
                    decoration: InputDecoration(
                      labelText: "Quantidade de tokens",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.token),
                    ),
                    // Define o teclado numérico para facilitar a entrada
                    keyboardType: TextInputType.number,
                    // Lógica executada a cada alteração no valor do campo
                    onChanged: (value) async {
                      // Tenta converter o valor atual em número inteiro
                      final qtd = int.tryParse(value) ?? 0;
                      // Se a quantidade for válida, inicia a busca de dados do mercado
                      if (qtd > 0) {
                        // Verifica se os dados globais já foram buscados anteriormente
                        if (!dadosCarregados && !carregando) {
                          // Marca como carregando para evitar chamadas paralelas
                          carregando = true;

                          // Obtém o identificador interno da startup
                          final startupId =
                              widget.startup['id'] ??
                              _getStartupId(widget.startup['ticker']);

                          // Busca o documento principal da startup no Firestore
                          final startupSnap = await FirebaseFirestore.instance
                              .collection('startups')
                              .doc(startupId)
                              .get();
                          // Extrai o total de tokens emitidos pela empresa
                          totalTokensIssued =
                              (startupSnap.data()?['totalTokensIssued'] ?? 1)
                                  as num;

                          // Busca todo o histórico de negociações para calcular o estoque
                          final historicoGeralSnap = await FirebaseFirestore
                              .instance
                              .collection('startups')
                              .doc(startupId)
                              .collection('Histórico')
                              .get();

                          // Itera pelos registros para calcular o saldo líquido de tokens
                          for (var doc in historicoGeralSnap.docs) {
                            final data = doc.data();
                            // Soma tokens comprados ao volume negociado
                            if (data['tipo'] == 'Compra') {
                              totalVendidoGeral +=
                                  (data['Tokens Comprados'] ?? 0) as num;
                            }
                            // Subtrai tokens vendidos do volume negociado
                            if (data['tipo'] == 'Venda') {
                              totalVendidoGeral -=
                                  (data['Tokens Vendidos'] ?? 0) as num;
                            }
                          }
                          // Busca as ofertas pendentes para complementar o cálculo de estoque
                          final ofertasSnap = await FirebaseFirestore.instance
                              .collection('startups')
                              .doc(startupId)
                              .collection('Ofertas')
                              .get();

                          // Adiciona as ofertas ao total vendido geral
                          for (var doc in ofertasSnap.docs) {
                            totalVendidoGeral +=
                                (doc.data()['Tokens Comprados'] ?? 0) as num;
                          }

                          // Marca que os dados base foram carregados com sucesso
                          dadosCarregados = true;
                        }

                        // Calcula o estoque real de tokens disponíveis para negociação
                        final tokensDisponiveis =
                            (totalTokensIssued - totalVendidoGeral).toInt();

                        // Se o usuário pedir mais do que há no mercado, limita ao disponível
                        if (qtd > tokensDisponiveis) {
                          qtdController.text = tokensDisponiveis.toString();
                          // Reposiciona o cursor no final do texto corrigido
                          qtdController.selection = TextSelection.fromPosition(
                            TextPosition(offset: qtdController.text.length),
                          );
                        }

                        // Define a quantidade final após as validações de estoque
                        final qtdFinal = qtd > tokensDisponiveis
                            ? tokensDisponiveis
                            : qtd;
                        // Calcula a porcentagem que esta compra representa no capital da startup
                        final pct = qtdFinal == tokensDisponiveis
                            ? 100.0
                            : (qtdFinal / totalTokensIssued) * 100;

                        // Atualiza o estado do modal com os novos cálculos de desconto e preços
                        setModalState(() {
                          porcentagem = pct;
                          mostrarPreco = true;
                          // O desconto é proporcional à participação, limitado a 30%
                          desconto = (pct / 100 * 30).round();
                          // Calcula o preço sugerido com o desconto aplicado
                          valorComDesconto =
                              widget.startup['preco'] * (1 - desconto / 100);
                          // Define o preço base (sem desconto) como limite superior
                          valorSemDesconto = widget.startup['preco'];
                          // Limpa o campo de preço para forçar nova entrada válida
                          precoController.clear();
                        });
                      } else {
                        // Reseta as variáveis de controle caso a quantidade seja zerada
                        setModalState(() {
                          porcentagem = 0;
                          mostrarPreco = false;
                          desconto = 0;
                          precoController.clear();
                        });
                      }
                    },
                  ),

                  // Adiciona um espaçamento vertical de 12 pixels
                  const SizedBox(height: 12),

                  // Exibe aviso se a participação for menor que o requisito de 5%
                  if (mostrarPreco && porcentagem < 5)
                    Text(
                      "A sua contraproposta de ${porcentagem.toStringAsFixed(3)}% tem menos de 5% dos tokens.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.red,
                        height: 1.5,
                      ),
                    ),

                  // Exibe as opções de preço se a participação atingir o mínimo de 5%
                  if (mostrarPreco && porcentagem >= 5) ...[
                    // Texto informativo sobre o desconto disponível baseado na participação
                    Text(
                      "Você tem direito a um desconto de $desconto%, escolha um valor para pagar entre R\$ ${valorComDesconto.toStringAsFixed(2)} e R\$ ${valorSemDesconto.toStringAsFixed(2)}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFFFFA000),
                        height: 1.5,
                      ),
                    ),
                    // Adiciona um espaçamento vertical de 12 pixels
                    const SizedBox(height: 12),
                    // Campo de entrada para o preço sugerido por token
                    TextField(
                      controller: precoController,
                      // Permite entrada de números decimais
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      // Valida a entrada para aceitar apenas formato monetário
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*[,.]?\d{0,2}'),
                        ),
                      ],
                      // Configura a decoração visual e ícone do campo de preço
                      decoration: InputDecoration(
                        labelText: "Preço por token (R\$)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.attach_money),
                        errorText: precoErro,
                      ),
                      // Valida o preço em tempo real conforme o usuário digita
                      onChanged: (value) {
                        final preco =
                            double.tryParse(value.replaceAll(',', '.')) ?? 0;
                        // Limpa o erro se o campo estiver vazio
                        if (value.isEmpty) {
                          setModalState(() {
                            precoErro = null;
                          });
                          return;
                        }
                        // Verifica se o preço está dentro da faixa permitida com desconto
                        if (preco < valorComDesconto ||
                            preco > valorSemDesconto) {
                          setModalState(() {
                            precoErro =
                                'Valor deve ser entre R\$ ${valorComDesconto.toStringAsFixed(2)} e R\$ ${valorSemDesconto.toStringAsFixed(2)}';
                          });
                        } else {
                          // Remove o erro se o valor for válido
                          setModalState(() {
                            precoErro = null;
                          });
                        }
                      },
                    ),
                  ],

                  // Adiciona um espaçamento vertical de 20 pixels
                  const SizedBox(height: 20),
                  // Botão principal para submeter a contraproposta
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      // Define o estilo visual roxo e arredondado do botão
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF512DA8),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      // Desabilita o botão se já estiver enviando dados
                      onPressed: enviando
                          ? null
                          : () async {
                              // Captura e sanitiza o preço e quantidade finais
                              final preco =
                                  double.tryParse(
                                    precoController.text.replaceAll(',', '.'),
                                  ) ??
                                  0;
                              final qtd = int.tryParse(qtdController.text) ?? 0;

                              // Valida se os campos obrigatórios foram preenchidos
                              if (qtd <= 0 || preco <= 0) {
                                setModalState(() {
                                  enviando = false;
                                  precoErro = 'Preencha o preço por token.';
                                });
                                return;
                              }

                              // Define uma pequena margem de tolerância para cálculos de ponto flutuante
                              const tolerancia = 0.01;

                              // Valida se o preço final submetido respeita os limites calculados
                              if (preco < valorComDesconto - tolerancia ||
                                  preco > valorSemDesconto + tolerancia) {
                                setModalState(() {
                                  enviando = false;
                                });
                                // Exibe aviso flutuante sobre o preço inválido
                                ScaffoldMessenger.of(
                                  builderContext,
                                ).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Preço deve estar entre R\$ ${valorComDesconto.toStringAsFixed(2)} e R\$ ${valorSemDesconto.toStringAsFixed(2)}.',
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              // Calcula o montante financeiro total necessário para a operação
                              final totalNecessario = qtd * preco;
                              // Obtém o identificador único do usuário autenticado
                              final uid =
                                  FirebaseAuth.instance.currentUser?.uid;
                              // Interrompe se o usuário não estiver logado
                              if (uid == null) {
                                setModalState(() {
                                  enviando = false;
                                }); // <--
                                return;
                              }

                              // Ativa o estado de carregamento visual
                              setModalState(() {
                                enviando = true;
                              });

                              try {
                                // Registra no console a busca pelo saldo do usuário
                                debugPrint('Buscando saldo...');
                                // Referencia o documento de saldo do usuário no Firestore
                                final saldoRef = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(uid)
                                    .collection('carteira')
                                    .doc('saldo');

                                // Busca os dados atuais do saldo
                                final userSnap = await saldoRef.get();
                                // Extrai o valor numérico do saldo
                                final saldoAtual =
                                    (userSnap.data()?['saldo'] ?? 0) as num;
                                // Registra o saldo atual no console para depuração
                                debugPrint('saldoAtual: $saldoAtual');

                                // Valida se o usuário possui fundos suficientes para a compra
                                if (saldoAtual < totalNecessario) {
                                  // Calcula o valor que falta para completar a transação
                                  final falta = totalNecessario - saldoAtual;
                                  // Fecha o modal e exibe erro de saldo insuficiente
                                  Navigator.pop(builderContext);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Saldo insuficiente. Faltam R\$ ${falta.toStringAsFixed(2)} para realizar a contraproposta.',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                // Obtém o ID interno da startup via ticker
                                final startupId =
                                    widget.startup['id'] ??
                                    _getStartupId(widget.startup['ticker']);

                                // Deduz o valor da compra do saldo do usuário no banco de dados
                                await saldoRef.update({
                                  'saldo': saldoAtual - totalNecessario,
                                });

                                // Registra a nova oferta na coleção da startup
                                await FirebaseFirestore.instance
                                    .collection('startups')
                                    .doc(startupId)
                                    .collection('Ofertas')
                                    .add({
                                      'Preco Pago': totalNecessario,
                                      'Tokens Comprados': qtd,
                                      'Valor Token': preco,
                                      'data': FieldValue.serverTimestamp(),
                                      'status': 'Sucesso',
                                      'tipo': 'Compra',
                                      'uid': uid,
                                    });

                                // Referencia o registro de investimento do usuário para esta startup
                                final investimentoRef = FirebaseFirestore
                                    .instance
                                    .collection('users')
                                    .doc(uid)
                                    .collection('investimentos')
                                    .doc(startupId);

                                // Verifica se o usuário já possui investimentos nesta empresa
                                final investimentoSnap = await investimentoRef
                                    .get();

                                // Atualiza ou cria o registro de investimento conforme a existência
                                if (investimentoSnap.exists) {
                                  // Acumula os tokens e valores aos registros já existentes
                                  final tokensAtuais =
                                      (investimentoSnap
                                                  .data()?['tokensComprados'] ??
                                              0)
                                          as num;
                                  final valorAtuais =
                                      (investimentoSnap.data()?['valorPago'] ??
                                              0)
                                          as num;
                                  await investimentoRef.update({
                                    'tokensComprados': tokensAtuais + qtd,
                                    'valorPago': valorAtuais + totalNecessario,
                                  });
                                } else {
                                  // Cria um novo registro de investimento para o usuário
                                  await investimentoRef.set({
                                    'tokensComprados': qtd,
                                    'valorPago': totalNecessario,
                                  });
                                }

                                // Fecha o modal e exibe mensagem de sucesso
                                Navigator.pop(builderContext);
                                ScaffoldMessenger.of(
                                  builderContext,
                                ).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Contraproposta enviada com sucesso!',
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                // Captura e trata qualquer erro durante o processo de transação
                              } catch (e) {
                                // Remove o estado de carregamento e exibe mensagem de erro genérica
                                setModalState(() {
                                  enviando = false;
                                });
                                ScaffoldMessenger.of(
                                  builderContext,
                                ).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Erro ao enviar contraproposta. Tente novamente.',
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                      // Exibe carregador ou texto dependendo do estado de envio
                      child: enviando
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              // Ícone de progresso circular branco
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "Fazer Contraproposta",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                    ),
                  ),
                  // Adiciona um espaçamento vertical final de 20 pixels
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Widget de Histórico que usa a lista _historicoFake
  // Método que constrói a lista dinâmica de histórico de transações do usuário
  Widget _buildDynamicHistory() {
    // Obtém o ID do usuário autenticado no momento
    final uid = FirebaseAuth.instance.currentUser?.uid;
    // Define o ID da startup com base nos dados fornecidos ou via ticker
    final startupId =
        widget.startup['id'] ?? _getStartupId(widget.startup['ticker']);

    // Adiciona preenchimento horizontal de 20 pixels
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // Organiza o título e a lista em uma coluna vertical
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exibe o título "Histórico" com estilo cinza e negrito
          const Text(
            "Histórico",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          // Adiciona um espaçamento vertical de 10 pixels
          const SizedBox(height: 10),
          // Widget que escuta em tempo real o histórico de transações no Firestore
          StreamBuilder<QuerySnapshot>(
            // Define a consulta filtrada pelo usuário logado e ordenada por data
            stream: FirebaseFirestore.instance
                .collection('startups')
                .doc(startupId)
                .collection('Histórico')
                .where('uid', isEqualTo: uid)
                .orderBy('data', descending: true)
                .snapshots(),
            // Construtor da interface baseada nos dados do histórico
            builder: (context, snapshot) {
              // Exibe carregamento enquanto os dados não são recebidos
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // Extrai a lista de documentos do snapshot
              final docs = snapshot.data?.docs ?? [];

              // Exibe mensagem informativa se não houver transações registradas
              if (docs.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Nenhuma transação encontrada.',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                );
              }

              // Define quais documentos exibir baseado no estado da variável _verTodos
              final exibir = _verTodos ? docs : docs.take(2).toList();

              // Retorna uma coluna contendo os itens do histórico e botão de expansão
              return Column(
                children: [
                  // Mapeia cada documento para um widget de linha de transação
                  ...exibir.map((doc) {
                    // Converte os dados do documento para um mapa
                    final data = doc.data() as Map<String, dynamic>;
                    // Retorna o widget visual da transação individual
                    return _buildTransactionTile(data);
                  }),
                  // Exibe o botão de "Ver mais/menos" se houver mais de 2 itens
                  if (docs.length > 2)
                    TextButton(
                      // Alterna o estado de visualização completa ao clicar
                      onPressed: () => setState(() => _verTodos = !_verTodos),
                      // Define o rótulo dinâmico do botão
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

  // Método auxiliar para construir o cabeçalho das tabelas
  Widget _tableHeader(String label) => Padding(
    // Adiciona preenchimento vertical de 8 pixels
    padding: const EdgeInsets.symmetric(vertical: 8),
    // Retorna o texto do cabeçalho formatado em negrito
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 10,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  // Método auxiliar para construir uma linha de dados no livro de ofertas
  TableRow _orderRow(String tipo, String qtd, String preco, Color color) {
    // Retorna uma linha de tabela com três células
    return TableRow(
      children: [
        // Primeira célula contendo o tipo da oferta ou quantidade
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            tipo,
            style: const TextStyle(color: Colors.black, fontSize: 12),
          ),
        ),
        // Segunda célula contendo a quantidade de tokens em verde
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            qtd,
            style: const TextStyle(fontSize: 12, color: Colors.green),
          ),
        ),
        // Terceira célula contendo o preço total em verde
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            preco,
            style: const TextStyle(fontSize: 12, color: Colors.green),
          ),
        ),
      ],
    );
  }

  // Método auxiliar para construir os botões circulares de ação rápida
  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    // Widget que detecta toques e exibe efeito visual de clique
    return InkWell(
      onTap: onTap,
      // Define o raio do efeito visual de clique
      borderRadius: BorderRadius.circular(28),
      // Organiza o ícone e o texto em uma coluna
      child: Column(
        children: [
          // Exibe o fundo circular do ícone
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[100],
            // Exibe o ícone de ação fornecido
            child: Icon(icon, color: Colors.black),
          ),
          // Adiciona um espaçamento vertical de 8 pixels
          const SizedBox(height: 8),
          // Exibe o rótulo de texto abaixo do ícone
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Método auxiliar para construir cada linha individual do histórico
  Widget _buildTransactionTile(Map<String, dynamic> item) {
    // Identifica o tipo de transação (Compra ou Venda)
    final tipo = item['tipo'] ?? 'Compra';
    // Booleano que indica se a transação é uma compra
    final isCompra = tipo == 'Compra';
    // Define a cor temática (verde para compra, vermelho para venda)
    final color = isCompra ? Colors.green : Colors.red;
    // Define o ícone correspondente ao tipo de transação
    final icon = isCompra ? Icons.shopping_cart : Icons.sell;

    // Formata a data e hora do servidor para exibição amigável
    final dataFormatada = item['data'] != null
        ? DateFormat(
            'MMM dd, hh:mm a',
          ).format((item['data'] as Timestamp).toDate())
        : '';

    // Retorna um componente de lista clicável
    return ListTile(
      // Navega para a tela de detalhes da transação ao tocar
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailsScreen(
              transacao: item,
              ticker: widget.startup['ticker'],
            ),
          ),
        );
      },
      // Remove o preenchimento interno padrão do ListTile
      contentPadding: EdgeInsets.zero,
      // Exibe o ícone circular decorativo à esquerda
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        // Ícone colorido representando a ação realizada
        child: Icon(icon, color: color, size: 18),
      ),
      // Exibe o título da transação (Compra/Venda) em negrito
      title: Text(
        tipo,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      // Exibe a data formatada abaixo do título
      subtitle: Text(
        dataFormatada,
        style: const TextStyle(fontSize: 11, color: Colors.grey),
      ),
      // Exibe a quantidade e o ticker do ativo à direita
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          // Exibe a quantidade de tokens negociados
          Text(
            "${item['Tokens Comprados'] ?? item['Tokens Vendidos'] ?? 0}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          // Adiciona um pequeno espaçamento horizontal de 4 pixels
          const SizedBox(width: 4),
          // Exibe o ticker da startup associado
          Text(
            "${widget.startup['ticker']}",
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

// Define a tela de detalhes de uma transação específica como um widget sem estado
class TransactionDetailsScreen extends StatelessWidget {
  // Mapa contendo todos os dados da transação (data, tipo, valor, etc)
  final Map<String, dynamic> transacao;
  // Ticker da startup associada à transação
  final String ticker;

  // Construtor da tela que exige os dados da transação e o ticker
  const TransactionDetailsScreen({
    super.key,
    required this.transacao,
    required this.ticker,
  });

  // Sobrescreve o método de construção da interface visual da tela
  @override
  Widget build(BuildContext context) {
    // Formata a data da transação para exibição amigável ou define mensagem padrão
    final dataFormatada = transacao['data'] != null
        ? DateFormat(
            'MMM dd, hh:mm a',
          ).format((transacao['data'] as Timestamp).toDate())
        : 'Data não disponível';

    // Retorna a estrutura básica da página de detalhes
    return Scaffold(
      backgroundColor: Colors.white,
      // Define a barra superior com botão de voltar e título "Detalhes"
      appBar: AppBar(
        // Adiciona o botão de ícone para retornar à tela anterior
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          // Executa a navegação de retorno
          onPressed: () => Navigator.pop(context),
        ),
        // Define o título da barra superior
        title: const Text("Detalhes", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      // Adiciona preenchimento em todo o corpo da tela
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        // Organiza as informações em uma coluna vertical
        child: Column(
          children: [
            // Adiciona um espaçamento vertical inicial de 20 pixels
            const SizedBox(height: 20),
            // Exibe a quantidade negociada seguida pelo ticker em destaque
            Text(
              "${transacao['Tokens Comprados'] ?? transacao['Tokens Vendidos'] ?? 0} $ticker",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF512DA8),
              ),
            ),
            // Exibe o preço total pago ou recebido formatado em Reais
            Text(
              "R\$ ${(transacao['Preco Pago'] as num?)?.toStringAsFixed(2) ?? '0.00'}",
              style: const TextStyle(color: Colors.grey),
            ),
            // Adiciona um espaçamento vertical largo de 40 pixels
            const SizedBox(height: 40),
            // Container estilizado para agrupar os detalhes técnicos
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FB),
                borderRadius: BorderRadius.circular(20),
              ),
              // Organiza as linhas de detalhe em uma coluna
              child: Column(
                children: [
                  // Exibe a linha com a data da transação
                  _buildDetailRow("Data", dataFormatada),
                  // Exibe a linha com o status atual da transação
                  _buildDetailRow(
                    "Status",
                    transacao['status'] ?? '-',
                    isStatus: true,
                  ),
                  // Exibe a linha com o preço total da operação
                  _buildDetailRow(
                    "Preço Pago",
                    "R\$ ${(transacao['Preco Pago'] as num?)?.toStringAsFixed(2) ?? '0.00'}",
                  ),
                  // Exibe a linha com a quantidade de tokens envolvida
                  _buildDetailRow(
                    "Tokens Comprados",
                    "${transacao['Tokens Comprados'] ?? transacao['Tokens Vendidos'] ?? 0}",
                  ),
                  // Exibe a linha com o valor unitário do token na operação
                  _buildDetailRow(
                    "Valor do Token",
                    "R\$ ${(transacao['Valor Token'] as num?)?.toStringAsFixed(2) ?? '0.00'}",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método auxiliar para construir cada linha de detalhe (chave: valor)
  Widget _buildDetailRow(String label, String value, {bool isStatus = false}) {
    // Adiciona preenchimento vertical de 12 pixels entre as linhas
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      // Organiza o rótulo e o valor em extremidades opostas da linha
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Exibe o rótulo descritivo em cor cinza
          Text(label, style: const TextStyle(color: Colors.grey)),
          // Exibe o valor do detalhe em negrito e com cor condicional
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isStatus ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
