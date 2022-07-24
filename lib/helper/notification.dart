import 'package:check_mate/app.dart';
import 'package:check_mate/helper/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

backgroundFetch() async {
  debugPrint("It's run.......");
  final client = StreamChatClient(
    streamKey,
    logLevel: Level.INFO,
  );
  final prefs = await SharedPreferences.getInstance();
  final id = prefs.getString("userID");
  final name = prefs.getString("name");

  await client.connectUser(
    User(id: id.toString(), name: name, extraData: {
      'name': name,
    }),
    client.devToken(id.toString()).rawValue,
  );

  debugPrint("ID OF CURRENT USER:${client.state.currentUser!.id}");
  // client.eventStream.listen((event) async {
  // debugPrint("Message:${event.message!.id}");

  // debugPrint(event.toJson().toString());
  // final currentUserId = client.state.currentUser!.id;
  // // if (![
  // //       EventType.messageNew,
  // //       EventType.notificationMessageNew,
  // //     ].contains(event.type) ||
  // //     event.user!.id == currentUserId) {
  // //   return;
  // // }
  // // if (event.message == null) {
  // //   debugPrint("not working");
  // //   return;
  // // }
  // final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // const initializationSettingsAndroid =
  //     AndroidInitializationSettings('launch_background');
  // const initializationSettingsIOS = IOSInitializationSettings();
  // const initializationSettings = InitializationSettings(
  //   android: initializationSettingsAndroid,
  //   iOS: initializationSettingsIOS,
  // );
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // await flutterLocalNotificationsPlugin.show(
  //   event.totalUnreadCount.hashCode,
  //   (event.message != null) ? event.message!.user!.name : "New Massage",
  //   event.message == null
  //       ? "${event.totalUnreadCount.toString()} new messages"
  //       : event.message!.text,
  //   const NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       'message channel',
  //       'Message channel',
  //       priority: Priority.high,
  //       importance: Importance.high,
  //     ),
  //     iOS: IOSNotificationDetails(),
  //   ),
  // );
  // });
  StreamChat(
    client: client,
    backgroundKeepAlive: const Duration(days: 30),
    onBackgroundEventReceived: (event) async {
      debugPrint("Evevnt Come");
      final currentUserId = client.state.currentUser!.id;
      if (![
            EventType.messageNew,
            EventType.notificationMessageNew,
          ].contains(event.type) ||
          event.user!.id == currentUserId) {
        return;
      }
      if (event.message == null) {
        debugPrint("not working");
        return;
      }
      showSnackbar(event.totalUnreadCount.toString());
      debugPrint(event.totalUnreadCount.toString());
      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      const initializationSettingsAndroid =
          AndroidInitializationSettings('launch_background');
      const initializationSettingsIOS = IOSInitializationSettings();
      const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
      await flutterLocalNotificationsPlugin.show(
        event.message!.id.hashCode,
        event.message!.user!.name,
        event.message!.text,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'message channel',
            'Message channel',
            priority: Priority.high,
            importance: Importance.high,
          ),
          iOS: IOSNotificationDetails(),
        ),
      );
    },
    child: null,
  );
}
