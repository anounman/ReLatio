import 'package:check_mate/helper/consts.dart';
import 'package:check_mate/helper/data_fetch.dart';
import 'package:check_mate/pages/register/upload_photo/photo_widget.dart';
import 'package:check_mate/utils/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../questions_hobbies/hobbies/hobbies.dart';

class PhotoUploadPage extends StatefulWidget {
  const PhotoUploadPage({Key? key}) : super(key: key);

  @override
  State<PhotoUploadPage> createState() => _PhotoUploadPageState();
}

class _PhotoUploadPageState extends State<PhotoUploadPage> {
  bool isUploading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: (isUploading)
              ? Center(
                  child: Image.asset("assets/images/upload.gif"),
                )
              : SingleChildScrollView(
                  child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.arrow_back_ios)),
                    ),
                    "Add your photos"
                        .text
                        .size(24)
                        .bold
                        .wordSpacing(2)
                        .black
                        .make()
                        .centered()
                        .pOnly(top: 20.h),
                    "Your photos will be displayed on your profile"
                        .text
                        .justify
                        .center
                        .size(12.sp)
                        .make()
                        .pOnly(top: 20.h),
                    SizedBox(
                            height: height(context) * 0.57,
                            width: width(context),
                            child: const UploadBox())
                        .pOnly(top: 30.h),
                    GestureDetector(
                      onTap: () async {
                        isUploading = true;
                        setState(() {});
                        if (uploadedPhotoImageList.length < 3) {
                          showSnackbar("Please Select atleast 3 images");
                        } else {
                          for (var element in uploadedPhotoImageList) {
                            await uploadFile(element);
                          }
                          isUploading = false;
                          setState(() {});
                          userData["pictures"] = uploadedImageUrl;
                          upDateApp();
                          navigate(context: context, page: const Hobbies());
                        }
                      },
                      child: Container(
                        height: height(context) * 0.08,
                        width: width(context) * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: primaryColor.withOpacity(
                                uploadedPhotoImageList.length >= 3 ? 1 : 0.5)),
                        child: (uploadedPhotoImageList.length >= 3
                                ? "Upload"
                                : "Continue")
                            .text
                            .white
                            .bold
                            .size(20)
                            .make()
                            .centered(),
                      ).pOnly(top: 20.h),
                    )
                  ],
                ).p(30))),
    );
  }
}
