class Episode {
  int? malId;
  String? url;
  String? title;
  String? titleJapanese;
  String? titleRomanji;
  String? aired;
  double? score;
  bool? filler;
  bool? recap;
  String? forumUrl;

  Episode(
      {this.malId,
      this.url,
      this.title,
      this.titleJapanese,
      this.titleRomanji,
      this.aired,
      this.score,
      this.filler,
      this.recap,
      this.forumUrl});

  Episode.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    url = json['url'];
    title = json['title'];
    titleJapanese = json['title_japanese'];
    titleRomanji = json['title_romanji'];
    aired = json['aired'];
    score = json['score'];
    filler = json['filler'];
    recap = json['recap'];
    forumUrl = json['forum_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['mal_id'] = malId;
    data['url'] = url;
    data['title'] = title;
    data['title_japanese'] = titleJapanese;
    data['title_romanji'] = titleRomanji;
    data['aired'] = aired;
    data['score'] = score;
    data['filler'] = filler;
    data['recap'] = recap;
    data['forum_url'] = forumUrl;
    return data;
  }
}
