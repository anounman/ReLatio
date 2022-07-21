import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';

Widget button(
    Color color, CardController? controller, IconData iconData, bool right) {
  return InkWell(
      onTap: () {
        if (right) {
          controller!.triggerRight();
        } else {
          controller!.triggerLeft();
        }
      },
      child: Container(
        height: 50.h,
        width: 135.w,
        decoration: BoxDecoration(
            color: color.withOpacity(0.5),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Icon(
            iconData,
            color: color,
            size: 40.sp,
          ),
        ),
      ));
}
