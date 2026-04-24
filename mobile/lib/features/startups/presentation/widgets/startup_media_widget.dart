import 'package:flutter/material.dart';
import '../../domain/startup.dart'; 

class StartupMediaWidget extends StatelessWidget {
  final StartupDetail startup;

  const StartupMediaWidget({super.key, required this.startup});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Sumário Executivo",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF512DA8)),
        ),
        const SizedBox(height: 10),
        Text(
          startup.executiveSummary.isNotEmpty ? startup.executiveSummary : 'Nenhum sumário disponível no momento.',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.5),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 20),

        if (startup.videoUrl != null && startup.videoUrl!.isNotEmpty) ...[
          const Text(
            "Apresentação",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Icon(Icons.play_circle_fill, color: Colors.white, size: 60),
            ),
          ),
          const SizedBox(height: 20),
        ],

        if (startup.faq.isNotEmpty) ...[
          const Text(
            "Perguntas Frequentes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF512DA8)),
          ),
          const SizedBox(height: 10),
          ...startup.faq.map((pergunta) {
            return Card(
              elevation: 0,
              color: Colors.grey.shade50,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ExpansionTile(
                title: Text(pergunta['question'] ?? '', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      pergunta['answer'] ?? '',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
            );
          }),
        ]
      ],
    );
  }
}
