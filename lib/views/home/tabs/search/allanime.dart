import 'package:aniflix/common/message.dart';
import 'package:aniflix/common/progress_indicator.dart';
import 'package:aniflix/config/enum.dart';
import 'package:aniflix/config/shimmer.dart';
import 'package:aniflix/config/styles.dart';
import 'package:aniflix/providers/searchprovider.dart';
import 'package:aniflix/views/home/anime/detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllAnimeScreen extends StatefulWidget {
  final String genra;
  final String query;
  const AllAnimeScreen({Key? key, this.genra = "", this.query = ""})
      : super(key: key);
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
    ((widget.genra != "")
            ? searchProvider.fetchByGners(widget.genra)
            : searchProvider.fetchByTitle(widget.query))
        .then((_) => setState(() {
              loading = false;
            }))
        .catchError((err) => showCustomSnackBar(context, err.toString()));
    // pagination for the anime search according to gneres
    gridController.addListener(() {
      if (gridController.position.pixels ==
          gridController.position.maxScrollExtent) {
        searchProvider
            .fetchByGners(widget.genra)
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
            (widget.genra != "") ? widget.genra : widget.query,
            style: TextStyles.secondaryTitle,
          ),
        ),
        body: GridView.builder(
            controller: gridController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: .7,
            ),
            itemCount: (loading)
                ? 15
                : (widget.genra != "")
                    ? searchProvider.gneraAnime.length + 1
                    : searchProvider.searchResult.length,
            itemBuilder: (context, index) => (loading)
                ? LoaderWidget.rectangular(
                    height: size.height * 0.3,
                  )
                : (searchProvider.gneraAnime.length == index)
                    ? listEnd
                    : Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: NetworkImage((widget.genra != "")
                                    ? searchProvider.gneraAnime[index].image
                                    : searchProvider.searchResult[index].image),
                                fit: BoxFit.cover)),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: const Icon(Icons.info),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AnimeDetail(
                                        id: (widget.genra != "")
                                            ? searchProvider
                                                .gneraAnime[index].id
                                            : searchProvider
                                                .searchResult[index].id,
                                        type: (widget.genra != "")
                                            ? ResultType.gnera
                                            : ResultType.search,
                                      )));
                            },
                          ),
                        ),
                      )));
  }
}
