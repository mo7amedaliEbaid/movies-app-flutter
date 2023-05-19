class CastMemberSeries {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  String? character;
  String creditId;
  int? order;
  String? department;
  String? job;

  CastMemberSeries({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  factory CastMemberSeries.fromJson(Map<String, dynamic> json) => CastMemberSeries(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownForDepartment: json["known_for_department"],
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"]?.toDouble(),
    profilePath: json["profile_path"],
    character: json["character"],
    creditId: json["credit_id"],
    order: json["order"],
    department: json["department"],
    job: json["job"],
  );
  static List<CastMemberSeries> castFromSnapshot(List castSnapshot) {
    return castSnapshot.map((json) {
      return CastMemberSeries.fromJson(json);
    }).toList();
  }
}