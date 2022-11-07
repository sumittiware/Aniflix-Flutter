import 'package:aniflix/common/message.dart';
import 'package:aniflix/common/progress_indicator.dart';
import 'package:aniflix/config/enum.dart';
import 'package:aniflix/config/shimmer.dart';
import 'package:aniflix/config/styles.dart';
import 'package:aniflix/models/genra.dart';
import 'package:aniflix/providers/searchprovider.dart';
import 'package:aniflix/widgets/anime_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllAnimeScreen extends StatefulWidget {
  final Genra? gnera;
  final String? query;

  const AllAnimeScreen({
    Key? key,
    this.gnera,
    this.query,
  }) : super(key: key);

  @override
  _AllAnimeScreenState createState() => _AllAnimeScreenState();
}

class _AllAnimeScreenState extends State<AllAnimeScreen> {
  late SearchProvider searchProvider;
  late ScrollController gridController = ScrollController();
  bool loading = true;
  bool init = true;
  Widget listEnd = const CustomProgressIndicator();

  @override
  void initState() {
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    ((widget.gnera != null)
            ? searchProvider.fetchByGners(widget.gnera!.malId!)
            : searchProvider.fetchByTitle(widget.query!))
        .then((_) => setState(() {
              loading = false;
            }))
        .catchError((err) => showCustomSnackBar(context, err.toString()));
    // pagination for the anime search according to gneres
    gridController.addListener(() {
      if (gridController.position.pixels ==
          gridController.position.maxScrollExtent) {
        searchProvider
            .fetchByGners(widget.gnera!.malId!)
            .then((_) => setState(() {
                  loading = false;
                }))
            .catchError((err) {
          setState(() {
            listEnd = Container();
          });
          showCustomSnackBar(context, err.toString());
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    searchProvider.resetValues();
    gridController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            (widget.gnera != null) ? widget.gnera!.name! : widget.query!,
            style: TextStyles.primaryTitle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
            controller: gridController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.6,
            ),
            itemCount: (loading)
                ? 15
                : (widget.gnera != null)
                    ? searchProvider.gneraAnime.length + 1
                    : searchProvider.searchResult.length,
            itemBuilder: (context, index) => (loading)
                ? LoaderWidget.rectangular(
                    height: size.height * 0.3,
                  )
                : (searchProvider.gneraAnime.length == index &&
                        searchProvider.gneraAnime.isNotEmpty)
                    ? listEnd
                    : AnimeWidget(
                        anime: (widget.gnera != null)
                            ? searchProvider.gneraAnime[index]
                            : searchProvider.searchResult[index],
                      ),
          ),
        ));
  }
}
