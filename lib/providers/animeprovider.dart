import 'package:aniflix/config/enum.dart';
import 'package:aniflix/models/anime.dart';
import 'package:aniflix/services/api_services.dart';
import 'package:flutter/material.dart';

class AnimeProvider with ChangeNotifier {
  final _apiService = ApiService();
  Anime? _bannerAnime;
  final List<Anime> _animes = [];
  final List<Anime> _recommended = [];
  final Set<int> _wishlist = {};

  // pagination utils
  int _currentPage = 0;
  int _lastPage = -1;

  DataStatus _datastatus = DataStatus.loading;

  AnimeProvider() {
    fetchAnimes();
    fetchBanner();
  }

  setStatus(DataStatus status) {
    _datastatus = status;
    notifyListeners();
  }

  DataStatus get datastatus => _datastatus;
  List<Anime> get animes => [..._animes];
  List<Anime> get recommended => [..._recommended];
  Anime? get bannerAnime => _bannerAnime;
  bool isSaved(int id) => _wishlist.contains(id);

  Future<void> fetchAnimes() async {
    setStatus(DataStatus.loading);
    Map<String, dynamic> data = await _apiService.get(
      endpoint: '/top/anime',
    );

    if (data['current_page'] != null) {
      _currentPage = data['current_page'];
    }
    if (data['last_page'] != null) {
      _lastPage = data['last_page'];
    }

    for (var ele in data['data']) {
      _animes.add(
        Anime.fromJson(ele),
      );
    }
    setStatus(DataStatus.loaded);
  }

  Future<void> fetchBanner() async {
    final data = await _apiService.get(
      endpoint: '/random/anime/',
    );
    _bannerAnime = Anime.fromJson(
      data['data'],
    );
    notifyListeners();
  }

  Future<void> fetchRecommended(int id) async {
    try {
      _recommended.clear();
      Map<String, dynamic> data = await _apiService.get(
        endpoint: '/anime/$id/recommendations/',
      );
      print(data);
      for (var ele in data['data']) {
        _recommended.add(
          Anime.formRecommendedJson(
            ele['entry'],
          ),
        );
      }

      notifyListeners();
    } catch (_) {
      debugPrint('recomended error');
      debugPrint(_.toString());
    }
  }

  List<Anime> getAnimeByGnera(int id) {
    List<Anime> result = [];
    for (var a in _animes) {
      for (var gnere in a.genres!) {
        if (gnere.malId == id) {
          result.add(a);
        }
      }
    }
    result.shuffle();
    return result;
  }

  Future<Anime> getAnimeById(int id) async {
    Anime anime = _animes.firstWhere(
      (element) => element.malId == id,
      orElse: () => Anime(
        malId: -1,
      ),
    );

    if (anime.malId == -1) {
      final data = await _apiService.get(
        endpoint: '/anime/$id',
      );

      anime = Anime.fromJson(data['data']);
    }
    return anime;
  }
}
