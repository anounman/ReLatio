import 'dart:convert';

List<ApiFormData> apiFormDataFromJson(String str) => List<ApiFormData>.from(
    json.decode(str).map((x) => ApiFormData.fromJson(x)));

String apiFormDataToJson(List<ApiFormData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiFormData {
  ApiFormData({
    required this.questions,
    required this.hobbies,
  });

  List<Question> questions;
  List<Hobby> hobbies;

  factory ApiFormData.fromJson(Map<String, dynamic> json) => ApiFormData(
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
        hobbies:
            List<Hobby>.from(json["hobbies"].map((x) => Hobby.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "hobbies": List<dynamic>.from(hobbies.map((x) => x.toJson())),
      };
}

class Hobby {
  Hobby({
    required this.id,
    required this.hobbie,
  });

  int id;
  String hobbie;

  factory Hobby.fromJson(Map<String, dynamic> json) => Hobby(
        id: json["_id"],
        hobbie: json["hobbie"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "hobbie": hobbie,
      };
}

class Question {
  Question({
    required this.id,
    required this.question,
    required this.options,
  });

  int id;
  String question;
  List<Option> options;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["_id"],
        question: json["question"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "question": question,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

class Option {
  Option({
    required this.id,
    required this.option,
  });

  int id;
  String option;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["_id"],
        option: json["option"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "option": option,
      };
}
