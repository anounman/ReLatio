import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart' as log;
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

const streamKey = '3tna95ygftpj';
const secretKey =
    'n2mcne2dgebesty7yfycrrw993kjpk4x29ypawqa9bxswbdbswhy39day4fgs46r';

var logger = log.Logger();

extension StreamChatContext on BuildContext {
  /// Fetches the current user image.
  String? get currentUserImage => currentUser!.image;

  /// Fetches the current user.
  User? get currentUser => StreamChatCore.of(this).currentUser;
}
