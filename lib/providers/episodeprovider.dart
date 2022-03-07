import 'dart:convert';
import 'package:aniflix/models/episode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EpisodeProvider with ChangeNotifier {
  final List<Episode> _eposides = [];
  bool _isFetched = false;
  late int lastPage = 1;
  late int currentPage = 0;

  List<Episode> get episodes => [..._eposides];
  bool get isFetched => _isFetched;

  Episode getById(int id) =>
      _eposides.firstWhere((element) => element.id == id);

  Future<void> fetchEpisodes(int animeId) async {
    try {
      if (currentPage == lastPage) throw "That's all!!";
      final url = Uri.parse(
          "https://api.aniapi.com/v1/episode?anime_id=$animeId&source=dreamsub&locale=it&page=${currentPage + 1}");
      final response = await http.get(url);
      final result = json.decode(response.body);
      if (result['status_code'] != 200) {
        throw result['message'] ?? "Something went wrong!!";
      }
      result['data']['documents'].forEach((element) {
        _eposides.add(Episode(
            id: element['id'] ?? "-1",
            animeId: element['anime_id'] ?? -1,
            title: element['title'].toString(),
            number: element['number'] ?? -1,
            videoUrl: element['video'].toString()));
      });
      currentPage = result['data']['current_page'];
      lastPage = result['data']['last_page'];
      _isFetched = true;
      notifyListeners();
    } catch (err) {
      throw err.toString();
    }
  }

  void resetValues() {
    currentPage = 0;
    lastPage = 1;
    _isFetched = false;
    _eposides.clear();
    notifyListeners();
  }
}
