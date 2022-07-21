import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart' as log;
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

const streamKey = 'njr237gw534q';

var logger = log.Logger();

extension StreamChatContext on BuildContext {
  User? get curretUser => StreamChat.of(this).currentUser!;
}
