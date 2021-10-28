import 'package:aniflix/common/progress_indicator.dart';
import 'package:aniflix/config/enum.dart';
import 'package:aniflix/config/styles.dart';
import 'package:aniflix/providers/wishlistprovider.dart';
import 'package:aniflix/widgets/detailbottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishListProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: const Text("Wishlist", style: TextStyles.primaryTitle),
      ),
      Expanded(
          child: (wishlistProvider.dataStatus == DataStatus.loading)
              ? const CustomProgressIndicator()
              : (wishlistProvider.wishlist.isEmpty)
                  ? const Center(child: Text("Nothing to show!!"))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: wishlistProvider.wishlist.length,
                      itemBuilder: (context, index) {
                        final anime = wishlistProvider.wishlist[index];
                        return GestureDetector(
                          onTap: () => showBottomSheet(
                              context: context,
                              builder: (context) => SavedBottomSheet(
                                  id: anime.id,
                                  title: anime.title,
                                  image: anime.imageUrl)),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            width: size.width * 0.32,
                            height: size.height * 0.22,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(wishlistProvider
                                        .wishlist[index].imageUrl),
                                    fit: BoxFit.cover)),
                          ),
                        );
                      }))
    ]));
  }
}
