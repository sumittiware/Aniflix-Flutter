import 'package:aniflix/models/genra.dart';
import 'package:aniflix/models/images.dart';
import 'package:aniflix/models/theme.dart';
import 'package:aniflix/models/titles.dart';
import 'package:aniflix/models/trailer.dart';

import 'broadcast.dart';

class Anime {
  int? malId;
  String? url;
  Images? images;
  Trailer? trailer;
  bool? approved;
  List<Titles>? titles;
  String? title;
  String? titleEnglish;
  String? titleJapanese;
  String? type;
  String? source;
  int? episodes;
  String? status;
  bool? airing;
  String? aired;
  String? duration;
  String? rating;
  double? score;
  int? scoredBy;
  int? rank;
  int? popularity;
  int? members;
  int? favorites;
  String? synopsis;
  String? background;
  String? season;
  int? year;
  Broadcast? broadcast;
  List<Genra>? genres;
  List<Theme>? themes;

  Anime({
    this.malId,
    this.url,
    this.images,
    this.trailer,
    this.approved,
    this.titles,
    this.title,
    this.titleEnglish,
    this.titleJapanese,
    this.type,
    this.source,
    this.episodes,
    this.status,
    this.airing,
    this.aired,
    this.duration,
    this.rating,
    this.score,
    this.scoredBy,
    this.rank,
    this.popularity,
    this.members,
    this.favorites,
    this.synopsis,
    this.background,
    this.season,
    this.year,
    this.broadcast,
    this.genres,
    this.themes,
  });

  Anime.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    url = json['url'];
    images = json['images']['jpg'] != null
        ? Images.fromJson(json['images']['jpg'])
        : null;
    trailer =
        json['trailer'] != null ? Trailer.fromJson(json['trailer']) : null;
    approved = json['approved'];
    if (json['titles'] != null) {
      titles = <Titles>[];
      json['titles'].forEach(
        (v) {
          titles!.add(
            Titles.fromJson(v),
          );
        },
      );
    }
    title = json['title'];
    titleEnglish = json['title_english'];
    titleJapanese = json['title_japanese'];

    type = json['type'];
    source = json['source'];
    episodes = json['episodes'];
    status = json['status'];
    airing = json['airing'];
    aired = json['aired']['string'];
    duration = json['duration'];
    rating = json['rating'];
    score = json['score'];
    scoredBy = json['scored_by'];
    rank = json['rank'];
    popularity = json['popularity'];
    members = json['members'];
    favorites = json['favorites'];
    synopsis = json['synopsis'];
    background = json['background'];
    season = json['season'];
    year = json['year'];
    broadcast = json['broadcast'] != null
        ? Broadcast.fromJson(json['broadcast'])
        : null;

    if (json['genres'] != null) {
      genres = <Genra>[];
      json['genres'].forEach((v) {
        genres!.add(Genra.fromJson(v));
      });
    }

    if (json['themes'] != null) {
      themes = <Theme>[];
      json['themes'].forEach((v) {
        themes!.add(Theme.fromJson(v));
      });
    }
  }

  Anime.formRecommendedJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    url = json['url'];
    images = json['images']['jpg'] != null
        ? Images.fromJson(json['images']['jpg'])
        : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['mal_id'] = malId;
    data['url'] = url;
    if (images != null) {
      data['images'] = images!.toJson();
    }
    if (trailer != null) {
      data['trailer'] = trailer!.toJson();
    }
    data['approved'] = approved;
    if (titles != null) {
      data['titles'] = titles!.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    data['title_english'] = titleEnglish;
    data['title_japanese'] = titleJapanese;

    data['type'] = type;
    data['source'] = source;
    data['episodes'] = episodes;
    data['status'] = status;
    data['airing'] = airing;

    data['aired'] = aired;

    data['duration'] = duration;
    data['rating'] = rating;
    data['score'] = score;
    data['scored_by'] = scoredBy;
    data['rank'] = rank;
    data['popularity'] = popularity;
    data['members'] = members;
    data['favorites'] = favorites;
    data['synopsis'] = synopsis;
    data['background'] = background;
    data['season'] = season;
    data['year'] = year;
    if (broadcast != null) {
      data['broadcast'] = broadcast!.toJson();
    }

    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }

    if (themes != null) {
      data['themes'] = themes!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
