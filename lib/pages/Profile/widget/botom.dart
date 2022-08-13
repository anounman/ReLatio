import 'package:check_mate/controller/delete_account.dart';
import 'package:check_mate/helper/consts.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import 'package:velocity_x/velocity_x.dart';

bootmSheet(context) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
      builder: (context) {
        return Container(
          height: height(context) * 0.25,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  deleteAccount(userId);
                  setLogOut();
                  Restart.restartApp();
                },
                child: "Delete Account"
                    .text
                    .size(14)
                    .red600
                    .make()
                    .centered()
                    .pOnly(top: 10),
              ),
              const VxDivider(),
              GestureDetector(
                onTap: () async {},
                child: "Edit"
                    .text
                    .size(14)
                    .blue600
                    .make()
                    .centered()
                    .pOnly(top: 10),
              ),
            ],
          ).p(20),
        );
      });
}
