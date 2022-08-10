import 'dart:io';

import 'package:check_mate/helper/consts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class UploadBox extends StatefulWidget {
  const UploadBox({Key? key}) : super(key: key);

  @override
  State<UploadBox> createState() => _UploadBoxState();
}

List uploadedPhotoImageList = [];

class _UploadBoxState extends State<UploadBox> {
  bool isCliked = false;
  List<XFile>? pickedFile;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.7,
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 3),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () async {
                pickedFile =
                    await ImagePicker().pickMultiImage(imageQuality: 70);
                if (pickedFile != null) {
                  if (uploadedPhotoImageList.length > index) {
                    uploadedPhotoImageList.removeAt(index);
                  }
                  for (var image in pickedFile!) {
                    uploadedPhotoImageList.insert(index, image);
                  }
                }
                setState(() {});
                upDateApp();
              },
              child: Stack(
                children: [
                  ImageBox(
                          image: (uploadedPhotoImageList.length < index + 1)
                              ? null
                              : uploadedPhotoImageList[index])
                      .p(7),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        if (uploadedPhotoImageList.length > index) {
                          uploadedPhotoImageList.removeAt(index);
                        }
                        setState(() {});
                        upDateApp();
                      },
                      child: CircleAvatar(
                        radius: (uploadedPhotoImageList.length < index + 1)
                            ? 0
                            : 15,
                        child: Icon(
                          Icons.close,
                          size: (uploadedPhotoImageList.length < index + 1)
                              ? 0
                              : null,
                        ),
                      ),
                    ),
                  )
                ],
              ));
        });
  }
}

class ImageBox extends StatelessWidget {
  const ImageBox({Key? key, required this.image}) : super(key: key);
  final XFile? image;
  @override
  Widget build(BuildContext context) {
    debugPrint("Image:${image.toString()}");
    return Container(
      decoration: BoxDecoration(
          image: (image != null)
              ? DecorationImage(
                  image: FileImage(File(image!.path)),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high)
              : null,
          borderRadius: BorderRadius.circular(20),
          color: primaryColor.withOpacity(0.1)),
      child: (image == null)
          ? Center(
              child: Icon(
                Icons.add,
                size: 50,
                color: primaryColor,
              ),
            )
          : null,
    );
  }
}
