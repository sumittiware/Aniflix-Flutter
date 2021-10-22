import 'package:aniflix/common/message.dart';
import 'package:aniflix/config/enum.dart';
import 'package:aniflix/config/styles.dart';
import 'package:aniflix/models/anime.dart';
import 'package:aniflix/providers/wishlistprovider.dart';
import 'package:aniflix/views/home/anime/detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailBottomSheet extends StatelessWidget {
  final Anime anime;
  final ResultType resulttype;
  const DetailBottomSheet(
      {Key? key, required this.anime, required this.resulttype})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final wishlistProvider = Provider.of<WishListProvider>(context);
    return BottomSheet(
      backgroundColor: Colors.grey.shade900,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                    )),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    width: 150,
                    height: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(anime.image),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: size.width * 0.5),
                          child: Text(
                            anime.title,
                            style: TextStyles.primaryTitle,
                          ),
                        ),
                        Text(
                          anime.year.toString(),
                          style: TextStyles.secondaryTitle,
                        ),
                        Text(
                          "Score : ${anime.score}",
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(8),
                              onPrimary: Colors.red,
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.red)),
                              primary: Colors.transparent),
                          onPressed: () {
                            (wishlistProvider.isPresent(anime.id)
                                    ? wishlistProvider
                                        .removeFromList(anime.id)
                                        .then((value) => showCustomSnackBar(
                                            context, "Removed!!"))
                                    : wishlistProvider
                                        .addToWishlist(
                                            anime.id, anime.title, anime.image)
                                        .then((value) => showCustomSnackBar(
                                            context, "Added to Wishlist!!")))
                                .catchError((err) => showCustomSnackBar(
                                    context, err.toString()));
                          },
                          icon: Icon((wishlistProvider.isPresent(anime.id))
                              ? Icons.remove_circle_outline
                              : Icons.add),
                          label: Text((wishlistProvider.isPresent(anime.id))
                              ? "Remove"
                              : "Add to Wishlist")),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(8),
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.red)),
                              onPrimary: Colors.white,
                              primary: Colors.red),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AnimeDetail(
                                    id: anime.id, type: resulttype)));
                          },
                          icon: const Icon(Icons.play_arrow),
                          label: const Text("Watch Now")),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
      onClosing: () {},
    );
  }
}

class SavedBottomSheet extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  const SavedBottomSheet(
      {Key? key, required this.id, required this.title, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final wishlistProvider = Provider.of<WishListProvider>(context);
    return BottomSheet(
      backgroundColor: Colors.grey.shade900,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                    )),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    width: 150,
                    height: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: size.width * 0.5),
                      child: Text(
                        title,
                        style: TextStyles.primaryTitle,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(8),
                          onPrimary: Colors.red,
                          shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.red)),
                          primary: Colors.transparent),
                      onPressed: () {
                        wishlistProvider.removeFromList(id).then((value) {
                          showCustomSnackBar(context, "Removed!!");
                          Navigator.pop(context);
                        }).catchError((err) =>
                            showCustomSnackBar(context, err.toString()));
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                      label: const Text("Remove"),
                    ),
                  )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(8),
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.red)),
                              onPrimary: Colors.white,
                              primary: Colors.red),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AnimeDetail(
                                    id: id, type: ResultType.saved)));
                          },
                          icon: const Icon(Icons.play_arrow),
                          label: const Text("Watch Now")),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
      onClosing: () {},
    );
  }
}
