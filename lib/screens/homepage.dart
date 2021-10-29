import 'dart:convert';
import 'dart:math';

import 'package:aniflix/config/enum.dart';
import 'package:aniflix/config/styles.dart';
import 'package:aniflix/providers/bannerprovider.dart';
import 'package:aniflix/widgets/animebygnera.dart';
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
    final size = MediaQuery.of(context).size;
    final banner = Provider.of<BannerProvider>(context).getBanner();
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            (banner.banner != "") ? banner.banner : banner.image,
            fit: BoxFit.cover,
            width: size.width,
            height: size.height * 0.4,
          ),
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
                            onPressed: () => Navigator.pushNamed(
                                context, '/detailscreen',
                                arguments: json.encode({
                                  'id': 0,
                                  'type': ResultType.banner.index
                                })),
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
