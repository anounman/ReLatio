import 'package:check_mate/app.dart';
import 'package:check_mate/page_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:workmanager/workmanager.dart';

void  callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // await backgroundFetch();
    // final client = StreamChatClient(
    //   streamKey,
    //   logLevel: Level.INFO,
    // );
    // final prefs = await SharedPreferences.getInstance();
    // final id = prefs.getString("userID");
    // final name = prefs.getString("name");

    // await client.connectUser(
    //   User(id: id.toString(), name: name, extraData: {
    //     'name': name,
    //   }),
    //   client.devToken(id.toString()).rawValue,
    // );

    // debugPrint("BACKGROUND ID OF CURRENT USER:${client.state.currentUser!.id}");

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //run background task
  await Workmanager().initialize(callbackDispatcher,
      isInDebugMode:
          true); //to true if still in testing lev turn it to false whenever you are launching the app
  await Workmanager().registerPeriodicTask("5", 'simplePeriodicTask',
      existingWorkPolicy: ExistingWorkPolicy.replace,
      frequency: const Duration(minutes: 15), //when should it check the link
      initialDelay:
          const Duration(seconds: 5), //duration before showing the notification
      constraints: Constraints(
        networkType: NetworkType.connected,
      ));
  //StreamChatClient

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
