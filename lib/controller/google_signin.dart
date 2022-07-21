import 'package:google_sign_in/google_sign_in.dart';

Future googlesignIn() async {
  return await GoogleSignInApi.login();
}

Future googleSignOut() async {
  return GoogleSignInApi.logout();
}

class GoogleSignInApi {
  static final _google = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() => _google.signIn();
  static Future logout() => _google.signOut();
}
