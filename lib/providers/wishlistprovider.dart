// ignore_for_file: file_names

import 'dart:convert';

import 'package:aniflix/config/enum.dart';
import 'package:aniflix/models/anime.dart';
import 'package:aniflix/models/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class WishListProvider with ChangeNotifier {
  List<WishList> _wishlist = [];
  DataStatus _dataStatus = DataStatus.loading;

  WishListProvider() {
    fetchWishList();
  }
  DataStatus get dataStatus => _dataStatus;
  List<WishList> get wishlist => [..._wishlist];

  bool isPresent(int id) => _wishlist.any((element) => element.id == id);

  Future<void> fetchWishList() async {
    try {
      final box = Hive.box<WishList>('wishlist');
      for (var element in box.values) {
        _wishlist.add(element);
      }
      _dataStatus = DataStatus.loaded;
      notifyListeners();
    } catch (err) {
      throw err.toString();
    }
  }

  Future<void> addToWishlist(int id, String title, String imageUrl) async {
    try {
      final item = WishList(id: id, title: title, imageUrl: imageUrl);
      int value = _wishlist.indexWhere((element) => element.id == id);
      if (value != -1) throw "Added to Wishlist!!!";
      final box = Hive.box<WishList>('wishlist');
      await box.put(id, item);
      _wishlist.add(item);
      notifyListeners();
    } catch (err) {
      throw err.toString();
    }
  }

  Future<void> removeFromList(int id) async {
    try {
      final box = Hive.box<WishList>('wishlist');
      await box.delete(id);
      _wishlist.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (err) {
      throw err.toString();
    }
  }

  Future<Anime> fetchById(int id) async {
    final url = Uri.parse("https://api.aniapi.com/v1/anime/$id");
    final response = await http.get(url);
    final result = json.decode(response.body);
    final anime = Anime(
        id: result['data']["id"] ?? 0,
        title: result['data']['titles']['en'] ?? "",
        description: result['data']['descriptions']['en'] ?? "",
        season: result['data']['season_period'] ?? 0,
        episode: result['data']['episodes_count'] ?? 0,
        image: result['data']["cover_image"] ?? "",
        score: result['data']['score'] ?? 0,
        genres: result['data']['genres'] ?? [],
        trailer: "",
        duration: result['data']['episode_duration'] ?? 0,
        year: result['data']['season_year'] ?? 0);
    return anime;
  }
}
