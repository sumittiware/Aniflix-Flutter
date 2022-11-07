import 'package:aniflix/config/shimmer.dart';
import 'package:aniflix/providers/animeprovider.dart';
import 'package:aniflix/widgets/anime_by_gnera.dart';
import 'package:aniflix/widgets/button.dart';
import 'package:aniflix/widgets/detail_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: ListView(
        children: [
          _buildBanner(),
          const AnimesByGenra(
            gnera: "Action",
            id: 1,
          ),
          const AnimesByGenra(
            gnera: "Adventure",
            id: 2,
          ),
          const AnimesByGenra(
            gnera: "Romance",
            id: 22,
          ),
          const AnimesByGenra(
            gnera: "Sci-Fi",
            id: 22,
          ),
          const AnimesByGenra(
            gnera: "Comedy",
            id: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    final size = MediaQuery.of(context).size;
    return Consumer<AnimeProvider>(
      builder: (_, animeProvider, __) {
        return animeProvider.bannerAnime == null
            ? const BannerLoader()
            : Stack(
                children: [
                  Container(
                      height: size.height * 0.5,
                      width: size.width,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            animeProvider.bannerAnime!.images!.largeImageUrl!,
                          ),
                          fit: BoxFit.fitWidth,
                        ),
                      )),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      height: 80,
                      width: size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black45,
                              Colors.black87,
                              Colors.black87,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [
                              0.0,
                              0.15,
                              0.3,
                              0.45,
                            ]),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomButtons().iconButton(
                            icon: Icons.add,
                            onTap: () {},
                            label: "My List",
                          ),
                          CustomButtons().textButton(
                            label: 'Play',
                            onTap: () {},
                            icon: Icons.play_arrow,
                          ),
                          CustomButtons().iconButton(
                            icon: Icons.info_outline,
                            onTap: () {
                              showBottomSheet(
                                context: context,
                                builder: (context) {
                                  return DetailBottomSheet(
                                    anime: animeProvider.bannerAnime!,
                                  );
                                },
                              );
                            },
                            label: "Info",
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
