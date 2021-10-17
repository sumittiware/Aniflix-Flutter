class Song {
  int id;
  int animeId;
  Duration duration;
  String title;
  String artist;
  String url;
  String preview;
  Song(
      {required this.id,
      required this.animeId,
      required this.title,
      required this.artist,
      required this.duration,
      required this.url,
      required this.preview});
}
