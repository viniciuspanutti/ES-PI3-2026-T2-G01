import 'package:flutter/material.dart';

class CampoDeTexto extends StatelessWidget {
  final TextEditingController controller; // pegar o que o usuario digitou dps
  final String hintText; // colocar o texto em cima de onde digitar
  final bool obscureText; // esconder a senha

  const CampoDeTexto({
    super.key, 
    required this.controller,
    required this.hintText,
    required this.obscureText
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey[200],
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
