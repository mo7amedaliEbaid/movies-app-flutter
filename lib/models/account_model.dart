class AcountModel {
  int? id;
  String? name;
  String? username;

  AcountModel({
     this.id,
     this.name,
     this.username,
  });
  factory AcountModel.fromJson(Map<String, dynamic> json) => AcountModel(
    id: json["id"],
    name: json["name"],
    username: json["username"],
  );

}

