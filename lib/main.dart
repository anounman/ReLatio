import 'package:check_mate/app.dart';
import 'package:check_mate/page_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //StreamChatClient
  final client = StreamChatClient(
    streamKey,
    logLevel: Level.OFF,
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
