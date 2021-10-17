import 'package:aniflix/config/enum.dart';
import 'package:aniflix/config/styles.dart';
import 'package:aniflix/models/anime.dart';
import 'package:aniflix/providers/animeprovider.dart';
import 'package:aniflix/providers/bannerprovider.dart';
import 'package:aniflix/providers/episodeprovider.dart';
import 'package:aniflix/providers/searchprovider.dart';
import 'package:aniflix/views/home/anime/widget/episodeslist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AnimeDetail extends StatefulWidget {
  final int id;
  final ResultType type;

  const AnimeDetail({Key? key, required this.id, required this.type})
      : super(key: key);

  @override
  _AnimeDetailState createState() => _AnimeDetailState();
}

class _AnimeDetailState extends State<AnimeDetail> {
  late YoutubePlayerController _controller;
  late AnimeProvider animeProvider;
  late SearchProvider searchProvider;
  late BannerProvider bannerProvider;
  late EpisodeProvider episodeProvider;
  late Anime anime;

  getResult() {
    switch (widget.type) {
      case ResultType.all:
        anime = animeProvider.getAnimeById(widget.id);
        break;
      case ResultType.gnera:
        anime = searchProvider.getGneraById(widget.id);
        break;
      case ResultType.search:
        anime = searchProvider.getSearchById(widget.id);
        break;
      case ResultType.banner:
        anime = bannerProvider.getBanner();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    animeProvider = Provider.of<AnimeProvider>(context, listen: false);
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    bannerProvider = Provider.of<BannerProvider>(context, listen: false);
    episodeProvider = Provider.of<EpisodeProvider>(context, listen: false);
    getResult();
    _controller = YoutubePlayerController(
      initialVideoId: anime.trailer.split("/").last,
      flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          isLive: false,
          controlsVisibleAtStart: false,
          loop: false,
          forceHD: false),
    );
    // _controller.play();
  }

  @override
  void dispose() {
    episodeProvider.resetValues();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: padding.top),
              Stack(
                children: [
                  YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: false,
                    liveUIColor: Colors.red,
                  ),
                  Positioned.fill(
                      child: GestureDetector(
                    onTap: () => setState(() {
                      (_controller.value.isPlaying)
                          ? _controller.pause()
                          : _controller.play();
                    }),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                    ),
                  )),
                  Positioned(
                      child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          )))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        width: size.width * 0.3,
                        height: size.height * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: NetworkImage(anime.image),
                                fit: BoxFit.cover)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: size.width * 0.5),
                              child: Text(
                                anime.title,
                                style: TextStyles.primaryTitle,
                              ),
                            ),
                            Text(
                              anime.year.toString(),
                              style: TextStyles.secondaryTitle,
                            ),
                            Text(
                              "Score : ${anime.score}",
                            ),
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.white,
                                    primary: Colors.red),
                                onPressed: () {},
                                icon: const Icon(Icons.play_arrow),
                                label: const Text("Watch Now"))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.add)),
                        const Text("Add to List")
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_border)),
                        const Text("Add to Favorite")
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.share)),
                        const Text("Share")
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Html(data: anime.description),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
                child: Text("Total episodes : ${anime.episode}",
                    style: TextStyles.secondaryTitle),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16, top: 4, bottom: 8),
                child: Text("Duration : ${anime.duration} min",
                    style: TextStyles.secondaryTitle),
              ),
              EpisodesList(id: anime.id, title: anime.title),
            ],
          ),
        ),
      ),
    );
  }
}
