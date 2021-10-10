import 'package:aniflix/models/anime.dart';
import 'package:aniflix/views/home/detail.dart';
import 'package:flutter/material.dart';

class AllAnimeScreen extends StatefulWidget {
  final String genra;

  const AllAnimeScreen({Key? key, required this.genra}) : super(key: key);

  @override
  _AllAnimeScreenState createState() => _AllAnimeScreenState();
}

class _AllAnimeScreenState extends State<AllAnimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.genra,
            style: const TextStyle(color: Colors.red, fontSize: 20),
          ),
        ),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: .7,
            ),
            itemCount: anime.length,
            itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: NetworkImage(anime[index].image),
                          fit: BoxFit.cover)),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(Icons.info),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AnimeDetail(index: index)));
                      },
                    ),
                  ),
                )));
  }
}
