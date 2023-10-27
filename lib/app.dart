import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart' as log;
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

const streamKey = 'b9337xmtsnp7';
const secretKey =
    'fajnjd4t7jbnjycqsgduk92srbhn95pgg4rdervnr4d95pru92h6vjfg3bc75t8y';

var logger = log.Logger();

extension StreamChatContext on BuildContext {
  /// Fetches the current user image.
  String? get currentUserImage => currentUser!.image;

  /// Fetches the current user.
  User? get currentUser => StreamChatCore.of(this).currentUser;
}
