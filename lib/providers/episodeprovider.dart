import 'dart:convert';
import 'package:aniflix/models/episode.dart';
import 'package:aniflix/services/api_services.dart';
import 'package:flutter/material.dart';

class EpisodeProvider with ChangeNotifier {
  final _apiService = ApiService();
  final List<Episode> _eposides = [];
  bool _isFetched = false;
  late int lastPage = 1;
  late int currentPage = 0;

  List<Episode> get episodes => [..._eposides];
  bool get isFetched => _isFetched;

  Episode getById(int id) =>
      _eposides.firstWhere((element) => element.malId == id);

  Future<void> fetchEpisodes(int animeId) async {
    try {
      Map<String, dynamic> data = await _apiService.get(
        endpoint: '/anime/$animeId/episodes/',
      );
      for (var ele in data['data']) {
        _eposides.add(
          Episode.fromJson(ele),
        );
      }
      notifyListeners();
    } catch (_) {
      print(_.toString());
    }
  }

  Future<String> getEpisodesDetail(
    int animeId,
    int episodeId,
  ) async {
    Map<String, dynamic> data = await _apiService.get(
      endpoint: '/anime/$animeId/episodes/$episodeId',
    );
    if (data['data'].isNotEmpty) {
      return data['data']['synopsis'];
    }
    return '';
  }

  void resetValues() {
    currentPage = 0;
    lastPage = 1;
    _isFetched = false;
    _eposides.clear();
    notifyListeners();
  }
}
