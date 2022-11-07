import 'dart:convert';
import 'package:aniflix/models/episode.dart';
import 'package:aniflix/providers/episodeprovider.dart';
import 'package:aniflix/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class EpisodeTile extends StatefulWidget {
  final Episode episode;
  final int animeid;
  final String image;
  const EpisodeTile({
    Key? key,
    required this.episode,
    required this.animeid,
    required this.image,
  }) : super(key: key);

  @override
  State<EpisodeTile> createState() => _EpisodeTileState();
}

class _EpisodeTileState extends State<EpisodeTile> {
  String details = '';

  @override
  Widget build(BuildContext context) {
    final episodeProvider = Provider.of<EpisodeProvider>(
      context,
      listen: false,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          ListTile(
            onTap: () => Navigator.pushNamed(
              context,
              '/videoscreen',
              arguments: json.encode(
                {'title': widget.episode.title, 'videoUrl': ''},
              ),
            ),
            leading: Image.network(
              widget.image,
              fit: BoxFit.cover,
              height: 70,
              width: 100,
            ),
            title: Text("${widget.episode.malId}. ${widget.episode.title!}"),
            subtitle: Text('23m  ${widget.episode.score}'),
            trailing: const Icon(Icons.download_sharp),
          ),
          FutureBuilder(
              future: episodeProvider.getEpisodesDetail(
                widget.animeid,
                widget.episode.malId!,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    !snapshot.hasError) {
                  details = snapshot.data.toString();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Text(
                    details,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              })
        ],
      ),
    );
  }
}
