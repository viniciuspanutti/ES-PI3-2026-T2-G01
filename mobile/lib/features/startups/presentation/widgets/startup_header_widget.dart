/*Vinícius ->
* Explicação do código:
* Widget responsável pelo cabeçalho da página de detalhes da startup.
* Exibe a imagem de capa, o nome da startup e a tag do estágio atual.*/

import 'package:flutter/material.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/startup.dart';

class StartupHeaderWidget extends StatelessWidget {
  final StartupDetail startup;

  const StartupHeaderWidget({super.key, required this.startup});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Imagem de Capa
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child:
              startup.coverImageUrl != null && startup.coverImageUrl!.isNotEmpty
              ? Image.network(
                  startup.coverImageUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildPlaceholder(),
                )
              : _buildPlaceholder(),
        ),
        const SizedBox(height: 16),
        // Nome da Startup
        Text(startup.name, style: AppTypography.heading1),
        const SizedBox(height: 8),
        // Estágio da Startup (Tag)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            startup.stage.toUpperCase(),
            style: AppTypography.caption.copyWith(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  /// Placeholder simples caso a imagem não carregue ou não exista.
  Widget _buildPlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[300],
      child: const Icon(Icons.business, size: 50, color: Colors.grey),
    );
  }
}
