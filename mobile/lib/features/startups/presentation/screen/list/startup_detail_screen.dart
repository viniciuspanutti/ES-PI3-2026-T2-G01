// Vinícius Panutti Salgado - 25007329
// ── startup_detail_screen.dart ─────────────────────────────────────────
// Tela que exibe os detalhes completos de uma Startup específica.
//
// Funcionalidades principais:
//   1. Exibição fragmentada usando widgets de especialidade: 
//      StartupHeaderWidget, StartupMediaWidget, StartupSocietyWidget.
//   2. Integração com Firebase para validação de investimento via _checkIfInvestor,
//      controlando o acesso ao chat privado.
//   3. Abertura do BottomSheet customizado (_showQuestionModal) para opções
//      de enviar perguntas públicas (FAQ) ou privadas (somente investidor).
//   4. Botão flutuante "INVESTIR NESTA STARTUP" que direciona o utilizador
//      para o AssetDetailsScreen, simulando a compra de tokens (AMM).
//
// Fluxo de Negócio:
//   - A verificação de investidor é feita no Firebase consultando a coleção:
//     users/{userId}/investimentos/{startupId}.
// ───────────────────────────────────────────────────────────────────────
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/features/startups/domain/startup.dart';
import 'package:mobile/features/startups/presentation/screen/list/private_questions_chat_screen.dart';
import 'package:mobile/features/startups/presentation/widgets/startup_header_widget.dart';
import 'package:mobile/features/startups/presentation/widgets/startup_society_widget.dart';
import 'package:mobile/features/startups/presentation/widgets/startup_media_widget.dart';
import 'package:mobile/features/wallet/presentation/trade_market.dart';

// ── _QuestionSheetStep ───────────────────────────────────────────────
// Enum interno para controlar o estado do ModalBottomSheet de perguntas.
// Controla as fases de seleção (options), pergunta pública, e área restrita (privada).
enum _QuestionSheetStep { options, publicQuestion, privateQuestion }

// ── StartupDetailScreen ──────────────────────────────────────────────
class StartupDetailScreen extends StatelessWidget {
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
            StartupHeaderWidget(startup: startup),
            const SizedBox(height: 24),
            StartupMediaWidget(startup: startup),
            const SizedBox(height: 16),
            _StartupQuestionSection(startup: startup),
            const SizedBox(height: 32),
            StartupSocietyWidget(startup: startup),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  String ticker = startup.id.toUpperCase();
                  switch (startup.id) {
                    case 'agrisense': ticker = 'AGRI3'; break;
                    case 'devmatch': ticker = 'DEVM3'; break;
                    case 'ecocycle': ticker = 'ECYC1'; break;
                    case 'healthbit': ticker = 'HBIT3'; break;
                    case 'smartcampus': ticker = 'SCMP3'; break;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AssetDetailsScreen(
                        startup: {
                          'id': startup.id,
                          'nome': startup.name,
                          'ticker': ticker,
                          'logo': startup.coverImageUrl ?? '',
                          'preco': startup.currentTokenPriceCents / 100.0,
                          'valorizacao': '+0.0%',
                          'qtd': 0,
                          'setor': startup.tags.isNotEmpty ? startup.tags.first : '',
                        },
                      ),
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

class _StartupQuestionSection extends StatefulWidget {
  final StartupDetail startup;

  const _StartupQuestionSection({required this.startup});

  @override
  State<_StartupQuestionSection> createState() =>
      _StartupQuestionSectionState();
}

class _StartupQuestionSectionState extends State<_StartupQuestionSection> {
  final List<_PublicQuestion> _publicQuestions = [];

  Future<bool> _checkIfInvestor(String startupId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return false;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('investimentos')
          .doc(startupId)
          .get();

      if (!doc.exists) return false;
      final data = doc.data() as Map<String, dynamic>?;
      return (data?['tokensComprados'] ?? 0) > 0;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => _showQuestionModal(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'PERGUNTAR',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (_publicQuestions.isNotEmpty) ...[
          const SizedBox(height: 24),
          _buildPublicQuestionsSection(),
        ],
      ],
    );
  }

  Widget _buildPublicQuestionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Perguntas p\u00fablicas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 10),
        ..._publicQuestions.map((question) {
          return Card(
            elevation: 0,
            color: Colors.grey.shade50,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        question.author,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        question.time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    question.text,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  void _showQuestionModal(BuildContext context) {
    final TextEditingController questionController = TextEditingController();
    var currentStep = _QuestionSheetStep.options;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, modalSetState) {
            return AnimatedPadding(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: SafeArea(
                  top: false,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 22),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 46,
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0E3EA),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildQuestionSheetHeader(sheetContext),
                        const SizedBox(height: 24),
                        if (currentStep == _QuestionSheetStep.options)
                          _buildQuestionOptions(
                            onPublicTap: () {
                              modalSetState(() {
                                currentStep = _QuestionSheetStep.publicQuestion;
                              });
                            },
                            onPrivateTap: () async {
                              final navigator = Navigator.of(sheetContext);
                              final messenger = ScaffoldMessenger.of(context);

                              final isInvestor = await _checkIfInvestor(
                                widget.startup.id,
                              );
                              if (!mounted) return;

                              if (isInvestor) {
                                modalSetState(() {
                                  currentStep =
                                      _QuestionSheetStep.privateQuestion;
                                });
                              } else {
                                navigator.pop();
                                messenger.showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Acesso Restrito: Voc\u00ea precisa ser '
                                      'investidor desta startup para enviar '
                                      'perguntas privadas aos fundadores.',
                                    ),
                                    backgroundColor: Color(0xFF512DA8),
                                  ),
                                );
                              }
                            },
                          )
                        else if (currentStep ==
                            _QuestionSheetStep.publicQuestion)
                          _buildPublicQuestionForm(
                            questionController: questionController,
                            onChanged: () => modalSetState(() {}),
                            onSend: () {
                              final question = questionController.text.trim();
                              if (question.isEmpty) return;

                              setState(() {
                                _publicQuestions.insert(
                                  0,
                                  _PublicQuestion(
                                    author: 'Voc\u00ea',
                                    text: question,
                                    time: _formatTime(DateTime.now()),
                                  ),
                                );
                              });

                              Navigator.pop(sheetContext);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Pergunta p\u00fablica adicionada.',
                                  ),
                                ),
                              );
                            },
                            onBack: () {
                              modalSetState(() {
                                currentStep = _QuestionSheetStep.options;
                              });
                            },
                          )
                        else
                          _buildPrivateQuestionInfo(
                            onOpenChat: () {
                              Navigator.pop(sheetContext);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => PrivateQuestionsChatScreen(
                                    startup: widget.startup,
                                  ),
                                ),
                              );
                            },
                            onBack: () {
                              modalSetState(() {
                                currentStep = _QuestionSheetStep.options;
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(questionController.dispose);
  }

  Widget _buildQuestionSheetHeader(BuildContext sheetContext) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Fazer uma pergunta',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(sheetContext),
          icon: const Icon(Icons.close, color: Color(0xFF9AA3B2), size: 26),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
        ),
      ],
    );
  }

  Widget _buildQuestionOptions({
    required VoidCallback onPublicTap,
    required VoidCallback onPrivateTap,
  }) {
    return Column(
      children: [
        _buildQuestionOptionCard(
          icon: Icons.language,
          title: 'Pergunta p\u00fablica',
          description:
              'Aparece nos detalhes da startup para outros investidores visualizarem.',
          onTap: onPublicTap,
        ),
        const SizedBox(height: 14),
        _buildQuestionOptionCard(
          icon: Icons.lock_outline,
          title: 'Pergunta privada',
          description:
              'Chat exclusivo com os fundadores para investidores que possuem tokens.',
          onTap: onPrivateTap,
        ),
      ],
    );
  }

  Widget _buildQuestionOptionCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    const radius = 14.0;

    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFFE9ECF2), width: 1.2),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: InkWell(
          onTap: onTap,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F0FF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 27),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        description,
                        style: const TextStyle(
                          color: Color(0xFF697386),
                          fontSize: 14,
                          height: 1.35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPublicQuestionForm({
    required TextEditingController questionController,
    required VoidCallback onChanged,
    required VoidCallback onSend,
    required VoidCallback onBack,
  }) {
    final hasText = questionController.text.trim().isNotEmpty;

    return Column(
      children: [
        TextField(
          controller: questionController,
          minLines: 3,
          maxLines: 3,
          onChanged: (_) => onChanged(),
          style: const TextStyle(fontSize: 16, color: Color(0xFF111827)),
          decoration: InputDecoration(
            hintText: 'Escreva sua d\u00favida sobre a startup...',
            hintStyle: const TextStyle(
              color: Color(0xFF9AA3B2),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            contentPadding: const EdgeInsets.all(18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE9ECF2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: hasText ? onSend : null,
            style: ElevatedButton.styleFrom(
              elevation: hasText ? 4 : 0,
              backgroundColor: hasText
                  ? AppColors.primary
                  : const Color(0xFFE2E5EB),
              disabledBackgroundColor: const Color(0xFFE2E5EB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'ENVIAR PERGUNTA',
              style: TextStyle(
                color: hasText ? AppColors.white : const Color(0xFF9AA3B2),
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: onBack,
          child: const Text(
            'Voltar para op\u00e7\u00f5es',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrivateQuestionInfo({
    required VoidCallback onOpenChat,
    required VoidCallback onBack,
  }) {
    return Column(
      children: [
        const SizedBox(height: 2),
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: Color(0xFFF8F0FF),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.lock_outline,
            color: AppColors.primary,
            size: 34,
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Voc\u00ea ser\u00e1 direcionado para o chat privado,\n'
          'uma \u00e1rea exclusiva para detentores de tokens\n'
          'desta startup.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF4B5563),
            fontSize: 16,
            height: 1.35,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 26),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: onOpenChat,
            style: ElevatedButton.styleFrom(
              elevation: 10,
              shadowColor: AppColors.primary.withValues(alpha: 0.25),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'IR PARA CHAT PRIVADO',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: onBack,
          child: const Text(
            'Voltar para op\u00e7\u00f5es',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _PublicQuestion {
  final String author;
  final String text;
  final String time;

  const _PublicQuestion({
    required this.author,
    required this.text,
    required this.time,
  });
}
