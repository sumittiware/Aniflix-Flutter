import 'package:aniflix/providers/animeprovider.dart';
import 'package:aniflix/widgets/anime_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecommendedAnimes extends StatefulWidget {
  final int animeId;

  const RecommendedAnimes({
    Key? key,
    required this.animeId,
  }) : super(key: key);

  @override
  State<RecommendedAnimes> createState() => _RecommendedAnimesState();
}

class _RecommendedAnimesState extends State<RecommendedAnimes> {
  @override
  void initState() {
    final animeProvider = Provider.of<AnimeProvider>(context, listen: false);
    animeProvider.fetchRecommended(
      widget.animeId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimeProvider>(
      builder: (_, ap, __) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.6,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return AnimeWidget(
              anime: ap.recommended[index],
            );
          },
          itemCount: ap.recommended.length,
        );
      },
    );
  }
}
