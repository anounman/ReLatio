import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart' as log;
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

const streamKey = 'zau2vjt9zfg4';
const secretKey =
    'nw5fmprwycmyd4burwgcvxkedrdg7fpmwzkg287fmfwu5ucsqa3jx69t9sbcxdk5';

var logger = log.Logger();

extension StreamChatContext on BuildContext {
  /// Fetches the current user image.
  String? get currentUserImage => currentUser!.image;

  /// Fetches the current user.
  User? get currentUser => StreamChatCore.of(this).currentUser;
}
