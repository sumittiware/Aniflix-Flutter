import 'package:aniflix/config/enum.dart';
import 'package:aniflix/models/anime.dart';
import 'package:aniflix/widgets/detailbottomsheet.dart';
import 'package:flutter/material.dart';

class AnimeWidget extends StatelessWidget {
  final Anime anime;
  final ResultType resulType;
  const AnimeWidget({Key? key, required this.anime, required this.resulType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => showBottomSheet(
          context: context,
          builder: (context) =>
              DetailBottomSheet(anime: anime, resulttype: resulType)),
      child: Container(
        margin: const EdgeInsets.all(8),
        width: size.width * 0.32,
        height: size.height * 0.22,
        decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                image: NetworkImage(anime.image), fit: BoxFit.cover)),
      ),
    );
  }
}
