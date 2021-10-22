import 'package:aniflix/models/episode.dart';
import 'package:aniflix/views/home/anime/videoscreen.dart';
import 'package:flutter/material.dart';

class EpisodeTile extends StatelessWidget {
  final Episode episode;
  const EpisodeTile({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        
        tileColor: Colors.grey[900],
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VideoScreen(
                  title: episode.title,
                  videoUrl: episode.videoUrl,
                ))),
        leading: const Icon(
          Icons.play_arrow,
          size: 40,
        ),
        title: Text("Episode ${episode.number}"),
        subtitle: Text(
          episode.title,
          maxLines: 1,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}
