import 'package:aniflix/common/message.dart';
import 'package:aniflix/common/progress_indicator.dart';
import 'package:aniflix/config.dart';
import 'package:aniflix/config/enum.dart';
import 'package:aniflix/config/styles.dart';
import 'package:aniflix/models/anime.dart';
import 'package:aniflix/providers/animeprovider.dart';
import 'package:aniflix/providers/bannerprovider.dart';
import 'package:aniflix/providers/episodeprovider.dart';
import 'package:aniflix/providers/searchprovider.dart';
import 'package:aniflix/providers/songprovider.dart';
import 'package:aniflix/providers/wishlistprovider.dart';
import 'package:aniflix/widgets/episodeslist.dart';
import 'package:aniflix/widgets/songList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:aniflix/common/constants.dart';

class AnimeDetail extends StatefulWidget {
  final int id;
  final ResultType type;

  const AnimeDetail({Key? key, required this.id, required this.type})
      : super(key: key);

  @override
  _AnimeDetailState createState() => _AnimeDetailState();
}

class _AnimeDetailState extends State<AnimeDetail> with RouteAware {
  // final RouteObserver routerObserver = RouteObserver();
  late YoutubePlayerController controller;
  late AnimeProvider animeProvider;
  late SearchProvider searchProvider;
  late BannerProvider bannerProvider;
  late EpisodeProvider episodeProvider;
  late WishListProvider wishlistProvider;
  late SongProvider songProvider;
  late Anime anime = Anime(genres: []);
  bool loading = false;
  bool showEpisodes = true;

  getResult() async {
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
      case ResultType.saved:
        setState(() {
          loading = true;
        });
        anime = await wishlistProvider.fetchById(widget.id);
        setState(() {
          loading = false;
        });
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
    wishlistProvider = Provider.of<WishListProvider>(context, listen: false);
    songProvider = Provider.of<SongProvider>(context, listen: false);
    getResult();
    controller = YoutubePlayerController(
      initialVideoId: anime.trailer.split("/").last,
      flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          isLive: false,
          controlsVisibleAtStart: false,
          loop: false,
          forceHD: false),
    );
    controller.addListener(() {
      if (controller.value.hasError) {
        setState(() {});
      }
    });
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
    super.didChangeDependencies();
  }

  @override
  void didPopNext() {
    resetStatusbar();
    controller.play();
    super.didPopNext();
  }

  @override
  void didPushNext() {
    hideStatusBar();
    controller.pause();
    songProvider.pause();
    super.didPushNext();
  }

  @override
  void dispose() {
    episodeProvider.resetValues();
    songProvider.resetValues();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: (loading)
          ? const CustomProgressIndicator()
          : SizedBox(
              height: size.height,
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: padding.top),
                    Stack(
                      children: [
                        (controller.value.hasError || anime.trailer == "")
                            ? Image.network(
                                (anime.banner != "")
                                    ? anime.banner
                                    : anime.image,
                                fit: BoxFit.cover,
                                width: size.width,
                                height: size.height * 0.3)
                            : YoutubePlayer(
                                controller: controller,
                                showVideoProgressIndicator: false,
                                liveUIColor: Colors.red,
                                // thumbnail: ,
                              ),
                        Positioned.fill(
                            child: GestureDetector(
                          onTap: () => setState(() {
                            (controller.value.isPlaying)
                                ? controller.pause()
                                : controller.play();
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      anime.title,
                                      style: TextStyles.primaryTitle,
                                    ),
                                    Text(
                                      anime.year.toString(),
                                      style: TextStyles.secondaryTitle,
                                    ),
                                    Text(
                                      "Score : ${anime.score}",
                                    ),
                                  ],
                                ),
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
                                  onPressed: () {
                                    wishlistProvider
                                        .addToWishlist(
                                            anime.id, anime.title, anime.image)
                                        .then((value) => showCustomSnackBar(
                                            context, "Added to wishlist!!"))
                                        .catchError((err) {
                                      showCustomSnackBar(
                                          context, err.toString());
                                    });
                                  },
                                  icon: const Icon(Icons.add)),
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
                                  onPressed: () {},
                                  icon: const Icon(Icons.share)),
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
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        "Total episodes : ${anime.episode} | Duration : ${anime.duration} min",
                        style: TextStyles.secondaryTitle2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () => setState(() {
                              showEpisodes = true;
                            }),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              alignment: Alignment.center,
                              child: Text(
                                "Episodes",
                                style: TextStyles.secondaryTitle2,
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 3,
                                          color: (showEpisodes)
                                              ? Colors.red
                                              : Colors.black))),
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () => setState(() {
                              showEpisodes = false;
                            }),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              alignment: Alignment.center,
                              child: Text(
                                "Songs",
                                style: TextStyles.secondaryTitle2,
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 3,
                                          color: (showEpisodes)
                                              ? Colors.black
                                              : Colors.red))),
                            ),
                          ))
                        ],
                      ),
                    ),
                    (showEpisodes)
                        ? EpisodesList(id: anime.id, title: anime.title)
                        : SongList(animeId: anime.id),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
