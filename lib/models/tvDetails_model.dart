class TvDetails {
  String? backdropPath;
  List<CreatedBy>? createdBy;
  List<int>? episodeRunTime;
  DateTime firstAirDate;
  List<Genre>? genres;
  int? id;
  bool? inProduction;
  String? name;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalName;
  String? overview;
  String? posterPath;
  List<Season>? seasons;
  List<SpokenLanguage>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  double? voteAverage;
  int? voteCount;

  TvDetails({
     this.backdropPath,
     this.createdBy,
     this.episodeRunTime,
    required this.firstAirDate,
     this.genres,
     this.id,
     this.inProduction,
     this.name,
     this.numberOfEpisodes,
     this.numberOfSeasons,
     this.originCountry,
     this.originalName,
     this.overview,
     this.posterPath,
     this.seasons,
     this.spokenLanguages,
     this.status,
     this.tagline,
     this.type,
     this.voteAverage,
     this.voteCount,
  });

  factory TvDetails.fromJson(Map<String, dynamic> json) => TvDetails(
    backdropPath: json["backdrop_path"]??null,
    createdBy: List<CreatedBy>.from(json["created_by"].map((x) => CreatedBy.fromJson(x))),
    episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
    firstAirDate: DateTime.parse(json["first_air_date"]),
    genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
    id: json["id"]??null,
    inProduction: json["in_production"]??null,
    name: json["name"]??null,
    numberOfEpisodes: json["number_of_episodes"]??null,
    numberOfSeasons: json["number_of_seasons"]??null,
    originCountry: List<String>.from(json["origin_country"].map((x) => x)),
    originalName: json["original_name"]??null,
    overview: json["overview"]??null,
    posterPath: json["poster_path"]??null,
    seasons: List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
    spokenLanguages: List<SpokenLanguage>.from(json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
    status: json["status"]??null,
    tagline: json["tagline"]??null,
    type: json["type"]??null,
    voteAverage: json["vote_average"]?.toDouble()??null,
    voteCount: json["vote_count"]??null,
  );

}

class CreatedBy {
  String? name;
  String? profilePath;

  CreatedBy({
     this.name,
     this.profilePath,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    name: json["name"]??null,
    profilePath: json["profile_path"]??null,
  );

}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Season {
  int? episodeCount;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  int? seasonNumber;

  Season({
     this.episodeCount,
     this.id,
     this.name,
     this.overview,
     this.posterPath,
     this.seasonNumber,
  });

  factory Season.fromJson(Map<String, dynamic> json) => Season(
    episodeCount: json["episode_count"]??null,
    id: json["id"]??null,
    name: json["name"]??null,
    overview: json["overview"]??null,
    posterPath: json["poster_path"]??null,
    seasonNumber: json["season_number"]??null,
  );
}

class SpokenLanguage {
  String englishName;
  String iso6391;
  String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
    englishName: json["english_name"],
    iso6391: json["iso_639_1"],
    name: json["name"],
  );

}
