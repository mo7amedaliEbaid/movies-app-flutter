class Celeb {
  bool adult;
  int id;
  String name;
  String originalName;
  double popularity;
  int gender;
  KnownForDepartment? knownForDepartment;
  String? profilePath;
  List<KnownFor> knownFor;

  Celeb({
    required this.adult,
    required this.id,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.gender,
     this.knownForDepartment,
     this.profilePath,
    required this.knownFor,
  });

  factory Celeb.fromJson(Map<String, dynamic> json) => Celeb(
    adult: json["adult"],
    id: json["id"],
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"]?.toDouble(),
    gender: json["gender"],
    knownForDepartment: knownForDepartmentValues.map[json["known_for_department"]]??null,
    profilePath: json["profile_path"]??null,
    knownFor: List<KnownFor>.from(json["known_for"].map((x) => KnownFor.fromJson(x))),
  );
  static List<Celeb> celebsFromSnapshot(List clbsSnapshot) {
    return clbsSnapshot.map((json) {
      return Celeb.fromJson(json);
    }).toList();
  }

}
class KnownFor {
  bool adult;
  String? backdropPath;
  int id;
  String? title;
  OriginalLanguage? originalLanguage;
  String? originalTitle;
  String overview;
  String? posterPath;
  KnownForMediaType mediaType;
  List<int> genreIds;
  double popularity;
  bool? video;
  double voteAverage;
  int voteCount;
  String? name;
  String? originalName;
  List<String>? originCountry;

  KnownFor({
    required this.adult,
    this.backdropPath,
    required this.id,
    this.title,
     this.originalLanguage,
    this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    this.video,
    required this.voteAverage,
    required this.voteCount,
    this.name,
    this.originalName,
    this.originCountry,
  });

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
    adult: json["adult"],
    backdropPath: json["backdrop_path"]??'',
    id: json["id"],
    title: json["title"],
    originalLanguage: originalLanguageValues.map[json["original_language"]]??null,
    originalTitle: json["original_title"],
    overview: json["overview"],
    posterPath: json["poster_path"]??'',
    mediaType: knownForMediaTypeValues.map[json["media_type"]]!,
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    popularity: json["popularity"]?.toDouble(),
    video: json["video"]??false,
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    name: json["name"],
    originalName: json["original_name"],
    originCountry: json["origin_country"] == null ? [] : List<String>.from(json["origin_country"]!.map((x) => x)),
  );

}

enum KnownForMediaType { MOVIE, TV }

final knownForMediaTypeValues = EnumValues({
  "movie": KnownForMediaType.MOVIE,
  "tv": KnownForMediaType.TV
});

enum OriginalLanguage { EN, KO }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "ko": OriginalLanguage.KO
});


enum KnownForDepartment { ACTING, DIRECTING, WRITING }

final knownForDepartmentValues = EnumValues({
  "Acting": KnownForDepartment.ACTING,
  "Directing": KnownForDepartment.DIRECTING,
  "Writing": KnownForDepartment.WRITING
});

enum ResultMediaType { PERSON }

final resultMediaTypeValues = EnumValues({
  "person": ResultMediaType.PERSON
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
