import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';
import '../helper/consts.dart';

class Input extends StatefulWidget {
  const Input({
    Key? key,
    this.text = "",
    this.isPassword = false,
    this.isNumber = false,
    this.hintText = "",
    this.ishide = false,
    this.sufix,
    this.color = const Color.fromRGBO(245, 245, 245, 1),
    this.prefix,
    required this.controller,
    this.isNumberLogin = false,
  }) : super(key: key);
  final String text;
  final bool isPassword;
  final bool isNumber;
  final bool isNumberLogin;
  final String hintText;
  final Widget? sufix;
  final Color? color;
  final bool ishide;
  final Widget? prefix;
  final TextEditingController controller;
  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context) * 0.081,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.color,
      ),
      child: Center(
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              inputFormatters: (widget.isNumber)
                  ? <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(
                          r'[0-9,\b]')), // <-- Use \b in your regex here so backspace works.
                    ]
                  : null,
              autofocus: true,
              controller: widget.controller,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontSize: 17.sp,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                prefixIcon: Visibility(
                  visible: (widget.isNumberLogin || widget.prefix != null),
                  child: (widget.prefix != null)
                      ? widget.prefix!
                      : SizedBox(
                          width: width(context) * 0.22,
                        ),
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
