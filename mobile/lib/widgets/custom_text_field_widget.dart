// Tom Bean
// importa o pacote Material Design do Flutter
import 'package:flutter/material.dart';

// classe Stateless para campo de texto customizado
class CampoDeTexto extends StatelessWidget {
  // TextEditingController para capturar e gerenciar entrada do usuário
  final TextEditingController controller; // pegar o que o usuario digitou dps
  // texto de dica exibido quando o campo está vazio
  final String hintText; // colocar o texto em cima de onde digitar
  // booleano para esconder/mostrar texto (tipicamente para senhas)
  final bool obscureText; // esconder a senha
  // widget opcional (tipicamente um ícone) exibido no final do campo
  final Widget? suffixIcon; // ícone opcional no final do campo

  // construtor que recebe parâmetros obrigatórios e opcionais
  const CampoDeTexto({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.suffixIcon,
  });

  // método que constrói a interface do widget
  @override
  Widget build(BuildContext context) {
    // Padding adiciona espaçamento ao redor do campo de texto
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      // TextField widget para entrada de texto
      child: TextField(
        // conecta o TextField ao controller para capturar entrada
        controller: controller,
        // esconde o texto se obscureText for verdadeiro
        obscureText: obscureText,
        // InputDecoration para estilizar a aparência do campo
        decoration: InputDecoration(
          // estilo da borda quando o campo não está focado
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          // estilo da borda quando o campo está focado
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          // define a cor de preenchimento de fundo
          fillColor: Colors.grey[200],
          // habilita o preenchimento de fundo
          filled: true,
          // exibe texto de dica no campo
          hintText: hintText,
          // exibe ícone opcional no final do campo
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
