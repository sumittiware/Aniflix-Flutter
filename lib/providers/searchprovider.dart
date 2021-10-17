import 'dart:convert';

import 'package:aniflix/config/enum.dart';
import 'package:aniflix/models/anime.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchProvider with ChangeNotifier {
  final List<Anime> _searchResults = [];
  final List<Anime> _gneraResult = [];
  List<dynamic> _gneres = [];

  SearchProvider() {
    fetchGneres();
  }

  int currentPage = 0;
  int lastPage = 1;
  late DataStatus _dataStatus;

  DataStatus get dataStatus => _dataStatus;

  List<Anime> get gneraAnime => [..._gneraResult];

  List<Anime> get searchResult => [..._searchResults];

  List<dynamic> get gneres => [..._gneres];

  void resetValues() {
    currentPage = 0;
    lastPage = 1;
    _searchResults.clear();
    _gneraResult.clear();
  }

  Future<void> fetchGneres() async {
    final url = Uri.parse("https://api.aniapi.com/v1/resources/1.0/0");
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) throw "Something went wrong!!";
      final result = json.decode(response.body);

      _gneres = result['data']['genres'] as List<dynamic>;
      notifyListeners();
    } catch (err) {
      throw err.toString();
    }
  }

  Future<void> fetchByTitle(String title) async {
    _searchResults.clear();
    title = title
      ..trimRight()
      ..replaceAll(" ", "%20");
    final url = Uri.parse("https://api.aniapi.com/v1/anime?title=$title");
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) throw "Something went wrong!!";
      final result = json.decode(response.body);
      result['data']['documents'].forEach((value) {
        _searchResults.add(Anime(
            id: value["id"] ?? 0,
            title: value['titles']['en'] ?? "",
            description: value['descriptions']['en'] ?? "",
            season: value['season_period'] ?? 0,
            episode: value['episodes_count'] ?? 0,
            image: value["cover_image"] ?? "",
            score: value['score'] ?? 0,
            genres: value['genres'] ?? [],
            trailer: value['trailer_url'] ?? "",
            duration: value['episode_duration'] ?? 0,
            year: value['season_year'] ?? 0));
      });
      _dataStatus = DataStatus.loaded;
      notifyListeners();
    } catch (err) {
      throw err.toString();
    }
  }

  Future<void> fetchByGners(String gners) async {
    _dataStatus = DataStatus.loading;
    notifyListeners();
    final url = Uri.parse(
        "https://api.aniapi.com/v1/anime?genres=$gners&page=${currentPage + 1}");
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) throw "Something went wrong!!";
      final result = json.decode(response.body);
      result['data']['documents'].forEach((value) {
        _gneraResult.add(Anime(
            id: value["id"] ?? 0,
            title: value['titles']['en'] ?? "",
            description: value['descriptions']['en'] ?? "",
            season: value['season_period'] ?? 0,
            episode: value['episodes_count'] ?? 0,
            image: value["cover_image"] ?? "",
            score: value['score'] ?? 0,
            genres: value['genres'] ?? [],
            trailer: value['trailer_url'] ?? "",
            duration: value['episode_duration'] ?? 0,
            year: value['season_year'] ?? 0));
      });
      currentPage = result['data']['current_page'];
      lastPage = result['data']['last_page'];
      _dataStatus = DataStatus.loaded;
      notifyListeners();
    } catch (err) {
      throw err.toString();
    }
  }

  Anime getGneraById(int id) {
    return _gneraResult.firstWhere((element) => element.id == id);
  }

  Anime getSearchById(int id) {
    return _searchResults.firstWhere((element) => element.id == id);
  }
}
