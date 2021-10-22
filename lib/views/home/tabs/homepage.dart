import 'dart:math';

import 'package:aniflix/config/enum.dart';
import 'package:aniflix/config/shimmer.dart';
import 'package:aniflix/config/styles.dart';
import 'package:aniflix/providers/animeprovider.dart';
import 'package:aniflix/providers/bannerprovider.dart';
import 'package:aniflix/views/home/anime/detail.dart';
import 'package:aniflix/views/home/anime/widget/animewidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    final banner = Provider.of<BannerProvider>(context).getBanner();
    return Scaffold(
      body: Stack(
        children: [
          Image.network(banner.image, fit: BoxFit.fitWidth, width: size.width),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: size.height * 0.40,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(12),
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                banner.title,
                                style: TextStyles.secondaryTitle,
                              ),
                              Text(banner.genres
                                  .sublist(0, min(3, banner.genres.length))
                                  .join(", "))
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white, primary: Colors.red),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const AnimeDetail(
                                      id: 0, type: ResultType.banner)));
                            },
                            icon: const Icon(Icons.play_arrow),
                            label: const Text("Watch Now"))
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  color: Colors.black,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        child: const Text("Discover",
                            style: TextStyles.primaryTitle),
                      ),
                      const AnimesByGenra(
                        gnera: "Action",
                      ),
                      const AnimesByGenra(
                        gnera: "Adventure",
                      ),
                      const AnimesByGenra(
                        gnera: "Romance",
                      ),
                      const AnimesByGenra(
                        gnera: "Sci-Fi",
                      ),
                      const AnimesByGenra(
                        gnera: "Comedy",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class AnimesByGenra extends StatefulWidget {
  final String gnera;
  const AnimesByGenra({Key? key, required this.gnera}) : super(key: key);

  @override
  _AnimesByGenraState createState() => _AnimesByGenraState();
}

class _AnimesByGenraState extends State<AnimesByGenra>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final animesProvider = Provider.of<AnimeProvider>(context);
    final gnerasAnime = animesProvider.getAnimeByGnera(widget.gnera);
    super.build(context);
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              widget.gnera,
              style: TextStyles.secondaryTitle,
            ),
          ),
          SizedBox(
            height: size.height * 0.24,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: (animesProvider.datastatus == DataStatus.loading)
                    ? 5
                    : gnerasAnime.length,
                itemBuilder: (context, index) {
                  return (animesProvider.datastatus == DataStatus.loading)
                      ? LoaderWidget.rectangular(
                          height: size.height * 0.22, width: size.width * 0.32)
                      : AnimeWidget(
                          anime: gnerasAnime[index], resulType: ResultType.all);
                }),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
