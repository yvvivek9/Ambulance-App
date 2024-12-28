import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:user/utils/utils.dart';
import 'package:user/pages/home/page.dart';

class LoginController extends GetxController {
  Future<void> handleNormalLogin() async {
    Get.offAll(() => HomeScreen());
  }

  Future<void> handleGoogleLogin() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
      ],
    );

    // Get the user after successful sign in
    await googleSignIn.signIn();
    if (await googleSignIn.isSignedIn()) {
      Get.offAll(() => HomeScreen());
    } else {
      Fluttertoast.showToast(msg: "Unexpected error occurred");
    }
  }
}
