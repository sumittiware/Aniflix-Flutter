import 'dart:convert';
import 'dart:math';

import 'package:aniflix/models/anime.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BannerProvider with ChangeNotifier {
  Anime _bannerAnime = Anime(
    genres: [],
  );

  Anime getBanner() {
    return _bannerAnime;
  }

  BannerProvider() {
    getBannerAnime();
  }

  Future<void> getBannerAnime() async {
    int value = Random().nextInt(5000);
    final url = Uri.parse("https://api.aniapi.com/v1/anime/$value");
    final response = await http.get(url);
    final result = json.decode(response.body);
    _bannerAnime = Anime(
        id: result['data']["id"] ?? 0,
        title: result['data']['titles']['en'] ?? "",
        description: result['data']['descriptions']['en'] ?? "",
        season: result['data']['season_period'] ?? 0,
        episode: result['data']['episodes_count'] ?? 0,
        image: result['data']["cover_image"] ?? "",
        score: result['data']['score'] ?? 0,
        genres: result['data']['genres'] ?? [],
        trailer: result['data']['trailer_url'] ?? "",
        banner: result['data']['banner_image'] ?? "",
        duration: result['data']['episode_duration'] ?? 0,
        year: result['data']['season_year'] ?? 0);
    notifyListeners();
  }
}
