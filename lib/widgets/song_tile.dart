import 'package:aniflix/providers/songprovider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config.dart';

class SongTile extends StatefulWidget {
  final int index;
  const SongTile({Key? key, required this.index}) : super(key: key);

  @override
  _SongTileState createState() => _SongTileState();
}

class _SongTileState extends State<SongTile> {
  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);
    return ListTile(
      leading: IconButton(
        icon: Icon(
          (songProvider.playing && songProvider.currentPlaying == widget.index)
              ? Icons.pause
              : Icons.play_arrow,
          size: 35,
          color: Colors.red,
        ),
        onPressed: () {
          FirebaseAnalytics().logEvent(name: 'song_playing', parameters: null);
          (songProvider.playing && songProvider.currentPlaying == widget.index)
              ? songProvider.pause()
              : songProvider.playSong(widget.index, fromDetail: true);
        },
      ),
      title: Text(
        songProvider.animeSongs[widget.index].title,
        style: TextStyle(
            color: (songProvider.currentPlaying == widget.index)
                ? Colors.red
                : Colors.white),
      ),
      subtitle: Text(
          "${songProvider.songs[widget.index].artist} | ${songProvider.songs[widget.index].duration.inMinutes.toString()} min"),
      trailing: TextButton(
        child: const Text(
          "Open Spotify",
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () => launchURL(songProvider.animeSongs[widget.index].url),
      ),
    );
  }
}
