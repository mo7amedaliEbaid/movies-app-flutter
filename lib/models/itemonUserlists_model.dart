class ItemOnUserlistsModel {
  String? backdropPath;
  int id;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? title;

  ItemOnUserlistsModel({
     this.backdropPath,
    required this.id,
     this.originalTitle,
     this.overview,
     this.posterPath,
     this.title,
  });

  factory ItemOnUserlistsModel.fromJson(Map<String, dynamic> json) => ItemOnUserlistsModel(
    backdropPath: json["backdrop_path"]??null,
    id: json["id"],
    originalTitle: json["original_title"]??null,
    overview: json["overview"]??null,
    posterPath: json["poster_path"]??null,
    title: json["title"]??null,
  );
  static List<ItemOnUserlistsModel> ItemsFromSnapshot(List wmvsSnapshot) {
    return wmvsSnapshot.map((json) {
      return ItemOnUserlistsModel.fromJson(json);
    }).toList();
  }
}
