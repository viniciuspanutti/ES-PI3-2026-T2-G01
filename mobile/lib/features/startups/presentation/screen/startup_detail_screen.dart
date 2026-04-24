/*Vinícius ->
* Explicação do código:
* Esta é a tela de "Molde" (Template) para os detalhes de qualquer Startup.
* Ela recebe um objeto 'StartupDetail' e distribui os dados entre widgets menores
* para manter o código limpo e organizado (Clean Architecture).*/

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/startup.dart';
import '../widgets/startup_header_widget.dart';
import '../widgets/startup_society_widget.dart';
import '../widgets/startup_media_widget.dart';

class StartupDetailScreen extends StatelessWidget {
  // O parâmetro 'startup' torna a tela dinâmica.
  final StartupDetail startup;

  const StartupDetailScreen({super.key, required this.startup});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detalhes da Startup',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Cabeçalho: Imagem e Título (Isolado em widget próprio)
            StartupHeaderWidget(startup: startup),

            const SizedBox(height: 24),

            // 2. Mídias: Sumário, Vídeos e FAQ (Isolado em widget próprio)
            StartupMediaWidget(startup: startup),

            const SizedBox(height: 32),

            // 3. Sociedade: Sócios e Capital (Isolado em widget próprio)
            StartupSocietyWidget(startup: startup),

            const SizedBox(height: 40),

            // Botão de Investimento (Placeholder para funcionalidade futura)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Futura implementação de compra de tokens
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Funcionalidade de Investimento em breve!'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'INVESTIR NESTA STARTUP',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
