import 'dart:convert';

import 'package:aniflix/config/enum.dart';
import 'package:aniflix/config/styles.dart';
import 'package:aniflix/models/anime.dart';
import 'package:aniflix/providers/wishlistprovider.dart';
import 'package:aniflix/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailBottomSheet extends StatelessWidget {
  final Anime anime;

  const DetailBottomSheet({
    Key? key,
    required this.anime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final wishlistProvider = Provider.of<WishListProvider>(context);
    return BottomSheet(
      backgroundColor: Colors.grey.shade900,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImage(size),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: size.width * 0.4),
                              child: Text(
                                anime.title!,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.primaryTitle,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              (anime.type == 'Movie')
                                  ? 'Movie'
                                  : '${anime.year ?? ''}  ${anime.episodes} Episodes',
                              style: TextStyles.secondaryTitle,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              anime.background ?? '',
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomButtons().iconButton(
                      icon: Icons.close,
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButtons().iconButton(
                    icon: Icons.play_circle,
                    onTap: () {},
                    label: 'Play',
                  ),
                  CustomButtons().iconButton(
                    icon: Icons.download_for_offline,
                    onTap: () {},
                    label: 'Download',
                  ),
                  CustomButtons().iconButton(
                    icon: Icons.add_circle_sharp,
                    onTap: () {},
                    label: 'My List',
                  ),
                  CustomButtons().iconButton(
                    icon: Icons.share_sharp,
                    onTap: () {},
                    label: 'Share',
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Divider(),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/detailscreen',
                    arguments: json.encode(
                      {
                        'id': anime.malId,
                        'type': 0,
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(Icons.info_outline),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Episodes & Info'),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_sharp)
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      onClosing: () {},
    );
  }

  Widget _buildImage(size) {
    return Container(
      margin: const EdgeInsets.all(8),
      constraints: BoxConstraints(
        maxWidth: size.width * 0.24,
        maxHeight: 120,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(
            anime.images!.imageUrl!,
          ),
          fit: BoxFit.cover,
        ),
      ),
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
                alignment: Alignment.centerRight,
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
                        // wishlistProvider.removeFromList(id).then((value) {
                        //   showCustomSnackBar(context, "Removed!!");
                        //   Navigator.pop(context);
                        // }).catchError((err) =>
                        //     showCustomSnackBar(context, err.toString()));
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
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/detailscreen',
                                arguments: json.encode({
                                  'id': id,
                                  'type': ResultType.saved.index,
                                }));
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
