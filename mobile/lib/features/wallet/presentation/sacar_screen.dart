//feito por: Tom 
// Importa o suporte para chamadas de funções serverless do Firebase Cloud Functions
import 'package:cloud_functions/cloud_functions.dart';
// Importa os widgets básicos e o framework Material Design do Flutter
import 'package:flutter/material.dart';

// Define a tela de saque como um widget que possui estado interno
class SacarScreen extends StatefulWidget {
  // Construtor da tela com suporte opcional a chaves de identificação
  const SacarScreen({super.key});

  // Cria o estado interno associado a este widget de saque
  @override
  State<SacarScreen> createState() => _SacarScreenState();
}

// Classe privada que gerencia o estado e a lógica da tela de saque
class _SacarScreenState extends State<SacarScreen> {
  // Define a cor roxa primária utilizada na identidade visual da tela
  static const primaryPurple = Color(0xFF6B33B4);
  // Controlador para gerenciar o texto inserido no campo de valor do saque
  final _valorController = TextEditingController();
  // Variável para armazenar o identificador do método de saque selecionado (padrão débito)
  String _metodoSelecionado = 'debito';
  // Booleano para indicar se uma operação de saque está em processamento
  bool _enviando = false;

  // Lista de mapas contendo os dados dos métodos de saque disponíveis
  final _metodos = [
    {
      // Identificador único para o método de débito
      'id': 'debito',
      // Nome amigável do método de débito
      'nome': 'Cartão de débito',
      // Descrição do cartão (número mascarado)
      'desc': '•••• •••• •••• 4321',
      // Cor de fundo para o ícone do método
      'iconBg': Color(0xFFEEEDFE),
      // Cor principal do ícone do método
      'iconColor': Color(0xFF534AB7),
    },
    {
      // Identificador único para o método de crédito
      'id': 'credito',
      // Nome amigável do método de crédito
      'nome': 'Cartão de crédito',
      // Descrição do cartão (número mascarado)
      'desc': '•••• •••• •••• 8765',
      // Cor de fundo para o ícone do método
      'iconBg': Color(0xFFFBEAF0),
      // Cor principal do ícone do método
      'iconColor': Color(0xFF993556),
    },
  ];

  // Método chamado quando o widget é removido permanentemente da árvore
  @override
  void dispose() {
    // Libera os recursos do controlador de texto para evitar vazamentos de memória
    _valorController.dispose();
    // Chama a implementação original da classe pai
    super.dispose();
  }

  // Método auxiliar para atualizar o valor no campo de texto de forma programática
  void _setValor(double valor) {
    // Atualiza o estado da tela para refletir o novo valor formatado
    setState(() {
      _valorController.text = valor.toStringAsFixed(2);
    });
  }

  // Método assíncrono para confirmar e processar a solicitação de saque
  void _confirmar() async {
    // Tenta converter o texto do controlador em um número de ponto flutuante
    final valor = double.tryParse(_valorController.text);
    // Valida se o valor inserido é numérico e maior que zero
    if (valor == null || valor <= 0) {
      // Exibe uma notificação de erro se o valor for inválido
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe um valor válido.')),
      );
      // Interrompe a execução do método
      return;
    }

    // Atualiza o estado para indicar que o envio está em progresso
    setState(() => _enviando = true);

    try {
      // Obtém a instância do Firebase Functions configurada para a região central
      final functions = FirebaseFunctions.instanceFor(region: 'us-central1');
      // Chama a função remota 'sacar' passando o valor pretendido
      final resultado = await functions.httpsCallable('sacar').call({
        'valor': valor,
      });

      // Verifica se a operação foi concluída com sucesso no servidor
      if (resultado.data['success'] == true) {
        // Garante que o widget ainda está ativo antes de navegar
        if (!mounted) return;
        // Navega para a tela principal resetando toda a pilha de telas
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      } else {
        // Garante que o widget ainda está ativo
        if (!mounted) return;
        // Exibe a mensagem de erro retornada pelo servidor
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resultado.data['message'])),
        );
      }
    } catch (e) {
      // Garante que o widget ainda está ativo
      if (!mounted) return;
      // Exibe uma mensagem de erro genérica em caso de falha na comunicação
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao realizar saque.')),
      );
    } finally {
      // Reseta o estado de envio se o widget ainda estiver montado
      if (mounted) setState(() => _enviando = false);
    }
  }

  // Método principal responsável por construir a interface visual da tela
  @override
  Widget build(BuildContext context) {
    // Retorna a estrutura básica de layout da página
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      // Define a barra superior da aplicação
      appBar: AppBar(
        // Define as cores e estilos da barra superior
        backgroundColor: Colors.white,
        foregroundColor: primaryPurple,
        elevation: 0,
        centerTitle: true,
        // Define o título exibido no centro da barra superior
        title: const Text('Sacar'),
      ),
      // Permite a rolagem do conteúdo caso ultrapasse o tamanho da tela
      body: SingleChildScrollView(
        // Adiciona um preenchimento interno de 16 pixels em todo o corpo
        padding: const EdgeInsets.all(16),
        // Organiza os componentes em uma coluna vertical
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chama o método para construir o cartão de entrada de valor
            _cardValor(),
            // Adiciona um espaçamento vertical de 16 pixels
            const SizedBox(height: 16),
            // Chama o método para construir o cartão de seleção de método
            _cardMetodo(),
            // Adiciona um espaçamento vertical de 24 pixels
            const SizedBox(height: 24),
            // Widget que expande o botão para ocupar toda a largura disponível
            SizedBox(
              width: double.infinity,
              // Botão de ação para confirmar a operação de saque
              child: ElevatedButton(
                // Define a ação de clique, desativada se estiver enviando
                onPressed: _enviando ? null : _confirmar,
                // Configura o estilo visual do botão
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                // Exibe um indicador de progresso ou o texto do botão
                child: _enviando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        // Círculo de carregamento exibido durante o envio
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Confirmar saque',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método que constrói o widget do cartão para entrada do valor
  Widget _cardValor() {
    // Container estilizado que agrupa os campos de valor
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      // Organiza os elementos internos em uma coluna
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exibe o rótulo de instrução para o campo de valor
          const Text(
            'Valor do saque',
            style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
          ),
          // Adiciona um espaçamento vertical de 10 pixels
          const SizedBox(height: 10),
          // Container que simula o campo de entrada com prefixo R$
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12, width: 0.5),
            ),
            // Organiza o símbolo da moeda e o campo de texto em uma linha
            child: Row(
              children: [
                // Exibe o símbolo da moeda brasileira
                const Text(
                  'R\$',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF888888),
                  ),
                ),
                // Adiciona um espaçamento horizontal de 8 pixels
                const SizedBox(width: 8),
                // Expande o campo de texto para ocupar o restante da linha
                Expanded(
                  child: TextField(
                    controller: _valorController,
                    // Define o teclado numérico com suporte a decimais
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    // Define o estilo do texto inserido (tamanho grande e negrito)
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1A1A),
                    ),
                    // Configura a decoração interna do campo de texto
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
          // Adiciona um espaçamento vertical de 6 pixels
          const SizedBox(height: 6),
          // Exibe informação sobre o saldo atual do usuário
          const Text(
            'Saldo disponível: ',
            style: TextStyle(fontSize: 12, color: Color(0xFF888888)),
          ),
          // Adiciona um espaçamento vertical de 12 pixels
          const SizedBox(height: 12),
          // Organiza sugestões de valores rápidos em uma disposição flexível
          Wrap(
            spacing: 8,
            // Mapeia uma lista de valores fixos para widgets clicáveis
            children: [50.0, 100.0, 250.0, 500.0].map((v) {
              // Widget que detecta o toque para selecionar o valor sugerido
              return GestureDetector(
                onTap: () => _setValor(v),
                // Container que estiliza o chip de sugestão de valor
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black12, width: 0.5),
                  ),
                  // Exibe o valor formatado como número inteiro
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

  // Método que constrói o widget do cartão para seleção do destino do saque
  Widget _cardMetodo() {
    // Container estilizado que agrupa as opções de destino
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      // Organiza os elementos em uma coluna vertical
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exibe o rótulo de instrução para seleção do destino
          const Text(
            'Destino do saque',
            style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
          ),
          // Adiciona um espaçamento vertical de 12 pixels
          const SizedBox(height: 12),
          // Mapeia a lista de métodos cadastrados para widgets visuais
          ..._metodos.map((m) {
            // Verifica se este método é o que está selecionado atualmente
            final selecionado = _metodoSelecionado == m['id'];
            // Retorna o item com espaçamento inferior
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              // Widget que detecta o toque para selecionar o método de saque
              child: GestureDetector(
                onTap: () => setState(() => _metodoSelecionado = m['id'] as String),
                // Container que estiliza a borda e o fundo do item de método
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    // Destaca a borda se o item estiver selecionado
                    border: Border.all(
                      color: selecionado ? primaryPurple : Colors.black12,
                      width: selecionado ? 2 : 0.5,
                    ),
                  ),
                  // Organiza ícone, textos e indicador de seleção em uma linha
                  child: Row(
                    children: [
                      // Container que envolve o ícone do método de saque
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: m['iconBg'] as Color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // Exibe o ícone de cartão configurado com a cor correspondente
                        child: Icon(Icons.credit_card, color: m['iconColor'] as Color, size: 20),
                      ),
                      // Adiciona um espaçamento horizontal de 14 pixels
                      const SizedBox(width: 14),
                      // Expande os textos para ocupar o espaço central disponível
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Exibe o nome do método de saque (ex: Cartão de débito)
                            Text(
                              m['nome'] as String,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                            // Exibe a descrição do método (ex: número mascarado)
                            Text(
                              m['desc'] as String,
                              style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
                            ),
                            // Etiqueta indicando que o método está salvo na conta
                            Container(
                              margin: const EdgeInsets.only(top: 3),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF2FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Salvo',
                                style: TextStyle(fontSize: 10, color: Color(0xFF534AB7)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Widget que exibe o círculo de seleção (radio button customizado)
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selecionado ? primaryPurple : Colors.black26,
                            width: 2,
                          ),
                        ),
                        // Exibe um ponto central roxo se o item estiver selecionado
                        child: selecionado
                            ? Center(
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryPurple,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          // Widget que detecta o toque para adicionar um novo método (não implementado)
          GestureDetector(
            onTap: () {},
            // Container com borda pontilhada/sólida para o botão de adição
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12, width: 0.5, style: BorderStyle.solid),
              ),
              // Organiza o ícone de adição e o texto em uma linha
              child: const Row(
                children: [
                  // Exibe o ícone de sinal de mais em roxo
                  Icon(Icons.add, color: primaryPurple, size: 18),
                  // Adiciona um espaçamento horizontal de 10 pixels
                  SizedBox(width: 10),
                  // Exibe o rótulo descritivo da ação de adição
                  Text(
                    'Adicionar novo método',
                    style: TextStyle(fontSize: 14, color: primaryPurple),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}