import 'dart:convert';

import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/utils/apis.dart';
import 'package:http/http.dart' as http;

class UpdateLocation {
  updateLocation(id) async {
    String longitude = position!.longitude.toString();
    String latitude = position!.latitude.toString();
<<<<<<< HEAD
    final url = Uri.parse(
      "https://api-relation.vercel.app/updateLocation",
    );
=======
    final url = Uri.parse(Api.updateLocation);
>>>>>>> 62b38beeda1f0d7d623ad8a7c641554bf0c87ed8
    http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": authToken!
        },
        body: jsonEncode({
          "id": id,
          "coordinates": [longitude, latitude]
        }));
  }
}
