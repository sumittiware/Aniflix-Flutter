import 'dart:convert';

import 'package:aniflix/config/enum.dart';
import 'package:aniflix/screens/all_anime_screen.dart';
import 'package:aniflix/screens/all_episodes_page.dart';
import 'package:aniflix/screens/detail.dart';
import 'package:aniflix/screens/home_page.dart';
import 'package:aniflix/screens/search_screen.dart';
import 'package:aniflix/screens/tab_sceen.dart';
import 'package:aniflix/screens/video_screen.dart';
import 'package:aniflix/screens/favourites_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class CustomRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    FirebaseAnalytics().logEvent(
        name: "screen_view", parameters: {"screen": "${settings.name},"});
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const TabScreen());
      case '/homescreen':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/searchscreen':
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case '/wishlist':
        return MaterialPageRoute(builder: (_) => const FavouritesScreen());
      case '/detailscreen':
        final arge = json.decode(settings.arguments.toString());
        final id = arge['id'];
        final type = arge['type'];
        return MaterialPageRoute(
            builder: (_) => AnimeDetail(id: id, type: ResultType.values[type]));
      case '/allanimescreen':
        final arge = json.decode(settings.arguments.toString());
        final gnera = arge['gnera'];
        final query = arge['query'];
        return MaterialPageRoute(
            builder: (_) => AllAnimeScreen(
                  genra: gnera,
                  query: query,
                ));
      case '/allepisodescreen':
        final arge = json.decode(settings.arguments.toString());
        final id = arge['id'];
        final title = arge['title'];
        return MaterialPageRoute(
            builder: (_) => AllEpisodesPage(id: id, title: title));
      case '/videoscreen':
        final arge = json.decode(settings.arguments.toString());
        final videoUrl = arge['videoUrl'];
        final title = arge['title'];
        return MaterialPageRoute(
            builder: (_) => VideoScreen(title: title, videoUrl: videoUrl));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  appBar: AppBar(),
                  body: const Center(
                    child: Text("Page not found"),
                  ),
                ));
    }
  }
}
