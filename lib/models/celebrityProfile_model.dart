class CelebrityProfile {
  List<String>? alsoKnownAs;
  String? biography;
  DateTime birthday;
  dynamic deathday;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;
  String? profilePath;

  CelebrityProfile({
     this.alsoKnownAs,
     this.biography,
    required this.birthday,
    this.deathday,
     this.gender,
     this.id,
     this.knownForDepartment,
     this.name,
     this.placeOfBirth,
     this.profilePath,
  });

  factory CelebrityProfile.fromJson(Map<String, dynamic> json) => CelebrityProfile(
    alsoKnownAs: List<String>.from(json["also_known_as"].map((x) => x)),
    biography: json["biography"],
    birthday: DateTime.parse(json["birthday"]),
    deathday: json["deathday"]??null,
    gender: json["gender"],
    id: json["id"],
    knownForDepartment: json["known_for_department"]??null,
    name: json["name"],
    placeOfBirth: json["place_of_birth"]??null,
    profilePath: json["profile_path"]??null,
  );

}
