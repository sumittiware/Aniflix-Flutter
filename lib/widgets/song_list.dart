import 'package:aniflix/config/shimmer.dart';
import 'package:aniflix/providers/songprovider.dart';
import 'package:aniflix/widgets/song_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongList extends StatefulWidget {
  final int animeId;
  const SongList({Key? key, required this.animeId}) : super(key: key);

  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  late SongProvider songProvider;
  bool loading = false;
  
  List<Widget> loader = List.generate(
      5,
      (index) => const LoaderWidget.rectangular(
            height: 50,
            borderRadius: Radius.circular(0),
          ));

  @override
  void initState() {
    super.initState();
    songProvider = Provider.of<SongProvider>(context, listen: false);
    if (songProvider.animeSongs.isEmpty) {
      setState(() => loading = true);
      songProvider
          .fetchSongByAnime(widget.animeId)
          .then((_) => setState(() => loading = false))
          .catchError((err) {
        setState(() {
          loader = [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(err.toString()),
            )
          ];
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: (loading)
            ? loader
            : List.generate(songProvider.animeSongs.length,
                (index) => SongTile(index: index)));
  }
}
