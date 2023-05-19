class MovieDetails {
  String? backdropPath;
  int? budget;
  List<Genre>? genres;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  List<ProductionCompany>? productionCompanies;
  List<ProductionCountry>? productionCountries;
  DateTime releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguage>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  double? voteAverage;
  int? voteCount;

  MovieDetails({
     this.backdropPath,
     this.budget,
     this.genres,
     this.id,
     this.originalLanguage,
     this.originalTitle,
     this.overview,
     this.posterPath,
     this.productionCompanies,
     this.productionCountries,
    required this.releaseDate,
     this.revenue,
     this.runtime,
     this.spokenLanguages,
     this.status,
     this.tagline,
     this.title,
     this.voteAverage,
     this.voteCount,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
    backdropPath: json["backdrop_path"]??null,
    budget: json["budget"]??0,
    genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
    id: json["id"],
    originalLanguage: json["original_language"]??'',
    originalTitle: json["original_title"]??'',
    overview: json["overview"]??'',
    posterPath: json["poster_path"]??null,
    productionCompanies: List<ProductionCompany>.from(json["production_companies"].map((x) => ProductionCompany.fromJson(x))),
    productionCountries: List<ProductionCountry>.from(json["production_countries"].map((x) => ProductionCountry.fromJson(x))),
    releaseDate: DateTime.parse(json["release_date"]),
    revenue: json["revenue"]??0,
    runtime: json["runtime"]??0,
    spokenLanguages: List<SpokenLanguage>.from(json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
    status: json["status"]??"",
    tagline: json["tagline"]??'',
    title: json["title"]??'',
    voteAverage: json["vote_average"]?.toDouble()??0.0,
    voteCount: json["vote_count"]??0,
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

class ProductionCompany {
  int id;
//  String logoPath;
  String name;
  String originCountry;

  ProductionCompany({
    required this.id,
   // required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) => ProductionCompany(
    id: json["id"],
    name: json["name"],
    originCountry: json["origin_country"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "origin_country": originCountry,
  };
}

class ProductionCountry {
  String iso31661;
  String name;

  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) => ProductionCountry(
    iso31661: json["iso_3166_1"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "iso_3166_1": iso31661,
    "name": name,
  };
}

class SpokenLanguage {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguage({
     this.englishName,
     this.iso6391,
     this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
    englishName: json["english_name"]??'',
    iso6391: json["iso_639_1"]??"",
    name: json["name"]??"",
  );

}
