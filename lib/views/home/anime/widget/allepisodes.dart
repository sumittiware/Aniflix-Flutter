import 'package:aniflix/common/message.dart';
import 'package:aniflix/common/progress_indicator.dart';
import 'package:aniflix/providers/episodeprovider.dart';
import 'package:aniflix/views/home/anime/widget/episode/episode_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllEpisodesPage extends StatefulWidget {
  final String title;
  final int id;
  const AllEpisodesPage({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  _AllEpisodesPageState createState() => _AllEpisodesPageState();
}

class _AllEpisodesPageState extends State<AllEpisodesPage> {
  late EpisodeProvider episodesProvider;
  final ScrollController listScrollController = ScrollController();
  Widget listEnd = const CustomProgressIndicator();
  @override
  void initState() {
    super.initState();
    episodesProvider = Provider.of<EpisodeProvider>(context, listen: false);
    listScrollController.addListener(() {
      if (listScrollController.position.pixels ==
          listScrollController.position.maxScrollExtent) {
        episodesProvider
            .fetchEpisodes(widget.id)
            .then((_) => setState(() {}))
            .catchError((err) {
          setState(() {
            listEnd = Container();
          });
          showCustomSnackBar(context, err.toString());
        });
      }
    });
  }

  @override
  void dispose() {
    listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          controller: listScrollController,
          itemCount: episodesProvider.episodes.length + 1,
          itemBuilder: (context, index) {
            return (episodesProvider.episodes.length == index)
                ? listEnd
                : EpisodeTile(episode: episodesProvider.episodes[index]);
          }),
    );
  }
}
