import 'dart:convert';
import 'package:aniflix/models/episode.dart';
import 'package:flutter/material.dart';

class EpisodeTile extends StatelessWidget {
  final Episode episode;
  const EpisodeTile({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, '/videoscreen',
          arguments: json
              .encode({'title': episode.title, 'videoUrl': episode.videoUrl})),
      leading: const Icon(
        Icons.play_arrow,
        size: 35,
        color: Colors.red,
      ),
      title: Text("Episode ${episode.number}"),
      subtitle: Text(
        episode.title,
        maxLines: 1,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
