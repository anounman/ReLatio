// To parse this JSON data, do
//
//     final AccountData = userDataFromJson(jsonString);

import 'dart:convert';

AccountData userDataFromJson(String str) =>
    AccountData.fromJson(json.decode(str));

String userDataToJson(AccountData data) => json.encode(data.toJson());

class AccountData {
  AccountData({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.iterestedGender,
    required this.hobbies,
    required this.pictures,
    required this.likes,
  });

  String id;
  String name;
  String email;
  String age;
  String gender;
  String iterestedGender;
  List<List<String>> hobbies;
  List<String> pictures;
  List<String> likes;

  factory AccountData.fromJson(Map<String, dynamic> json) => AccountData(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        age: json["age"],
        gender: json["gender"],
        iterestedGender: json["iterestedGender"],
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
        "iterestedGender": iterestedGender,
        "hobbies": List<dynamic>.from(
            hobbies.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "pictures": List<dynamic>.from(pictures.map((x) => x)),
        "likes": List<dynamic>.from(likes.map((e) => e)),
      };
}
