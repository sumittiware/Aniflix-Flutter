import 'package:aniflix/config/enum.dart';
import 'package:aniflix/config/shimmer.dart';
import 'package:aniflix/config/styles.dart';
import 'package:aniflix/providers/animeprovider.dart';
import 'package:aniflix/widgets/anime_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimesByGenra extends StatefulWidget {
  final String gnera;
  final int id;
  const AnimesByGenra({
    Key? key,
    required this.gnera,
    required this.id,
  }) : super(key: key);

  @override
  _AnimesByGenraState createState() => _AnimesByGenraState();
}

class _AnimesByGenraState extends State<AnimesByGenra>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    final animesProvider = Provider.of<AnimeProvider>(context);
    final gnerasAnime = animesProvider.getAnimeByGnera(widget.id);
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
              style: TextStyles.primaryTitle,
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
                          height: size.height * 0.22,
                          width: size.width * 0.32,
                        )
                      : AnimeWidget(
                          anime: gnerasAnime[index],
                        );
                }),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
