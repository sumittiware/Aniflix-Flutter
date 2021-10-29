import 'dart:convert';

import 'package:aniflix/config/enum.dart';
import 'package:aniflix/screens/allanime.dart';
import 'package:aniflix/screens/allepisodes.dart';
import 'package:aniflix/screens/detail.dart';
import 'package:aniflix/screens/homepage.dart';
import 'package:aniflix/screens/searchscreen.dart';
import 'package:aniflix/screens/tabsceen.dart';
import 'package:aniflix/screens/videoscreen.dart';
import 'package:aniflix/screens/wishlist.dart';
import 'package:aniflix/services/analytics_services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class CustomRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    FirebaseAnalytics().logEvent(
        name: "screen_view", parameters: {"screen": "${settings.name},"});
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => TabScreen());
      case '/homescreen':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/searchscreen':
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case '/wishlist':
        return MaterialPageRoute(builder: (_) => FavouritesScreen());
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
                  body: Center(
                    child: Text("Page not found"),
                  ),
                ));
    }
  }
}
