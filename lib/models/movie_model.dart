class Movie {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    required this.adult,
     this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
     this.posterPath,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    adult: json["adult"],
    backdropPath: json["backdrop_path"]??'',
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
   // originalLanguage: originalLanguageValues.map[json["original_language"]],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"]??null,
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  static List<Movie> moviesFromSnapshot(List mvsSnapshot) {
    return mvsSnapshot.map((json) {
      return Movie.fromJson(json);
    }).toList();
  }
}

enum OriginalLanguage { EN, ES, FI }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES,
  "fi": OriginalLanguage.FI
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}