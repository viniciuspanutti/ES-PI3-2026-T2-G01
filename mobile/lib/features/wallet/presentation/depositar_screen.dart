// Tom Bean
// Importa o pacote para chamadas de funções serverless do Firebase Cloud Functions
import 'package:cloud_functions/cloud_functions.dart';
// Importa os widgets básicos e o framework Material Design do Flutter
import 'package:flutter/material.dart';

// Define a tela de depósito como um widget que possui estado interno
class DepositarScreen extends StatefulWidget {
  // Construtor da tela com suporte opcional a chaves de identificação
  const DepositarScreen({super.key});

  // Cria o estado interno associado a este widget de depósito
  @override
  State<DepositarScreen> createState() => _DepositarScreenState();
}

// Classe privada que gerencia o estado e a lógica da tela de depósito
class _DepositarScreenState extends State<DepositarScreen> {
  // Cor roxa principal usada nos elementos visuais da tela
  static const primaryPurple = Color(0xFF6B33B4);
  // Controlador de texto para capturar o valor digitado pelo usuário
  final _valorController = TextEditingController();
  // Armazena o método de pagamento selecionado pelo usuário (nulo se nenhum foi escolhido)
  String? _metodoSelecionado;
  // Indica se o depósito está sendo processado para bloquear o botão
  bool _enviando = false; 

  // Libera os recursos do controlador de texto quando o widget é destruído
  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  // Preenche o campo de valor com um valor predefinido ao clicar nos atalhos
  void _setValor(double valor) {
    setState(() {
      _valorController.text = valor.toStringAsFixed(2);
    });
  }

  // Valida os campos e chama a Cloud Function de depósito
  void _confirmar() async {
  // Tenta converter o texto digitado para um número decimal
  final valor = double.tryParse(_valorController.text);
  // Verifica se o valor é válido e maior que zero
  if (valor == null || valor <= 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Informe um valor válido.')),
    );
    return;
  }
  // Verifica se o usuário selecionou um método de pagamento
  if (_metodoSelecionado == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Selecione um método de pagamento.')),
    );
    return;
  }

  // Ativa o estado de carregamento e desabilita o botão
  setState(() => _enviando = true);

  try {
    // Obtém a instância das Cloud Functions na região us-central1
    final functions = FirebaseFunctions.instanceFor(region: 'us-central1');
    // Chama a função de depósito passando o valor informado
    final resultado = await functions.httpsCallable('depositar').call({
      'valor': valor,
    });

    // Verifica se o depósito foi realizado com sucesso
    if (resultado.data['success'] == true) {
      // Garante que o widget ainda está montado antes de navegar
      if (!mounted) return;
      // Aguarda o frame atual terminar antes de executar a navegação
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Verifica novamente se o contexto ainda está disponível
        if (context.mounted) {
          // Volta para a tela anterior após o depósito
          Navigator.pop(context);
        }
      });
    } else {
      // Garante que o widget ainda está montado antes de exibir erro
      if (!mounted) return;
      // Exibe a mensagem de erro retornada pela função
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultado.data['message'])),
      );
    }
  } catch (e) {
    // Garante que o widget ainda está montado antes de exibir erro
    if (!mounted) return;
    // Exibe mensagem de erro genérica em caso de falha na chamada
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Erro ao realizar depósito.')),
    );
  }
}

  // Constrói a interface visual da tela de depósito
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Define a cor de fundo da tela
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        // Cor de fundo da barra superior
        backgroundColor: Colors.white,
        // Cor dos ícones e textos da barra superior
        foregroundColor: primaryPurple,
        // Remove a sombra da barra superior
        elevation: 0,
        // Centraliza o título na barra superior
        centerTitle: true,
        // Título exibido na barra superior
        title: const Text('Depositar'),
      ),
      body: SingleChildScrollView(
        // Espaçamento interno do conteúdo rolável
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card com o campo de valor do depósito
            _cardValor(),
            const SizedBox(height: 16),
            // Card com as opções de método de pagamento
            _cardMetodo(),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // Desabilita o botão enquanto o depósito está sendo processado
                onPressed: _enviando ? null : _confirmar,
                style: ElevatedButton.styleFrom(
                  // Cor de fundo do botão de confirmação
                  backgroundColor: primaryPurple,
                  // Cor do texto do botão
                  foregroundColor: Colors.white,
                  // Espaçamento vertical interno do botão
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    // Borda arredondada do botão
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                // Exibe spinner durante o processamento ou o texto do botão
                child: _enviando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        // Indicador de carregamento circular branco
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

  // Constrói o card com o campo de entrada do valor e atalhos de valores
  Widget _cardValor() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Fundo branco do card
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        // Borda sutil ao redor do card
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rótulo do campo de valor
          const Text(
            'Valor do depósito',
            style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              // Fundo cinza claro do campo de entrada
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12, width: 0.5),
            ),
            child: Row(
              children: [
                // Prefixo de moeda exibido antes do campo de texto
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
                    // Associa o controlador ao campo de texto
                    controller: _valorController,
                    // Teclado numérico com suporte a decimais
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1A1A),
                    ),
                    decoration: const InputDecoration(
                      // Texto de dica exibido quando o campo está vazio
                      hintText: '0,00',
                      hintStyle: TextStyle(color: Color(0xFFBBBBBB)),
                      // Remove a borda padrão do campo
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
          // Botões de atalho para valores predefinidos
          Wrap(
            spacing: 8,
            children: [50.0, 100.0, 250.0, 500.0].map((v) {
              return GestureDetector(
                // Preenche o campo com o valor ao tocar no atalho
                onTap: () => _setValor(v),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black12, width: 0.5),
                  ),
                  // Exibe o valor formatado como moeda
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

  // Constrói o card com as opções de método de pagamento
  Widget _cardMetodo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Fundo branco do card de método
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rótulo da seção de método de pagamento
          const Text(
            'Método de pagamento',
            style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
          ),
          const SizedBox(height: 12),
          // Opção de pagamento por débito
          _MetodoItem(
            id: 'debito',
            nome: 'Débito',
            descricao: 'Saldo disponível imediatamente',
            icon: Icons.credit_card,
            iconBg: const Color(0xFFEEEDFE),
            iconColor: const Color(0xFF534AB7),
            // Verifica se débito está selecionado
            selecionado: _metodoSelecionado == 'debito',
            // Atualiza o método selecionado para débito
            onTap: () => setState(() => _metodoSelecionado = 'debito'),
          ),
          const SizedBox(height: 10),
          // Opção de pagamento por crédito
          _MetodoItem(
            id: 'credito',
            nome: 'Crédito',
            descricao: 'Parcelamento disponível',
            icon: Icons.wallet,
            iconBg: const Color(0xFFFBEAF0),
            iconColor: const Color(0xFF993556),
            // Verifica se crédito está selecionado
            selecionado: _metodoSelecionado == 'credito',
            // Atualiza o método selecionado para crédito
            onTap: () => setState(() => _metodoSelecionado = 'credito'),
          ),
          const SizedBox(height: 10),
          // Opção de pagamento por Pix
          _MetodoItem(
            id: 'pix',
            nome: 'Pix',
            descricao: 'Transferência instantânea',
            icon: Icons.qr_code,
            iconBg: const Color(0xFFE1F5EE),
            iconColor: const Color(0xFF0F6E56),
            // Verifica se Pix está selecionado
            selecionado: _metodoSelecionado == 'pix',
            // Atualiza o método selecionado para Pix
            onTap: () => setState(() => _metodoSelecionado = 'pix'),
          ),
        ],
      ),
    );
  }
}

// Widget reutilizável que representa um item de método de pagamento
class _MetodoItem extends StatelessWidget {
  // Construtor com todos os parâmetros obrigatórios do item
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

  // Identificador único do método de pagamento
  final String id;
  // Nome exibido do método de pagamento
  final String nome;
  // Descrição curta do método de pagamento
  final String descricao;
  // Ícone representativo do método
  final IconData icon;
  // Cor de fundo do container do ícone
  final Color iconBg;
  // Cor do ícone
  final Color iconColor;
  // Indica se este método está atualmente selecionado
  final bool selecionado;
  // Callback executado ao tocar no item
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Executa o callback ao tocar no item
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          // Destaca a borda quando o item está selecionado
          border: Border.all(
            color: selecionado ? const Color(0xFF6B33B4) : Colors.black12,
            width: selecionado ? 2 : 0.5,
          ),
        ),
        child: Row(
          children: [
            // Container circular com o ícone do método
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
                  // Nome do método de pagamento
                  Text(
                    nome,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  // Descrição do método de pagamento
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
            // Indicador visual de seleção (radio button customizado)
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  // Borda roxa quando selecionado, cinza quando não
                  color: selecionado ? const Color(0xFF6B33B4) : Colors.black26,
                  width: 2,
                ),
              ),
              // Exibe o ponto interno apenas quando selecionado
              child: selecionado
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          // Ponto roxo interno indicando seleção
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