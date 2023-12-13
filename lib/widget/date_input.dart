import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../helper/consts.dart';

class DInput extends StatefulWidget {
  DInput({
    super.key,
    this.text = "",
    this.isNext = false,
    this.isPassword = false,
    this.isNumber = false,
    this.hintText = "",
    this.ishide = false,
    this.maxInput,
    this.sufix,
    this.color = const Color.fromRGBO(245, 245, 245, 1),
    this.prefix,
    required this.controller,
    this.isNumberLogin = false,
  });
  final String text;
  final bool isPassword;
  final bool isNumber;
  final bool isNumberLogin;
  final String hintText;
  final Widget? sufix;
  final Color? color;
  final bool ishide;
  final bool isNext;

  final Widget? prefix;
  int? maxInput;
  final TextEditingController controller;
  @override
  State<DInput> createState() => _DInputState();
}

class _DInputState extends State<DInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context) * 0.081,
      width: width(context) * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.color,
      ),
      child: Center(
        child: Column(
          children: [
            TextFormField(
              keyboardType:
                  (widget.isNumber) ? TextInputType.phone : TextInputType.name,
              autofocus: true,
              textInputAction: (widget.isNext) ? TextInputAction.next : null,
              onChanged: (value) {
                if (widget.maxInput != null) {
                  if (value.length == widget.maxInput) {
                    if (widget.isNext) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      FocusScope.of(context).unfocus();
                    }
                  }
                }
              },
              controller: widget.controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontSize: 17.sp,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: widget.color,
                isDense: true,
              ),
            ),
          ],
        ).p(5),
      ),
    );
  }
}
