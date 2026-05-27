import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

class YoutubeWebEmbed extends StatefulWidget {
  final String videoId;

  const YoutubeWebEmbed({super.key, required this.videoId});

  @override
  State<YoutubeWebEmbed> createState() => _YoutubeWebEmbedState();
}

class _YoutubeWebEmbedState extends State<YoutubeWebEmbed> {
  late final String _viewType;

  @override
  void initState() {
    super.initState();
    _viewType = 'youtube-web-embed-${widget.videoId}-${identityHashCode(this)}';

    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final iframe = web.HTMLIFrameElement()
        ..src = 'https://www.youtube.com/embed/${widget.videoId}'
        ..style.border = '0'
        ..style.width = '100%'
        ..style.height = '100%';

      iframe.setAttribute(
        'allow',
        'accelerometer; autoplay; clipboard-write; encrypted-media; '
            'gyroscope; picture-in-picture; web-share',
      );
      iframe.setAttribute('allowfullscreen', 'true');

      return iframe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
}
