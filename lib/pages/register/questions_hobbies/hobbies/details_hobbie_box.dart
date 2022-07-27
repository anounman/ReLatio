import 'package:check_mate/helper/consts.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget detailsHobbieCard({required String hoobie, bool isClicked = false}) {
  return Chip(
      backgroundColor: isClicked ? primaryColor : primaryColor.withOpacity(0.5),
      label: hoobie.toString().text.size(15).white.bold.make());
}
