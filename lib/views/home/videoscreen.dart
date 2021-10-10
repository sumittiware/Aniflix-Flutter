import 'package:aniflix/config.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

const videoURl =
    "https://api.aniapi.com/v1/proxy/https%3a%2f%2fcdn2.dreamsub.cc%2ffl%2fone-piece%2f048%2fSUB_ITA%2f480p%3ftoken%3dTL2tEyOvfXXFkMTWRLqxbptwZYT59HQo8g0vXF4XCdreamsubI%24OwO%24/dreamsub/?host=cdn.dreamsub.cc&referrer=https%3a%2f%2fdreamsub.cc%2fanime%2fone-piece%2f48";

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(videoURl)
      ..addListener(() {
        setState(() {});
      })
      ..initialize().then((_) {
        setState(() {
          loading = false;
        });
        _controller.play();
      }).catchError((err) {
        print(err.toString());
      });

    setLandscapeOrientation();
  }

  @override
  void dispose() {
    _controller.dispose();
    setDefaultOrientation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        VideoPlayer(_controller),
        if (loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
        if (!loading)
          Center(
              child: (_controller.value.isPlaying)
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _controller.pause();
                        });
                      },
                      icon: const Icon(
                        Icons.pause,
                        size: 70,
                      ))
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          _controller.play();
                        });
                      },
                      icon: const Icon(
                        Icons.play_arrow,
                        size: 70,
                      ))),
        Positioned(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(_controller.value.position.inSeconds.toString()),
              SizedBox(
                width: size.width * 0.9,
                child: Slider(
                  value: _controller.value.position.inSeconds /
                      _controller.value.duration.inSeconds,
                  onChanged: (val) {},
                  activeColor: Colors.red,
                  inactiveColor: Colors.white,
                ),
              ),
              Text(_controller.value.duration.inSeconds.toString()),
            ],
          ),
          bottom: 30,
        ),
        Positioned(
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back)))
      ]),
    );
  }
}
