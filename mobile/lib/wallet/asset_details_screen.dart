//feito por camila fernandes costacurta ra: 25012949 

 

import 'package:flutter/material.dart'; // Biblioteca base do Flutter (permite usar widgets como Scaffold, Column, Row).
import 'package:google_fonts/google_fonts.dart'; // Biblioteca de fontes (permite usar GoogleFonts.lora).
import 'package:fl_chart/fl_chart.dart'; // Biblioteca de gráficos (permite usar LineChart, FlSpot).
import 'package:cloud_functions/cloud_functions.dart'; // Biblioteca de funções na nuvem (permite usar FirebaseFunctions, httpsCallable).
import 'package:cloud_firestore/cloud_firestore.dart'; // Biblioteca do Banco de Dados (permite usar FirebaseFirestore, DocumentSnapshot).
import 'package:firebase_auth/firebase_auth.dart'; // Biblioteca de Autenticação (permite usar FirebaseAuth, currentUser).
import 'package:mobile/features/wallet/presentation/token_performance_screen.dart' as token_page; // Importa a página de performance (permite navegar para ValorizacaoPage).
import 'package:mobile/features/wallet/presentation/widgets/asset_chart_widget.dart'; // Importa o widget do gráfico (permite usar AssetChartWidget).
import 'package:mobile/features/wallet/presentation/widgets/order_book_widget.dart'; // Importa o widget do livro de ofertas (permite usar OrderBookWidget).
import 'package:mobile/features/wallet/presentation/widgets/transaction_history_widget.dart'; // Importa o widget do histórico (permite usar TransactionHistoryWidget).
import 'package:mobile/features/wallet/presentation/widgets/asset_action_button.dart'; // Importa o botão de ação (permite usar AssetActionButton).

// ESTA CLASSE DEFINE A TELA DE DETALHES DE UMA STARTUP ESPECÍFICA, ONDE O USUÁRIO PODE INVESTIR OU TROCAR TOKENS.
class AssetDetailsScreen extends StatefulWidget { // Declaração da classe como widget com estado.
  final Map<String, dynamic> startup;
   // Atributo que armazena os dados da startup selecionada.
  const AssetDetailsScreen({super.key, required this.startup}); // Construtor que recebe a startup como parâmetro obrigatório.

  // ESTA FUNÇÃO CRIA O ESTADO PARA A TELA DE DETALHES DO ATIVO, ONDE AS INTERAÇÕES DO USUÁRIO SERÃO PROCESSADAS.
  @override // Indica que estamos fornecendo uma implementação personalizada.
  State<AssetDetailsScreen> createState() => _AssetDetailsScreenState(); // Cria o objeto de estado desta tela.
} // Fim da classe.

// ESTA CLASSE GERENCIA O ESTADO E AS INTERAÇÕES DA TELA DE DETALHES, COMO A ABERTURA DE MODAIS E ATUALIZAÇÃO DO GRÁFICO.
class _AssetDetailsScreenState extends State<AssetDetailsScreen> { // Classe de estado da tela de detalhes.
  final TextEditingController _quantidadeController = TextEditingController(); // Controlador para o campo de entrada de quantidade.
  bool _isLoading = false; // Variável que indica se há um processo de carregamento em curso.

  // LISTA DE DADOS FICTÍCIOS PARA EXIBIR UM HISTÓRICO DE EXEMPLO NA TELA.
  final List<Map<String, dynamic>> _historicoFake = [ // Início da lista de transações falsas.
    { // Primeiro item.
      "titulo": "Compra", // Tipo da operação.
      "sub": "Via Balcão", // Detalhe da origem.
      "valor": "+10", // Quantidade fictícia.
      "icon": Icons.shopping_cart, // Ícone de carrinho.
    }, // Fim do item.
    { // Segundo item.
      "titulo": "Troca", // Tipo da operação.
      "sub": "Conversão Simulada", // Detalhe.
      "valor": "-5", // Quantidade fictícia.
      "icon": Icons.swap_horiz, // Ícone de troca.
    }, // Fim do item.
  ]; // Fim da lista.

  // ESTA FUNÇÃO É CHAMADA QUANDO A TELA É FECHADA, LIMPANDO OS RECURSOS UTILIZADOS PARA EVITAR VAZAMENTO DE MEMÓRIA.
  @override // Indica sobrescrita.
  void dispose() { // Função de descarte.
    _quantidadeController.dispose(); // Descarta o controlador de texto.
    super.dispose(); // Chama o método de limpeza da classe pai.
  } // Fim da função dispose.

  // ESTA FUNÇÃO É RESPONSÁVEL POR BUSCAR O ID CORRETO DA STARTUP NO FIREBASE USANDO O CÓDIGO DA BOLSA (TICKER).
  String _getStartupId(String ticker) { // Início da função de mapeamento.
    switch (ticker) { // Analisa o código recebido.
      case 'AGRI3': return 'agrisense'; // AGRI3 mapeia para agrisense.
      case 'DEVM3': return 'devmatch'; // DEVM3 mapeia para devmatch.
      case 'ECYC1': return 'ecocycle'; // ECYC1 mapeia para ecocycle.
      case 'HBIT3': return 'healthbit'; // HBIT3 mapeia para healthbit.
      case 'SCMP3': return 'smartcampus'; // SCMP3 mapeia para smartcampus.
      default: return 'agrisense'; // Retorno padrão caso não encontre.
    } // Fim do switch.
  } // Fim da função.

  // ESTA FUNÇÃO EXIBE UMA JANELA QUE SOBE DA PARTE INFERIOR PARA QUE O USUÁRIO POSSA DIGITAR A QUANTIDADE E COMPRAR TOKENS.
  void _abrirModalInvestir() { // Início da função do modal de investimento.
    _quantidadeController.clear(); // Limpa o campo de texto antes de abrir.
    showModalBottomSheet( // Função do Flutter para mostrar o modal de baixo.
      context: context, // Passa o contexto da tela.
      isScrollControlled: true, // Permite que o modal mude de tamanho conforme o teclado aparece.
      shape: const RoundedRectangleBorder( // Define a borda do modal.
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Arredonda apenas o topo.
      ), // Fim da borda.
      builder: (bottomSheetContext) { // Construtor visual do modal.
        return StatefulBuilder( // Permite atualizar o estado apenas dentro deste modal.
          builder: (builderContext, setModalState) { // Construtor interno do estado.
            return Padding( // Adiciona preenchimento interno.
              padding: EdgeInsets.only( // Preenchimento ajustável.
                bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom, // Sobe o modal para não ficar atrás do teclado.
              ), // Fim do padding.
              child: Container( // Caixa principal do modal.
                padding: const EdgeInsets.all(24), // 24 pixels de margem interna.
                child: Column( // Organiza o conteúdo em coluna.
                  mainAxisSize: MainAxisSize.min, // Ocupa o mínimo de espaço possível.
                  children: [ // Filhos da coluna.
                    Text( // Título da operação.
                      "Investir em ${widget.startup['ticker']}", // Nome do ativo no título.
                      style: const TextStyle( // Estilo do texto.
                        fontSize: 18, // Tamanho 18.
                        fontWeight: FontWeight.bold, // Negrito.
                      ), // Fim do estilo.
                    ), // Fim do título.
                    const SizedBox(height: 20), // Espaço de 20 pixels.
                    TextField( // Campo de entrada de texto.
                      controller: _quantidadeController, // Conecta ao controlador.
                      decoration: InputDecoration( // Estilo do campo.
                        labelText: "Quantidade de Tokens", // Texto de instrução.
                        border: OutlineInputBorder( // Borda ao redor do campo.
                          borderRadius: BorderRadius.circular(12), // Cantos arredondados raio 12.
                        ), // Fim da borda.
                        prefixIcon: const Icon(Icons.add_chart), // Ícone decorativo à esquerda.
                      ), // Fim da decoração.
                      keyboardType: TextInputType.number, // Abre o teclado numérico.
                    ), // Fim do campo de texto.
                    const SizedBox(height: 20), // Espaço de 20 pixels.
                    SizedBox( // Define o tamanho do botão.
                      width: double.infinity, // Ocupa toda a largura.
                      child: ElevatedButton( // Botão de destaque.
                        style: ElevatedButton.styleFrom( // Estilo do botão.
                          backgroundColor: const Color(0xFF512DA8), // Fundo roxo.
                          padding: const EdgeInsets.symmetric(vertical: 15), // Margem interna vertical.
                        ), // Fim do estilo.
                        onPressed: _isLoading // Se estiver carregando, o botão fica desativado.
                            ? null
                            : () async { // Ação ao clicar.
                                final quantidadeTexto = _quantidadeController.text.replaceAll(',', '.'); // Corrige vírgula para ponto.
                                final quantidade = int.tryParse(quantidadeTexto) ?? 0; // Tenta converter para número.

                                if (quantidade <= 0) { // Verifica se o valor é válido.
                                  ScaffoldMessenger.of(builderContext).showSnackBar( // Mostra aviso se inválido.
                                    const SnackBar( // Notificação.
                                      content: Text('Informe uma quantidade válida (número inteiro > 0).'), // Mensagem.
                                      backgroundColor: Colors.orange, // Cor laranja de atenção.
                                    ), // Fim do SnackBar.
                                  ); // Fim do aviso.
                                  return; // Para a execução.
                                } // Fim do check.

                                setModalState(() => _isLoading = true); // Ativa o carregamento dentro do modal.

                                try { // Início do processo de compra real.
                                  final startupId = _getStartupId(widget.startup['ticker']); // Pega o ID da empresa.
                                  final callable = FirebaseFunctions.instance // Prepara a chamada para a nuvem.
                                      .httpsCallable('exchange-buyTokens'); // Nome da função no Firebase.
                                  await callable.call({ // Executa a função passando os dados.
                                    'startupId': startupId, // ID da startup.
                                    'quantidade': quantidade, // Quantos tokens comprar.
                                  }); // Fim da chamada.

                                  if (!mounted) return; // Se a tela foi fechada, não faz nada.
                                  Navigator.pop(builderContext); // Fecha o modal de compra.
                                  ScaffoldMessenger.of(context).showSnackBar( // Mostra aviso de sucesso.
                                    const SnackBar( // Notificação.
                                      content: Text('Ordem de compra executada com sucesso!'), // Mensagem.
                                      backgroundColor: Colors.green, // Cor verde.
                                    ), // Fim do SnackBar.
                                  ); // Fim do aviso.
                                } on FirebaseFunctionsException catch (e) { // Se o Firebase der erro.
                                  setModalState(() => _isLoading = false); // Para o carregamento.
                                  if (!mounted) return; // Check de segurança.
                                  ScaffoldMessenger.of(builderContext).showSnackBar( // Mostra o erro do banco.
                                    SnackBar( // Notificação.
                                      content: Text(e.message ?? e.details?.toString() ?? 'Erro na transação.'), // Mensagem do erro.
                                      backgroundColor: Colors.red, // Cor vermelha.
                                    ), // Fim do SnackBar.
                                  ); // Fim do aviso.
                                } catch (e) { // Se der qualquer outro erro.
                                  setModalState(() => _isLoading = false); // Para o carregamento.
                                  if (!mounted) return; // Check de segurança.
                                  ScaffoldMessenger.of(builderContext).showSnackBar( // Mostra o erro inesperado.
                                    SnackBar( // Notificação.
                                      content: Text('Erro inesperado: $e'), // Mensagem.
                                      backgroundColor: Colors.red, // Cor vermelha.
                                    ), // Fim do SnackBar.
                                  ); // Fim do aviso.
                                } // Fim do catch.
                              }, // Fim do onPressed.
                        child: _isLoading // Se estiver carregando.
                            ? const SizedBox( // Mostra o círculo de progresso.
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ) // Fim do progresso.
                            : const Text( // Senão, mostra o texto do botão.
                                "Confirmar Compra",
                                style: TextStyle(color: Colors.white),
                              ), // Fim do texto.
                      ), // Fim do botão elevado.
                    ), // Fim do SizedBox.
                  ], // Fim dos filhos da coluna.
                ), // Fim da coluna interna.
              ), // Fim do Container.
            ); // Fim do Padding.
          }, // Fim do builder do modal.
        ); // Fim do StatefulBuilder.
      }, // Fim do construtor visual.
    ); // Fim do showModalBottomSheet.
  } // Fim da função _abrirModalInvestir.

  // ESTA FUNÇÃO EXIBE UMA JANELA PARA QUE O USUÁRIO POSSA SIMULAR OU REALIZAR A TROCA (SWAP) DE REAIS POR TOKENS.
  void _abrirModalTroca() { // Início da função do modal de troca.
    showModalBottomSheet( // Abre o modal inferior.
      context: context, // Contexto.
      isScrollControlled: true, // Controle de rolagem.
      shape: const RoundedRectangleBorder( // Borda.
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Topo arredondado.
      ), // Fim da borda.
      builder: (context) => Padding( // Adiciona preenchimento.
        padding: const EdgeInsets.all(24), // 24 pixels.
        child: Column( // Organiza o conteúdo da troca.
          mainAxisSize: MainAxisSize.min, // Espaço mínimo.
          children: [ // Filhos da troca.
            const Text( // Título.
              "Troca Rápida (Swap)", // Conteúdo.
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Estilo.
            ), // Fim do título.
            const SizedBox(height: 20), // Espaço.
            _buildSwapField(label: "De", ticker: "REAIS", value: "R\$ 1.000,00"), // Campo de origem (Reais).
            const Padding( // Ícone de seta entre os campos.
              padding: EdgeInsets.symmetric(vertical: 10), // Margem vertical.
              child: Icon(Icons.arrow_downward, color: Color(0xFF512DA8)), // Seta para baixo roxa.
            ), // Fim do ícone.
            _buildSwapField(label: "Para", ticker: widget.startup['ticker'], value: "163.93"), // Campo de destino (Tokens).
            const SizedBox(height: 24), // Espaço.
            SizedBox( // Botão de confirmação da troca.
              width: double.infinity, // Largura total.
              child: ElevatedButton( // Botão de ação.
                style: ElevatedButton.styleFrom( // Estilo.
                  backgroundColor: const Color(0xFF512DA8), // Fundo roxo.
                  padding: const EdgeInsets.symmetric(vertical: 15), // Margem interna.
                ), // Fim do estilo.
                onPressed: () { // Ação ao clicar.
                  Navigator.pop(context); // Fecha o modal.
                  ScaffoldMessenger.of(context).showSnackBar( // Avisa o usuário.
                    const SnackBar( // Notificação.
                      content: Text("Troca realizada com sucesso!"), // Mensagem.
                    ), // Fim do SnackBar.
                  ); // Fim do aviso.
                }, // Fim do clique.
                child: const Text( // Texto do botão.
                  "Confirmar Conversão", // Conteúdo.
                  style: TextStyle(color: Colors.white, fontSize: 16), // Letra branca tamanho 16.
                ), // Fim do texto.
              ), // Fim do botão.
            ), // Fim do SizedBox.
            const SizedBox(height: 20), // Espaço final.
          ], // Fim dos filhos.
        ), // Fim da coluna.
      ), // Fim do Padding.
    ); // Fim do modal de baixo.
  } // Fim da função.

  // ESTA FUNÇÃO CONSTRÓI O COMPONENTE VISUAL DE CADA CAMPO DE ENTRADA NO MODAL DE TROCA (SWAP).
  Widget _buildSwapField({ // Parâmetros da função.
    required String label, // Texto que diz se é origem ou destino.
    required String ticker, // Nome do ativo ou moeda.
    required String value, // Valor numérico mostrado.
  }) { // Início da função.
    return Container( // Caixa visual do campo.
      padding: const EdgeInsets.all(12), // Margem interna de 12 pixels.
      decoration: BoxDecoration( // Estilo da caixa.
        color: Colors.grey[100], // Fundo cinza clarinho.
        borderRadius: BorderRadius.circular(12), // Cantos arredondados raio 12.
        border: Border.all(color: Colors.grey[300]!), // Borda cinza um pouco mais escura.
      ), // Fim da decoração.
      child: Row( // Organiza o conteúdo em linha.
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Empurra para as pontas.
        children: [ // Filhos da linha.
          Column( // Textos da esquerda.
            crossAxisAlignment: CrossAxisAlignment.start, // Alinhados à esquerda.
            children: [ // Filhos da coluna.
              Text( // Rótulo (ex: "De").
                label, // Conteúdo.
                style: const TextStyle(fontSize: 12, color: Colors.grey), // Pequeno e cinza.
              ), // Fim do texto.
              Text( // Valor do ativo.
                value, // Conteúdo.
                style: const TextStyle( // Estilo.
                  fontSize: 18, // Tamanho 18.
                  fontWeight: FontWeight.bold, // Negrito.
                ), // Fim do estilo.
              ), // Fim do texto.
            ], // Fim dos textos.
          ), // Fim da coluna.
          Container( // Caixa para o nome da moeda/ativo à direita.
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Margens internas.
            decoration: BoxDecoration( // Estilo da caixa.
              color: Colors.white, // Fundo branco puro.
              borderRadius: BorderRadius.circular(20), // Bem arredondada (formato de pílula).
            ), // Fim do estilo.
            child: Text( // Texto do ativo.
              ticker, // Conteúdo (ex: "REAIS").
              style: const TextStyle(fontWeight: FontWeight.bold), // Apenas negrito.
            ), // Fim do texto.
          ), // Fim da caixa do ticker.
        ], // Fim dos elementos da linha.
      ), // Fim da linha.
    ); // Fim do Container.
  } // Fim da função auxiliar.

  // ESTA FUNÇÃO É A PRINCIPAL PARA DESENHAR O VISUAL DA TELA DE DETALHES, COMBINANDO O SALDO, BOTÕES, GRÁFICO E HISTÓRICO.
  @override // Indica sobrescrita.
  Widget build(BuildContext context) { // Função de construção.
    return Scaffold( // Estrutura da página.
      backgroundColor: Colors.white, // Fundo branco.
      appBar: AppBar( // Barra superior.
        leading: IconButton( // Ícone à esquerda.
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Seta de voltar preta.
          onPressed: () => Navigator.pop(context), // Volta para a tela anterior ao clicar.
        ), // Fim do ícone.
        title: Text( // Nome da startup no centro.
          widget.startup['nome'], // Conteúdo dinâmico.
          style: const TextStyle(color: Colors.black), // Texto preto.
        ), // Fim do título.
        backgroundColor: Colors.white, // Barra branca.
        elevation: 0, // Sem sombra.
      ), // Fim da barra superior.
      body: SingleChildScrollView( // Permite rolar a tela se o conteúdo for maior que o celular.
        child: Column( // Organiza tudo em coluna vertical.
          children: [ // Filhos da tela.
            const SizedBox(height: 20), // Espaço de 20 pixels no topo.
            StreamBuilder<DocumentSnapshot>( // Widget que atualiza o saldo de tokens em tempo real do banco.
              stream: FirebaseAuth.instance.currentUser != null // Verifica se está logado.
                  ? FirebaseFirestore.instance // Pega o banco.
                      .collection('users') // Pasta de usuários.
                      .doc(FirebaseAuth.instance.currentUser!.uid) // Pasta do usuário atual.
                      .collection('investimentos') // Pasta de investimentos dele.
                      .doc(widget.startup['id'] ?? _getStartupId(widget.startup['ticker'])) // Documento específico desta startup.
                      .snapshots() // Abre o canal de dados ao vivo.
                  : const Stream.empty(), // Se deslogado, manda nada.
              builder: (context, snapshot) { // Construtor visual do saldo.
                final qtdReal = snapshot.data?.data() != null // Verifica se o documento existe no banco.
                    ? (snapshot.data!.data() as Map<String, dynamic>)['tokensComprados'] ?? 0 // Pega o valor real do banco.
                    : widget.startup['qtd']; // Se não achou no banco, usa o que veio da lista.

                return Text( // Exibe o saldo na tela.
                  "$qtdReal ${widget.startup['ticker']}", // Texto formatado (ex: "10 AGRI3").
                  style: const TextStyle( // Estilo.
                    fontSize: 32, // Tamanho grande 32.
                    fontWeight: FontWeight.bold, // Negrito.
                    color: Color(0xFF512DA8), // Cor roxa escura.
                  ), // Fim do estilo.
                ); // Fim do texto.
              } // Fim do construtor.
            ), // Fim do StreamBuilder.
            const SizedBox(height: 30), // Espaço de 30 pixels.

            Row( // Linha que segura os botões circulares.
              mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões horizontalmente.
              children: [ // Lista de botões.
                AssetActionButton( // Chama o componente para o botão Investir.
                  icon: Icons.auto_graph, // Ícone de gráfico subindo.
                  label: "Investir", // Rótulo.
                  onTap: _abrirModalInvestir, // Função que abre a compra.
                ), // Fim do botão Investir.
                const SizedBox(width: 40), // Espaço de 40 pixels entre os botões.
                AssetActionButton( // Chama o componente para o botão Trocar.
                  icon: Icons.swap_horiz, // Ícone de setas de troca.
                  label: "Trocar", // Rótulo.
                  onTap: _abrirModalTroca, // Função que abre a troca rápida.
                ), // Fim do botão Trocar.
              ], // Fim da lista de botões.
            ), // Fim da linha.
            const SizedBox(height: 30), // Espaço de 30 pixels.

            Padding( // Adiciona margem lateral ao botão de performance.
              padding: const EdgeInsets.symmetric(horizontal: 20), // 20 pixels dos dois lados.
              child: ElevatedButton.icon( // Botão com ícone e texto interno.
                onPressed: () { // Ação ao clicar.
                  Navigator.push( // Navega para uma nova tela.
                    context, // Contexto.
                    MaterialPageRoute( // Transição.
                      builder: (context) => const token_page.ValorizacaoPage(), // Abre a tela de gráficos técnicos.
                    ), // Fim da rota.
                  ); // Fim do push.
                }, // Fim do clique.
                icon: const Icon(Icons.insights, color: Colors.white), // Ícone de insights branco.
                label: const Text( // Texto do botão.
                  "Ver Performance Detalhada", // Conteúdo.
                  style: TextStyle(color: Colors.white), // Letra branca.
                ), // Fim do texto.
                style: ElevatedButton.styleFrom( // Estilo do botão largo.
                  backgroundColor: const Color(0xFF512DA8), // Fundo roxo.
                  minimumSize: const Size(double.infinity, 50), // Faz ocupar toda a largura com altura 50.
                  shape: RoundedRectangleBorder( // Borda.
                    borderRadius: BorderRadius.circular(12), // Cantos arredondados raio 12.
                  ), // Fim da borda.
                ), // Fim do estilo.
              ), // Fim do botão elevado.
            ), // Fim do preenchimento.
            const SizedBox(height: 30), // Espaço de 30 pixels.

            AssetChartWidget( // Chama o componente do gráfico de linha.
              startupId: widget.startup['id'] ?? _getStartupId(widget.startup['ticker']), // ID da startup.
              ticker: widget.startup['ticker'], // Código da bolsa.
            ), // Fim do gráfico.

            const SizedBox(height: 30), // Espaço de 30 pixels.

            OrderBookWidget(ticker: widget.startup['ticker']), // Chama o componente da tabela do livro de ofertas.

            const SizedBox(height: 30), // Espaço de 30 pixels.

            TransactionHistoryWidget( // Chama o componente do histórico de hoje.
              history: _historicoFake, // Passa a lista fake.
              ticker: widget.startup['ticker'], // Passa o ticker.
            ), // Fim do histórico.
            const SizedBox(height: 20), // Espaço final de 20 pixels no fundo.
          ], // Fim da lista de filhos da coluna principal.
        ), // Fim da coluna.
      ), // Fim do rolável.
    ); // Fim do Scaffold.
  } // Fim do método de desenho principal.
} // Fim da classe de estado principal.
