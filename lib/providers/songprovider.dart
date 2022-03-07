import 'dart:convert';

import 'package:aniflix/config/enum.dart';
import 'package:aniflix/models/song.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

class SongProvider with ChangeNotifier {
  final List<Song> _songs = [];
  final List<Song> _animeSongs = [];
  DataStatus _dataStatus = DataStatus.loading;
  late int lastPage = 1;
  late int currentPage = 0;
  int currentPlaying = -1;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool playing = false;

  SongProvider() {
    fetchSongs();
  }

  DataStatus get dataStatus => _dataStatus;
  List<Song> get songs => [..._songs];
  List<Song> get animeSongs => [..._animeSongs];

  void pause() {
    _audioPlayer.pause();
    playing = false;
    notifyListeners();
  }

  Future<void> playSong(int index, {bool fromDetail = false}) async {
    if (index == currentPlaying) {
      _audioPlayer.resume();
    } else {
      await _audioPlayer.play(
          (!fromDetail) ? _songs[index].preview : _animeSongs[index].preview);
      currentPlaying = index;
    }
    playing = true;
    notifyListeners();
  }

  Future<void> fetchSongByAnime(int id) async {
    try {
      final url = Uri.parse("https://api.aniapi.com/v1/song?anime_id=$id");
      final response = await http.get(url);
      final result = json.decode(response.body);
      if (result['status_code'] != 200) {
        throw result['message'] ?? "Something went wrong!!";
      }
      result['data']['documents'].forEach((element) {
        _animeSongs.add(
          Song(
              id: element['id'] ?? "-1",
              animeId: element['anime_id'] ?? "-1",
              title: element['title'] ?? "Unknowm",
              artist: element['artist'] ?? "Unknown",
              duration: Duration(milliseconds: element['duration'] ?? 0),
              url: element['open_spotify_url'] ?? "",
              preview: element['preview_url'] ?? ""),
        );
        _dataStatus = DataStatus.loaded;
        notifyListeners();
      });
    } catch (err) {
      throw err.toString();
    }
  }

  Future<void> fetchSongs() async {
    try {
      if (currentPage == lastPage) throw "Nothing to show!!";
      final url =
          Uri.parse("https://api.aniapi.com/v1/song?page=${currentPage + 1}");
      final response = await http.get(url);
      final result = json.decode(response.body);
      if (result['status_code'] != 200) {
        throw result['message'] ?? "Something went wrong!!";
      }
      result['data']['documents'].forEach((element) {
        _songs.add(
          Song(
              id: element['id'] ?? "-1",
              animeId: element['anime_id'] ?? "-1",
              title: element['title'] ?? "Unknowm",
              artist: element['artist'] ?? "Unknown",
              duration: Duration(milliseconds: element['duration'] ?? 0),
              url: element['open_spotify_url'] ?? "",
              preview: element['preview_url'] ?? ""),
        );
        _dataStatus = DataStatus.loaded;
        currentPage = result['data']['current_page'];
        lastPage = result['data']['last_page'];
        notifyListeners();
      });
    } catch (err) {
      throw err.toString();
    }
  }

  void resetValues() {
    _audioPlayer.pause();
    playing = false;
    currentPlaying = -1;
    _animeSongs.clear();
    notifyListeners();
  }
}
