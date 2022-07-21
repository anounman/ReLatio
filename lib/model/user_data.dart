import 'dart:convert';

List<UserModel> userFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.hobbies,
    required this.pictures,
  });

  String id;
  String name;
  String email;
  String gender;
  List<List<String>> hobbies;
  List<String> pictures;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        gender: json["gender"],
        hobbies: List<List<String>>.from(
            json["hobbies"].map((x) => List<String>.from(x.map((x) => x)))),
        pictures: List<String>.from(json["pictures"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "gender": gender,
        "hobbies": List<dynamic>.from(
            hobbies.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "pictures": List<dynamic>.from(pictures.map((x) => x)),
      };
}
