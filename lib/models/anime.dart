import 'package:aniflix/common/constants.dart';

class Anime {
  int id;
  String title;
  String description;
  int episode;
  int season;
  int year;
  int duration;
  String image;
  String banner;
  String trailer;
  int score;
  List<dynamic> genres;

  Anime(
      {this.id = -1,
      this.title = "",
      this.description = "",
      this.episode = 0,
      this.image = placerholder,
      this.trailer = "",
      this.score = 0,
      this.season = 0,
      this.banner = placerholder,
      required this.genres,
      this.year = 0,
      this.duration = 0});
}
