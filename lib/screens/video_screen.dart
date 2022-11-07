import 'package:aniflix/common/progress_indicator.dart';
import 'package:aniflix/config.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String title;
  final String videoUrl;
  const VideoScreen({Key? key, required this.title, required this.videoUrl})
      : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  String testUrl = "https:/goload.io/streaming.php?id=OTczNTE";

  late VideoPlayerController _controller;
  bool loading = true;
  String error = "";
  bool hideTools = false;
  bool fullScreen = false;
  @override
  void initState() {
    super.initState();
    hideStatusBar();
    _controller = VideoPlayerController.network(testUrl)
      ..addListener(() {
        // if(_controller.)
        if (_controller.value.isBuffering) {
          setState(() {
            loading = true;
          });
        }
        if (_controller.value.isPlaying) {
          setState(() {
            loading = false;
          });
        }
        if (_controller.value.position == _controller.value.duration) {
          Navigator.pop(context);
        }
      })
      ..initialize().then((_) {
        setState(() {
          loading = false;
        });
        _controller.play();
      }).catchError((err) {
        print("ERROR : ${err.toString()}");
        // print(err.toString());
      });
    setLandscapeOrientation();
  }

  @override
  void dispose() {
    _controller.dispose();
    resetStatusbar();
    setDefaultOrientation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Center(
            child: AspectRatio(
                aspectRatio: (fullScreen)
                    ? size.height / size.width
                    : _controller.value.aspectRatio,
                child: (_controller.value.isBuffering || loading)
                    ? const CustomProgressIndicator()
                    : VideoPlayer(_controller))),
        if (error != "")
          const Center(
            child: Text("Error"),
          ),
        Positioned.fill(
            child: GestureDetector(
          onTap: () {
            setState(() {
              hideTools = !hideTools;
            });
          },
          child: Container(
            color: (hideTools) ? Colors.transparent : Colors.black38,
          ),
        )),
        if (!loading && !hideTools)
          Center(
              child: Row(
            children: [
              SizedBox(
                  width: size.width - 40,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.replay_10_rounded,
                            size: 45,
                          ),
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        (_controller.value.isPlaying)
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    _controller.pause();
                                  });
                                },
                                icon: const Icon(
                                  Icons.pause,
                                  size: 45,
                                ))
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    _controller.play();
                                  });
                                },
                                icon: const Icon(
                                  Icons.play_arrow,
                                  size: 45,
                                )),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.forward_10_rounded,
                            size: 45,
                          ),
                          color: Colors.white,
                        ),
                      ])),
            ],
          )),
        if (!hideTools)
          Positioned(
            left: 0,
            right: 0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                    "${_controller.value.position.inMinutes.remainder(60)}:${(_controller.value.position.inSeconds.remainder(60))}"),
                SizedBox(
                  width: size.width * 0.9,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.red,
                        inactiveTrackColor: Colors.white,
                        trackHeight: 2,
                        thumbColor: Colors.red),
                    child: Slider(
                      value: (!loading)
                          ? (_controller.value.position.inSeconds /
                              _controller.value.duration.inSeconds)
                          : 0,
                      onChanged: (val) {
                        _controller.seekTo(Duration(
                            seconds:
                                (val * _controller.value.duration.inSeconds)
                                    .floor()));
                      },
                    ),
                  ),
                ),
                Text(
                    "${_controller.value.duration.inMinutes.remainder(60)}:${(_controller.value.duration.inSeconds.remainder(60))}"),
              ],
            ),
            bottom: 20,
          ),
        if (!hideTools)
          Positioned(
            child: SizedBox(
              height: kToolbarHeight,
              child: AppBar(
                  backgroundColor: Colors.black12,
                  elevation: 0,
                  title: Text(widget.title),
                  actions: [
                    IconButton(
                        icon: Icon((fullScreen
                            ? Icons.fullscreen_exit
                            : Icons.fullscreen)),
                        onPressed: () => setState(() {
                              fullScreen = !fullScreen;
                            }))
                  ]),
            ),
          )
      ]),
    );
  }
}
