// Importa o pacote para usar Firebase Cloud Functions
import 'package:cloud_functions/cloud_functions.dart';
// Importa o pacote principal do Flutter com widgets de Material Design
import 'package:flutter/material.dart';

// Define a tela de saque como um widget com estado mutável
class SacarScreen extends StatefulWidget {
  // Construtor constante que repassa a chave para o widget pai
  const SacarScreen({super.key});

  @override
  // Cria o objeto de estado associado a este widget
  State<SacarScreen> createState() => _SacarScreenState();
}

// Classe de estado privada da SacarScreen
class _SacarScreenState extends State<SacarScreen> {
  // Cor roxa primária usada em toda a tela
  static const primaryPurple = Color(0xFF6B33B4);
  // Controlador do campo de texto para o valor do saque
  final _valorController = TextEditingController();
  // Método de pagamento selecionado por padrão (débito)
  String _metodoSelecionado = 'debito';
  // Controla se a requisição está em andamento para evitar duplo envio
  bool _enviando = false;

  // Lista de métodos de pagamento disponíveis para saque
  final _metodos = [
    {
      // Identificador único do método débito
      'id': 'debito',
      // Nome exibido na UI
      'nome': 'Cartão de débito',
      // Número mascarado do cartão
      'desc': '•••• •••• •••• 4321',
      // Cor de fundo do ícone
      'iconBg': Color(0xFFEEEDFE),
      // Cor do ícone
      'iconColor': Color(0xFF534AB7),
    },
    {
      // Identificador único do método crédito
      'id': 'credito',
      // Nome exibido na UI
      'nome': 'Cartão de crédito',
      // Número mascarado do cartão
      'desc': '•••• •••• •••• 8765',
      // Cor de fundo do ícone
      'iconBg': Color(0xFFFBEAF0),
      // Cor do ícone
      'iconColor': Color(0xFF993556),
    },
  ];

  @override
  // Libera o controlador de texto da memória quando o widget é destruído
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  // Define um valor predefinido no campo de texto ao clicar nos atalhos
  void _setValor(double valor) {
    // Atualiza o estado com o valor formatado com 2 casas decimais
    setState(() {
      _valorController.text = valor.toStringAsFixed(2);
    });
  }

  // Função chamada ao confirmar o saque
  void _confirmar() async {
    // Tenta converter o texto digitado para double
    final valor = double.tryParse(_valorController.text);
    // Valida se o valor é nulo ou menor/igual a zero
    if (valor == null || valor <= 0) {
      // Exibe mensagem de erro se o valor for inválido
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe um valor válido.')),
      );
      return;
    }

    // Ativa o estado de carregamento para bloquear novo envio e mostrar o spinner
    setState(() => _enviando = true);

    try {
      // Obtém a instância do Firebase Functions na região us-central1
      final functions = FirebaseFunctions.instanceFor(region: 'us-central1');
      // Chama a Cloud Function 'sacar' passando o valor como parâmetro
      final resultado = await functions.httpsCallable('sacar').call({
        'valor': valor,
      });

      // Verifica se a função retornou sucesso
      if (resultado.data['success'] == true) {
        // Garante que o widget ainda está montado antes de navegar
        if (!mounted) return;
        // Navega para a tela principal removendo todas as rotas anteriores
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      } else {
        // Garante que o widget ainda está montado antes de exibir mensagem
        if (!mounted) return;
        // Exibe a mensagem de erro retornada pela Cloud Function
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resultado.data['message'])),
        );
      }
    } catch (e) {
      // Garante que o widget ainda está montado antes de exibir mensagem
      if (!mounted) return;
      // Exibe mensagem genérica de erro em caso de exceção
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao realizar saque.')),
      );
    }
  }

  @override
  // Constrói a árvore de widgets da tela
  Widget build(BuildContext context) {
    return Scaffold(
      // Cor de fundo cinza claro da tela
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        // Fundo branco da AppBar
        backgroundColor: Colors.white,
        // Ícones e texto da AppBar na cor roxa primária
        foregroundColor: primaryPurple,
        // Remove a sombra da AppBar
        elevation: 0,
        // Centraliza o título
        centerTitle: true,
        title: const Text('Sacar'),
      ),
      // Permite rolagem caso o conteúdo ultrapasse a tela
      body: SingleChildScrollView(
        // Espaçamento interno de 16px em todos os lados
        padding: const EdgeInsets.all(16),
        child: Column(
          // Alinha os filhos à esquerda
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card de entrada do valor do saque
            _cardValor(),
            const SizedBox(height: 16),
            // Card de seleção do método de destino
            _cardMetodo(),
            const SizedBox(height: 24),
            // Botão de confirmação ocupa toda a largura disponível
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // Desabilita o botão enquanto está enviando
                onPressed: _enviando ? null : _confirmar,
                style: ElevatedButton.styleFrom(
                  // Cor de fundo roxa primária
                  backgroundColor: primaryPurple,
                  // Texto branco
                  foregroundColor: Colors.white,
                  // Espaçamento vertical interno do botão
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    // Bordas arredondadas de 14px
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                // Exibe spinner de carregamento enquanto envia, senão exibe o texto
                child: _enviando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        // Indicador circular de progresso branco
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

  // Constrói o card de entrada do valor do saque
  Widget _cardValor() {
    return Container(
      // Espaçamento interno de 16px
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Fundo branco
        color: Colors.white,
        // Bordas arredondadas de 14px
        borderRadius: BorderRadius.circular(14),
        // Borda fina cinza clara
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rótulo do campo de valor
          const Text(
            'Valor do saque',
            style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
          ),
          const SizedBox(height: 10),
          // Container que envolve o campo de texto com estilo de input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              // Fundo cinza claro do input
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12, width: 0.5),
            ),
            child: Row(
              children: [
                // Prefixo "R$" exibido antes do campo de texto
                const Text(
                  'R\$',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF888888),
                  ),
                ),
                const SizedBox(width: 8),
                // Campo de texto que ocupa o restante da linha
                Expanded(
                  child: TextField(
                    // Vincula o controlador ao campo
                    controller: _valorController,
                    // Teclado numérico com suporte a decimal
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1A1A),
                    ),
                    decoration: const InputDecoration(
                      // Texto placeholder quando o campo está vazio
                      hintText: '0,00',
                      hintStyle: TextStyle(color: Color(0xFFBBBBBB)),
                      // Remove a borda padrão do TextField
                      border: InputBorder.none,
                      isDense: true,
                      // Remove o padding padrão interno
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          // Exibe o saldo disponível do usuário
          const Text(
            'Saldo disponível: ',
            style: TextStyle(fontSize: 12, color: Color(0xFF888888)),
          ),
          const SizedBox(height: 12),
          // Botões de atalho para valores predefinidos
          Wrap(
            spacing: 8,
            // Gera um chip para cada valor da lista
            children: [50.0, 100.0, 250.0, 500.0].map((v) {
              return GestureDetector(
                // Ao tocar, define o valor no campo de texto
                onTap: () => _setValor(v),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    // Formato de pílula arredondada
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black12, width: 0.5),
                  ),
                  // Exibe o valor sem casas decimais (ex: R$ 50)
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

  // Constrói o card de seleção do método de destino do saque
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
          // Rótulo da seção de destino
          const Text(
            'Destino do saque',
            style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
          ),
          const SizedBox(height: 12),
          // Itera sobre a lista de métodos e gera um item para cada um
          ..._metodos.map((m) {
            // Verifica se este método é o atualmente selecionado
            final selecionado = _metodoSelecionado == m['id'];
            return Padding(
              // Espaçamento inferior entre os itens
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                // Ao tocar, atualiza o método selecionado
                onTap: () => setState(() => _metodoSelecionado = m['id'] as String),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    // Borda roxa e mais grossa quando selecionado, cinza fina quando não
                    border: Border.all(
                      color: selecionado ? primaryPurple : Colors.black12,
                      width: selecionado ? 2 : 0.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Ícone do método com fundo colorido
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          // Cor de fundo específica do método
                          color: m['iconBg'] as Color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // Ícone de cartão na cor específica do método
                        child: Icon(Icons.credit_card, color: m['iconColor'] as Color, size: 20),
                      ),
                      const SizedBox(width: 14),
                      // Informações textuais do método ocupam o espaço restante
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nome do método (ex: Cartão de débito)
                            Text(
                              m['nome'] as String,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                            // Número mascarado do cartão
                            Text(
                              m['desc'] as String,
                              style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
                            ),
                            // Badge indicando que o cartão está salvo
                            Container(
                              margin: const EdgeInsets.only(top: 3),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                // Fundo azul claro do badge
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
                      // Radio button customizado indicando seleção
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // Borda roxa quando selecionado, cinza quando não
                          border: Border.all(
                            color: selecionado ? primaryPurple : Colors.black26,
                            width: 2,
                          ),
                        ),
                        // Exibe o ponto interno apenas quando selecionado
                        child: selecionado
                            ? Center(
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  // Ponto roxo central do radio button
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
          // Botão para adicionar um novo método de pagamento
          GestureDetector(
            // TODO: implementar navegação para adicionar novo método
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // Borda tracejada/sólida fina cinza
                border: Border.all(color: Colors.black12, width: 0.5, style: BorderStyle.solid),
              ),
              child: const Row(
                children: [
                  // Ícone de adição roxo
                  Icon(Icons.add, color: primaryPurple, size: 18),
                  SizedBox(width: 10),
                  // Texto do botão de adição
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