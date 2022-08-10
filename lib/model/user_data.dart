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
    required this.likes,
    required this.dist,
    required this.age,
    required this.home,
    required this.iterestedGender,
  });

  String id;
  String name;
  String email;
  String gender;
  String iterestedGender;
  String age;
  Home home;
  Dist dist;

  List<List<String>> hobbies;
  List<String> pictures;
  List<String> likes;
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        age: json["age"],
        gender: json["gender"],
        dist: Dist.fromJson(json["dist"]),
        home: Home.fromJson(json['home']),
        iterestedGender: json["iterestedGender"] ?? "",
        hobbies: List<List<String>>.from(
            json["hobbies"].map((x) => List<String>.from(x.map((x) => x)))),
        pictures: List<String>.from(json["pictures"].map((x) => x)),
        likes: List<String>.from(json["likes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "age": age,
        "gender": gender,
        "dist": dist.toJson(),
        "home": home.toJson(),
        "iterestedGender": iterestedGender,
        "hobbies": List<dynamic>.from(
            hobbies.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "pictures": List<dynamic>.from(pictures.map((x) => x)),
        "likes": List<dynamic>.from(likes.map((e) => e)),
      };
}

class Dist {
  Dist({
    required this.calculated,
  });

  double calculated;

  factory Dist.fromJson(Map<String, dynamic> json) => Dist(
        calculated: json["calculated"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "calculated": calculated,
      };
}

class Home {
  Home({
    required this.latlong,
  });

  List<dynamic> latlong;

  factory Home.fromJson(Map<String, dynamic> json) => Home(
        latlong: List<dynamic>.from(json["latlong"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "latlong": List<dynamic>.from(latlong.map((x) => x)),
      };
}
