import 'package:check_mate/app.dart';
import 'package:check_mate/firebase_options.dart';
import 'package:check_mate/page_selector.dart';
import 'package:check_mate/pages/notificationservice/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_persistence/stream_chat_persistence.dart';

import 'helper/notification.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint(message.data.toString());
  debugPrint(message.notification!.title);
}

Future<void> onBackgroundMessage(RemoteMessage message) async {
  debugPrint("Notification Initilized");
  final client = StreamChatClient(
    streamKey,
    logLevel: Level.ALL,
  );
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString("userID");
  String name = prefs.getString("name")!;
  StreamChatClient? streamChatClient;
  if (streamChatClient == null) {
    // // userToken = await generateToken(id);
    String userToken = streamChatClient!.devToken(userId.toString()).rawValue;
    // debugPrint(userToken);
    debugPrint("Conneted hahaha");
    streamChatClient.connectUser(
      User(id: userId.toString(), name: name, extraData: {
        'name': name,
      }),
      userToken,
    );
  }
  final persistenceClient = StreamChatPersistenceClient();
  await persistenceClient.connect(userId!);
  // ignore: use_build_context_synchronously
  handleNotification(message, client);
}

void handleNotification(
  RemoteMessage message,
  StreamChatClient chatClient,
) async {
  final data = message.data;
  if (data['type'] == 'message.new') {
    final flutterLocalNotificationsPlugin = await setupLocalNotifications();
    final messageId = data['id'];
    final response = await chatClient.getMessage(messageId);
    flutterLocalNotificationsPlugin.show(
      1,
      'New message from ${response.message.user!.name} in ${response.channel!.name}',
      response.message.text,
      const NotificationDetails(
          android: AndroidNotificationDetails(
        'new_message',
        'New message notifications channel',
      )),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  MobileAds.instance.initialize();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  final client = StreamChatClient(
    streamKey,
    logLevel: Level.ALL,
  );
  runApp(MyApp(
    client: client,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.client}) : super(key: key);
  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, snapshot) {
      return MaterialApp(
        builder: (context, widget) {
          return StreamChat(
            client: client,
            child: widget,
          );
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const PageSelector(),
      );
    });
  }
}
