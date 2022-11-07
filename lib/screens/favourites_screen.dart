import 'package:aniflix/common/progress_indicator.dart';
import 'package:aniflix/config/enum.dart';
import 'package:aniflix/config/styles.dart';
import 'package:aniflix/providers/wishlistprovider.dart';
import 'package:aniflix/widgets/detail_bottom_sheet.dart';
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
    final mediaquery = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 8,
              top: mediaquery.padding.top + kToolbarHeight,
            ),
            child: const Text("Wishlist", style: TextStyles.primaryTitle),
          ),
          Expanded(
            child: (wishlistProvider.dataStatus == DataStatus.loading)
                ? const CustomProgressIndicator()
                : (wishlistProvider.wishlist.isEmpty)
                    ? const Center(child: Text("Nothing to show!!"))
                    : GridView.builder(
                        padding: EdgeInsets.zero,
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
                                  image: anime.imageUrl),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              width: mediaquery.size.width * 0.32,
                              height: mediaquery.size.height * 0.22,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(wishlistProvider
                                        .wishlist[index].imageUrl),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          );
                        },
                      ),
          )
        ],
      ),
    );
  }
}
