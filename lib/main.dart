import 'dart:core';

import 'package:check_mate/firebase_options.dart';
import 'package:check_mate/page_selector.dart';
import 'package:check_mate/pages/notificationservice/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint(message.data.toString());
  debugPrint(message.notification!.title);
}

Future<void> onBackgroundMessage(RemoteMessage message) async {
  debugPrint("Notification Initilized");

  // // userToken = await generateToken(id);
  // debugPrint(userToken);
  debugPrint("Conneted hahaha");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  MobileAds.instance.initialize();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, snapshot) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const PageSelector(),
      );
    });
  }
}
