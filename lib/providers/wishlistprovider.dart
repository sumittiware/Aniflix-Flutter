// ignore_for_file: file_names

import 'dart:convert';

import 'package:aniflix/config/enum.dart';
import 'package:aniflix/models/anime.dart';
import 'package:aniflix/models/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class WishListProvider with ChangeNotifier {
  final List<WishList> _wishlist = [];
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

  Future<void> removeFromList(String id) async {
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
    return Anime();
  }
}
