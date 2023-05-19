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
  static List<Genre> genresFromSnapshot(List gnsSnapshot) {
    return gnsSnapshot.map((json) {
      return Genre.fromJson(json);
    }).toList();
  }
}
