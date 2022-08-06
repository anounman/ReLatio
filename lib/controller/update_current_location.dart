import 'dart:convert';
import 'package:check_mate/helper/consts.dart';
import 'package:http/http.dart' as http;

class UpdateLocation {
  updateLocation(id) async {
    String longitude = position!.longitude.toString();
    String latitude = position!.latitude.toString();
    final url = Uri.parse("https://re-lation.herokuapp.com/updateLocation");
    final responce = http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id" : id,
          "currentAddress" : {
            "type" : "Point",
            "coordinates" : [longitude , latitude]
      }
      }));
  }
}
