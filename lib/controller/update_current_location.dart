import 'dart:convert';
import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/utils/apis.dart';
import 'package:http/http.dart' as http;

class UpdateLocation {
  updateLocation(id) async {
    String longitude = position!.longitude.toString();
    String latitude = position!.latitude.toString();
    final url = Uri.parse(Api.updateLocation);
    http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": id,
          "coordinates": [longitude, latitude]
        }));
  }
}
