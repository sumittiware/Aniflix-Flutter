import 'package:aniflix/models/anime.dart';
import 'package:aniflix/widgets/detail_bottom_sheet.dart';
import 'package:flutter/material.dart';

class AnimeWidget extends StatelessWidget {
  final Anime anime;

  const AnimeWidget({
    Key? key,
    required this.anime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => showBottomSheet(
        context: context,
        builder: (context) {
          return DetailBottomSheet(
            anime: anime,
          );
        },
      ),
      child: Container(
        margin: const EdgeInsets.all(4),
        width: size.width * 0.32,
        height: size.height * 0.22,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: NetworkImage(
              anime.images!.imageUrl!,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
