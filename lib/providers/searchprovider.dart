import 'dart:convert';

import 'package:aniflix/config/enum.dart';
import 'package:aniflix/models/anime.dart';
import 'package:aniflix/models/genra.dart';
import 'package:aniflix/services/api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SearchProvider with ChangeNotifier {
  final _apiService = ApiService();
  int _currentPage = 0;
  int _lastPage = -1;
  final List<Anime> _searchResults = [];
  final List<Anime> _gneraResult = [];
  final List<Genra> _gneres = [];

  final List<String> _format = [
    "TV",
    "TV short",
    "Movie",
    "Special",
    "Ova",
  ];

  final List<String> _period = [
    "Winter",
    "Spring",
    "Summer",
    "Fall",
  ];

  final List<int> _selectedFormat = [];
  final List<int> _selectedPeriod = [];

  SearchProvider() {
    fetchGneres();
  }
  late DataStatus _dataStatus;

  DataStatus get dataStatus => _dataStatus;
  List<Anime> get gneraAnime => [
        ..._gneraResult,
      ];
  List<Anime> get searchResult => [
        ..._searchResults,
      ];
  List<Genra> get gneres => [
        ..._gneres,
      ];
  List<String> get format => [
        ..._format,
      ];
  List<int> get selectedFormat => [
        ..._selectedFormat,
      ];
  List<String> get period => [
        ..._period,
      ];
  List<int> get selectedPeriod => [
        ..._selectedPeriod,
      ];

  void resetValues() {
    _currentPage = 0;
    _lastPage = 1;
    _searchResults.clear();
    _gneraResult.clear();
  }

  setPeriodFilter(int index) {
    (!_selectedPeriod.contains(index))
        ? _selectedPeriod.add(index)
        : _selectedPeriod.remove(index);
    if (kDebugMode) {
      print(_selectedPeriod);
    }
    notifyListeners();
  }

  setFormatFilter(int index) {
    (!_selectedFormat.contains(index))
        ? _selectedFormat.add(index)
        : _selectedFormat.remove(index);
    notifyListeners();
  }

  Future<void> fetchGneres() async {
    _gneres.clear();
    Map<String, dynamic> data = await _apiService.get(
      endpoint: '/genres/anime',
    );

    for (var ele in data['data']) {
      _gneres.add(
        Genra.fromJson(ele),
      );
    }
    notifyListeners();
  }

  Future<void> fetchByTitle(String title) async {}

  Future<void> fetchByGners(int id) async {
    _currentPage++;

    Map<String, dynamic> data = await _apiService.get(
      endpoint: '/anime?genres=$id&page=$_currentPage',
    );
    if (data['current_page'] != null) {
      _currentPage = data['current_page'];
    }
    if (data['last_page'] != null) {
      _lastPage = data['last_page'];
    }
    for (var ele in data['data']) {
      _gneraResult.add(
        Anime.fromJson(ele),
      );
    }
    notifyListeners();
  }

  Anime getGneraById(int id) {
    return _gneraResult.firstWhere((element) => element.malId == id);
  }

  Anime getSearchById(int id) {
    return _searchResults.firstWhere((element) => element.malId == id);
  }
}
