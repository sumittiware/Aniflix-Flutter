class Anime {
  int id;
  String title;
  String description;
  int episode;
  int season;
  int year;
  int duration;
  String image;
  String trailer;
  int score;
  List<dynamic> genres;

  Anime(
      {required this.id,
      required this.title,
      required this.description,
      required this.episode,
      required this.image,
      required this.trailer,
      required this.score,
      required this.season,
      required this.genres,
      required this.year,
      required this.duration});
}
