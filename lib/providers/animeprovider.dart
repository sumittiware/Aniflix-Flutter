import 'dart:convert';
import 'dart:math';

import 'package:aniflix/config/enum.dart';
import 'package:aniflix/models/anime.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnimeProvider with ChangeNotifier {
  final List<Anime> _animes = [];
  final Set<int> _wishlist = {};

  DataStatus _datastatus = DataStatus.loading;

  AnimeProvider() {
    fetchAnimes();
  }

  DataStatus get datastatus => _datastatus;
  List<Anime> get animes => [..._animes];

  bool isSaved(int id) => _wishlist.contains(id);

  Future<void> fetchAnimes() async {
    int page = Random().nextInt(30);
    final url = Uri.parse("https://api.aniapi.com/v1/anime?page=${page + 1}");
    try {
      final response = await http.get(url);

      final result = json.decode(response.body);
      if (result['status_code'] != 200) {
        throw result['message'] ?? "Something went wrong!!";
      }
      result['data']['documents'].forEach((value) {
        _animes.add(Anime(
            id: value["id"] ?? 0,
            title: value['titles']['en'] ?? "",
            description: value['descriptions']['en'] ?? "",
            season: value['season_period'] ?? 0,
            episode: value['episodes_count'] ?? 0,
            image: value["cover_image"] ?? "",
            score: value['score'] ?? 0,
            genres: value['genres'] ?? [],
            trailer: value['trailer_url'] ?? "",
            year: value['season_year'] ?? 0,
            banner: value['banner_image'] ?? "",
            duration: value['episode_duration'] ?? 0));
      });
      _datastatus = DataStatus.loaded;
      notifyListeners();
    } catch (err) {
      throw err.toString();
    }
  }

  List<Anime> getAnimeByGnera(String gnera) {
    List<Anime> result = [];
    for (var element in _animes) {
      if (element.genres.contains(gnera)) result.add(element);
    }
    result.shuffle();
    return result;
  }

  Anime getAnimeById(int id) {
    return _animes.firstWhere((element) => element.id == id);
  }
}
