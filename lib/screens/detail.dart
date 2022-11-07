import 'package:aniflix/config.dart';
import 'package:aniflix/config/enum.dart';
import 'package:aniflix/config/styles.dart';
import 'package:aniflix/models/anime.dart';
import 'package:aniflix/providers/animeprovider.dart';
import 'package:aniflix/providers/episodeprovider.dart';
import 'package:aniflix/providers/wishlistprovider.dart';
import 'package:aniflix/widgets/anime_widget.dart';
import 'package:aniflix/widgets/episode_tile.dart';
import 'package:aniflix/widgets/episodes_list.dart';
import 'package:aniflix/widgets/recommendations_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:aniflix/common/constants.dart';

import '../widgets/button.dart';

class AnimeDetail extends StatefulWidget {
  final int id;

  const AnimeDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _AnimeDetailState createState() => _AnimeDetailState();
}

class _AnimeDetailState extends State<AnimeDetail> with RouteAware {
  // final RouteObserver routerObserver = RouteObserver();
  late YoutubePlayerController controller;
  late AnimeProvider animeProvider;

  late EpisodeProvider episodeProvider;
  late WishListProvider wishlistProvider;
  late Anime anime = Anime(genres: []);
  bool loading = false;
  bool _showEpisodes = true;
  bool _fulldesc = false;
  bool _trailerAvaliable = true;

  getResult() async {
    setState(() {
      loading = true;
    });
    anime = await animeProvider.getAnimeById(widget.id);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    print(widget.id);
    animeProvider = Provider.of<AnimeProvider>(context, listen: false);
    episodeProvider = Provider.of<EpisodeProvider>(context, listen: false);
    wishlistProvider = Provider.of<WishListProvider>(context, listen: false);
    getResult();
    episodeProvider.fetchEpisodes(widget.id);
    animeProvider.fetchRecommended(widget.id);

    if (anime.trailer != null && anime.trailer!.youtubeId != null) {
      controller = YoutubePlayerController(
        initialVideoId: anime.trailer!.youtubeId!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          isLive: false,
          controlsVisibleAtStart: false,
          loop: false,
          forceHD: false,
        ),
      );
      controller.addListener(
        () {
          if (controller.value.hasError) {
            setState(() {});
          }
        },
      );
    } else {
      setState(() {
        _trailerAvaliable = false;
      });
    }
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
    super.didPushNext();
  }

  @override
  void dispose() {
    episodeProvider.resetValues();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: (loading)
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : ListView(
              children: [
                _buildTrailerPlayer(),
                _buildTitle(),
                _buildInfo(),
                _buildButtons(),
                _buildDetails(),
                _buildActionBar(),
                _buildSection(),
              ],
            ),
    );
  }

  Widget _buildTrailerPlayer() {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        (!_trailerAvaliable)
            ? Image.network(
                anime.images!.largeImageUrl!,
                fit: BoxFit.cover,
                width: size.width,
                height: size.height * 0.3,
              )
            : YoutubePlayer(
                controller: controller,
                showVideoProgressIndicator: false,
                liveUIColor: Colors.red,
              ),
        Positioned.fill(
            child: GestureDetector(
          onTap: () => setState(
            () {
              (controller.value.isPlaying)
                  ? controller.pause()
                  : controller.play();
            },
          ),
        )),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        anime.title ?? '',
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 4,
      ),
      child: Row(
        children: [
          if (anime.year != null)
            Text(
              anime.year.toString(),
              style: TextStyles.secondaryTitle,
            ),
          if (anime.rating != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(anime.rating!.split(' ').first),
              ),
            ),
          if (anime.episodes != null)
            Text(
              '${anime.episodes} Episodes',
              style: TextStyles.secondaryTitle,
            )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        CustomButtons().textButton(
          label: 'Play',
          onTap: () {},
          icon: Icons.play_arrow,
        ),
        CustomButtons().textButton(
          label: 'Download',
          onTap: () {},
          icon: Icons.download_sharp,
          revert: true,
        ),
      ],
    );
  }

  Widget _buildDetails() {
    return StatefulBuilder(builder: (context, ss) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              anime.synopsis ?? '',
              maxLines: _fulldesc ? null : 3,
            ),
            GestureDetector(
              onTap: () {
                ss(() {
                  _fulldesc = !_fulldesc;
                });
              },
              child: Text(
                _fulldesc ? '...less' : '...more',
                style: const TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildActionBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButtons().iconButton(
            icon: Icons.add,
            onTap: () {},
            label: 'My List',
          ),
          CustomButtons().iconButton(
            icon: Icons.thumb_up_outlined,
            onTap: () {},
            label: 'Rate',
          ),
          CustomButtons().iconButton(
            icon: Icons.share,
            onTap: () {},
            label: 'Share',
          ),
          CustomButtons().iconButton(
            icon: Icons.download_sharp,
            onTap: () {},
            label: 'Download',
          ),
        ],
      ),
    );
  }

  Widget _buildSection() {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 8,
          ),
          width: size.width,
          height: 1,
          color: Colors.grey,
        ),
        Row(
          children: [
            _buildSectionButton(
              'EPISODES',
              _showEpisodes,
            ),
            _buildSectionButton(
              'MORE LIKE THIS',
              !_showEpisodes,
            )
          ],
        ),
        _showEpisodes
            ? EpisodesList(
                anime: anime,
              )
            : RecommendedAnimes(
                animeId: widget.id,
              )
      ],
    );
  }

  Widget _buildSectionButton(
    String title,
    bool value,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          _showEpisodes = !_showEpisodes;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            top: (value)
                ? BorderSide(color: Colors.red.shade800, width: 4)
                : BorderSide.none,
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
