import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/utils/apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<String> uploadedImageUrl = [];

Future uploadFile(file) async {
  debugPrint(file.path.toString());
  final uri = Uri.parse(Api.uploadImage);
  var requests = http.MultipartRequest('POST', uri);
  requests.files
      .add(await http.MultipartFile.fromPath('photo', file.path.toString()));
  var responce = await requests.send();
  if (responce.statusCode == 200) {
    var data = await http.Response.fromStream(responce);
    uploadedImageUrl.add(data.body);
    upDateApp();
  }
}
