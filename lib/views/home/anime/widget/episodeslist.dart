import 'dart:math';

import 'package:aniflix/common/message.dart';
import 'package:aniflix/common/progress_indicator.dart';
import 'package:aniflix/providers/episodeprovider.dart';
import 'package:aniflix/views/home/anime/widget/allepisodes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../videoscreen.dart';

class EpisodesList extends StatefulWidget {
  final int id;
  final String title;

  const EpisodesList({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  _EpisodesListState createState() => _EpisodesListState();
}

class _EpisodesListState extends State<EpisodesList> {
  late EpisodeProvider episodesProvider;
  bool loading = true;
  Widget loader = const CustomProgressIndicator();

  @override
  void initState() {
    super.initState();
    episodesProvider = Provider.of<EpisodeProvider>(context, listen: false);
    episodesProvider
        .fetchEpisodes(widget.id)
        .then((_) => setState(() {
              loading = false;
            }))
        .catchError((err) {
      setState(() {
        loader = Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(err.toString()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? loader
        : Column(
            children: List.generate(
                min(episodesProvider.episodes.length, 11),
                (index) => (index == 10)
                    ? TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AllEpisodesPage(
                                  id: widget.id, title: widget.title)));
                        },
                        child: const Text(
                          "Show More",
                          style: TextStyle(color: Colors.red),
                        ))
                    : ListTile(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VideoScreen(
                                      title: episodesProvider
                                          .episodes[index].title,
                                      videoUrl: episodesProvider
                                          .episodes[index].videoUrl,
                                    ))),
                        leading: const Icon(Icons.play_arrow),
                        title: Text(
                            "Episode ${episodesProvider.episodes[index].number}"),
                        subtitle: Text(episodesProvider.episodes[index].title),
                      )),
          );
  }
}
