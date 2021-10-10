import 'package:aniflix/models/anime.dart';
import 'package:aniflix/views/home/videoscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AnimeDetail extends StatefulWidget {
  final int index;

  const AnimeDetail({Key? key, required this.index}) : super(key: key);

  @override
  _AnimeDetailState createState() => _AnimeDetailState();
}

class _AnimeDetailState extends State<AnimeDetail> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: anime[widget.index].trailer.split("/").last,
      flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          isLive: false,
          loop: false,
          forceHD: false),
    );
    // _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                liveUIColor: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        width: size.width * 0.3,
                        height: size.height * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: NetworkImage(anime[widget.index].image),
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
                                  BoxConstraints(maxWidth: size.width * 0.4),
                              child: Text(
                                anime[widget.index].title,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "Score : ${anime[widget.index].score}",
                              style: const TextStyle(fontSize: 18),
                            ),
                            ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.play_arrow),
                                label: const Text("Watch Now"))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.add)),
                        const Text("Add to List")
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_border)),
                        const Text("Add to Favorite")
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.share)),
                        const Text("Share")
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Html(data: anime[widget.index].description),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                child: Text(
                  "Total episodes : ${anime[widget.index].episode}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ...List.generate(
                  10,
                  (index) => ListTile(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const VideoScreen())),
                        leading: const Icon(Icons.play_arrow),
                        title: Text("Episode ${index + 1}"),
                        subtitle: const Text("The night of curses"),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
