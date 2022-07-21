import 'package:check_mate/model/form_data.dart';
import 'package:check_mate/utils/formdata_service.dart';
import 'package:flutter/material.dart';

List<ApiFormData>? formdata;

Future getFormdata() async {
  formdata = await FormDataService().getFormData();
  debugPrint(formdata.toString());
}
