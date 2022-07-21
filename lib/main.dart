import 'package:check_mate/page_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //StreamChatClient
  final client = StreamChatClient(
    '9bgnjm2b8v3p',
    logLevel: Level.INFO,
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
          return StreamChatCore(
            client: client,
            child: ChannelsBloc(
              child: UsersBloc(
                child: widget!,
              ),
            ),
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
