import 'package:aniflix/common/message.dart';
import 'package:aniflix/common/progress_indicator.dart';
import 'package:aniflix/config.dart';
import 'package:aniflix/config/enum.dart';
import 'package:aniflix/config/styles.dart';
import 'package:aniflix/providers/songprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({Key? key}) : super(key: key);

  @override
  _SongsPageState createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  late ScrollController listViewController = ScrollController();
  late SongProvider songProvider;
  Widget listEnd = const CustomProgressIndicator();

  @override
  void initState() {
    listViewController.addListener(() {
      if (listViewController.position.pixels ==
          listViewController.position.maxScrollExtent) {
        songProvider.fetchSongs().catchError((err) {
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
    listViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    songProvider = Provider.of<SongProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: const Text("Songs", style: TextStyles.primaryTitle),
          ),
          Expanded(
            child: (songProvider.dataStatus == DataStatus.loading)
                ? listEnd
                : ListView.builder(
                    controller: listViewController,
                    itemCount: songProvider.songs.length + 1,
                    itemBuilder: (context, index) {
                      return (index == songProvider.songs.length)
                          ? const CustomProgressIndicator()
                          : ListTile(
                              leading: IconButton(
                                icon: Icon(
                                  (songProvider.playing &&
                                          songProvider.currentPlaying == index)
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 35,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  (songProvider.playing &&
                                          songProvider.currentPlaying == index)
                                      ? songProvider.pause()
                                      : songProvider.playSong(index);
                                },
                              ),
                              title: Text(
                                songProvider.songs[index].title,
                                style: TextStyle(
                                    color:
                                        (songProvider.currentPlaying == index)
                                            ? Colors.red
                                            : Colors.white),
                              ),
                              subtitle: Text(
                                  "${songProvider.songs[index].artist} | ${songProvider.songs[index].duration.inMinutes.toString()} min"),
                              trailing: TextButton(
                                child: const Text(
                                  "Open Spotify",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () =>
                                    launchURL(songProvider.songs[index].url),
                              ),
                            );
                    }),
          )
        ],
      ),
    );
  }
}
