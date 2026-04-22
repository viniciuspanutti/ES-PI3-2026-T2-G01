import 'package:flutter/material.dart';

class SetaVoltar extends StatelessWidget {
  final VoidCallback ontap;

  const SetaVoltar({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
    );
  }
}