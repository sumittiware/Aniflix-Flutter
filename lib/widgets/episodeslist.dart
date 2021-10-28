import 'dart:convert';
import 'dart:math';
import 'package:aniflix/config/shimmer.dart';
import 'package:aniflix/providers/episodeprovider.dart';
import 'package:aniflix/screens/allepisodes.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'episode_tile.dart';

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
    episodesProvider = Provider.of<EpisodeProvider>(context, listen: false);
    if (episodesProvider.episodes.isEmpty) {
      setState(() => loading = true);
      episodesProvider
          .fetchEpisodes(widget.id)
          .then((_) => setState(() => loading = false))
          .catchError((err) {
        setState(() => loader = [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(err.toString()),
              )
            ]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: (loading)
          ? loader
          : List.generate(
              min(episodesProvider.episodes.length, 11),
              (index) => (index == 10)
                  ? Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red)),
                          onPressed: () => Navigator.pushNamed(
                              context, '/allepisodescreen',
                              arguments: json.encode(
                                  {'id': widget.id, 'title': widget.title})),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              "Show More",
                              style: TextStyle(color: Colors.red),
                            ),
                          )),
                    )
                  : EpisodeTile(episode: episodesProvider.episodes[index])),
    );
  }
}
