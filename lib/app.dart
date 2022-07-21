import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart' as log;
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

const streamKey = '9bgnjm2b8v3p';

var logger = log.Logger();

extension StreamChatContext on BuildContext {
  /// Fetches the current user image.
  String? get currentUserImage => currentUser!.image;

  /// Fetches the current user.
  User? get currentUser => StreamChatCore.of(this).currentUser;
}
