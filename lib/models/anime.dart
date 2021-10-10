class Anime {
  int id;
  String title;
  String description;
  int episode;
  int season;
  String image;
  String trailer;
  int score;

  Anime(
      {required this.id,
      required this.title,
      required this.description,
      required this.episode,
      required this.image,
      required this.trailer,
      required this.score,
      required this.season});
}

List<Anime> anime = [
  Anime(
      id: 113415,
      title: "Jujutsu Kaisen",
      description:
          "A boy fights... for \"the right death.\"<br>\n<br>\nHardship, regret, shame: the negative feelings that humans feel become Curses that lurk in our everyday lives. The Curses run rampant throughout the world, capable of leading people to terrible misfortune and even death. What's more, the Curses can only be exorcised by another Curse.<br>\n<br>\nItadori Yuji is a boy with tremendous physical strength, though he lives a completely ordinary high school life. One day, to save a friend who has been attacked by Curses, he eats the finger of the Double-Faced Specter, taking the Curse into his own soul. From then on, he shares one body with the Double-Faced Specter. Guided by the most powerful of sorcerers, Gojou Satoru, Itadori is admitted to the Tokyo Metropolitan Technical High School of Sorcery, an organization that fights the Curses... and thus begins the heroic tale of a boy who became a Curse to exorcise a Curse, a life from which he could never turn back.\n<br><br>\n(Source: Crunchyroll)<br>\n<br>\n<i>Note: The first episode received an early web premiere on September 19th, 2020. The regular TV broadcast started on October 3rd, 2020.</i>",
      episode: 24,
      image:
          "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx113415-979nF8TZP2xC.jpg",
      score: 88,
      trailer: "https://www.youtube.com/embed/YKJyP8L6QEs",
      season: 1),
  Anime(
      id: 101348,
      title: "Vinland Saga",
      description: "Amazing",
      episode: 24,
      image:
          "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx101348-NrnGlz0NsJuG.jpg",
      score: 87,
      trailer: "https://www.youtube.com/embed/5xqEp7R9SYM",
      season: 1),
  Anime(
      id: 112151,
      title: "Kimetsu no Yaiba: Mugen Ressha-hen",
      description: "",
      episode: 1,
      image:
          "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx112151-1qlQwPB1RrJe.png",
      trailer: "https://www.youtube.com/embed/23riEOmDOgM",
      score: 87,
      season: 1),
  Anime(
      id: 21679,
      title: "Bungou Stray Dogs 2",
      description:
          "Despite their differences in position, three men—the youngest senior executive of the Port Mafia, Osamu Dazai, the lowest ranking member, Sakunosuke Oda, and the intelligence agent, Angou Sakaguchi—gather at the Lupin Bar at the end of the day to relax and take delight in the company of friends.<br></br>\n\nHowever, one night, Angou disappears. A photograph taken at the bar is all that is left of the three together.<br></br>\n\nFast forward to the present, and Dazai is now a member of the Armed Detective Agency. The Guild, an American gifted organization, has entered the fray and is intent on taking the Agency's work permit. They must now divide their attention between the two groups, the Guild and the Port Mafia, who oppose their very existence.<br></br>\n",
      episode: 12,
      image:
          "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx21679-9MKdz1A7YLV7.jpg",
      trailer: "https://www.youtube.com/embed/aeX94e7V0_w",
      score: 82,
      season: 2),
  Anime(
      id: 99749,
      title: "Fairy Tail (2018)",
      description:
          "The final season of <i>Fairy Tail</i>.\n<br><br>\nFairy Tail has been disbanded. A year later, Lucy comes into contact with Natsu and Happy. The three of them try to find the other former members' whereabouts to reconstruct the guild as they seek the real reason behind the guild's disbandment.\n<br><br>\n(Source: Anime News Network)",
      episode: 51,
      image:
          "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/nx99749-tvz2LCPdMyrp.jpg",
      trailer: "https://www.youtube.com/embed/DDXd4o_XBeE",
      score: 75,
      season: 5)
];
