import 'dart:convert';

import 'package:check_mate/controller/get_geolocation.dart';
import 'package:http/http.dart' as http;

class UpdateLocation {
  updateLocation(id) {
    String longitude = LocationController().position!.longitude.toString();
    String latitude = LocationController().position!.latitude.toString();
    final url = Uri.parse("https://re-lation.herokuapp.com/updateLocation");
    final responce = http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": id,
          "currentAddress": [longitude, latitude]
        }));
    
  }
}
