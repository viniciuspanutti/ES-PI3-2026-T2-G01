import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../domain/startup.dart';
import 'youtube_web_embed.dart';

class StartupMediaWidget extends StatefulWidget {
  final StartupDetail startup;

  const StartupMediaWidget({super.key, required this.startup});

  @override
  State<StartupMediaWidget> createState() => _StartupMediaWidgetState();
}

class _StartupMediaWidgetState extends State<StartupMediaWidget> {
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) return;

    if (widget.startup.videoUrl != null &&
        widget.startup.videoUrl!.isNotEmpty) {
      final videoId = YoutubePlayer.convertUrlToId(widget.startup.videoUrl!);
      if (videoId != null) {
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
        );
      }
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoId = widget.startup.videoUrl?.isNotEmpty == true
        ? YoutubePlayer.convertUrlToId(widget.startup.videoUrl!)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Sumário Executivo",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF512DA8),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.startup.executiveSummary.isNotEmpty
              ? widget.startup.executiveSummary
              : 'Nenhum sumário disponível no momento.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            height: 1.5,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 20),

        if (widget.startup.videoUrl != null &&
            widget.startup.videoUrl!.isNotEmpty) ...[
          const Text(
            "Apresentação",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          if (kIsWeb && videoId != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: YoutubeWebEmbed(videoId: videoId),
              ),
            )
          else if (_youtubeController != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: YoutubePlayer(
                controller: _youtubeController!,
                showVideoProgressIndicator: true,
                progressColors: const ProgressBarColors(
                  playedColor: Color(0xFF512DA8),
                  handleColor: Color(0xFF512DA8),
                ),
              ),
            )
          else
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Icon(Icons.error, color: Colors.white, size: 60),
              ),
            ),
          const SizedBox(height: 20),
        ] else ...[
          const Text(
            "Apresentação",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Vídeo de apresentação em atualização.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),
        ],

        if (widget.startup.faq.isNotEmpty) ...[
          const Text(
            "Perguntas Frequentes",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF512DA8),
            ),
          ),
          const SizedBox(height: 10),
          ...widget.startup.faq.map((pergunta) {
            return Card(
              elevation: 0,
              color: Colors.grey.shade50,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ExpansionTile(
                title: Text(
                  pergunta['text'] ?? pergunta['question'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
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
        ],
      ],
    );
  }
}
