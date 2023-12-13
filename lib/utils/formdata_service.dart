import 'package:check_mate/utils/apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/form_data.dart';

class FormDataService {
  Future<List<ApiFormData>?> getFormData() async {
    debugPrint("fuction called");
    final responce = await http.get(Uri.parse(Api.getFormData));
    debugPrint("Status Code:${responce.statusCode.toString()}");
    if (responce.statusCode == 200) {
      return apiFormDataFromJson(responce.body);
    }
    return null;
  }
}
