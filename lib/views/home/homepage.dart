import 'package:aniflix/models/anime.dart';
import 'package:aniflix/views/home/detail.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/plastic_memories.png",
          ),
          SizedBox(
              // width: size.width,
              // height: size.height -
              //     (padding.top +
              //         padding.bottom +
              //         kToolbarHeight +
              //         kBottomNavigationBarHeight),
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 400,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          "Plastic Memories",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.play_arrow),
                            label: const Text("Watch Now"))
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  color: Colors.black,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        child: const Text("discover",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22)),
                      ),
                      AnimesByGenra(),
                      AnimesByGenra(),
                      AnimesByGenra(),
                      AnimesByGenra(),
                    ],
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class AnimesByGenra extends StatefulWidget {
  const AnimesByGenra({Key? key}) : super(key: key);

  @override
  _AnimesByGenraState createState() => _AnimesByGenraState();
}

class _AnimesByGenraState extends State<AnimesByGenra> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text(
              "Action",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: size.height * 0.24,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: anime.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    width: size.width * 0.32,
                    height: size.height * 0.22,
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
                  );
                }),
          )
        ],
      ),
    );
  }
}
