import 'package:check_mate/helper/consts.dart';
import 'package:flutter/cupertino.dart';

Future<void> createChannel(core, id) async {
  debugPrint("Printing....");
  debugPrint("ID:${core.currentUser!.id}");
  final channel = core.client.channel('messaging', extraData: {
    'members': [userId, id.toString()]
  });
  await channel.watch();
}
