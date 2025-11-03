import 'dart:developer';

import 'package:major_project/network/network.dart';

class FirebaseOTP extends Network {
  Future<bool> sendOTP({required String phoneNumber}) async {
    try {
      bool isSent = false;
      await firebaseauth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (val) {},
          verificationFailed: (val) {
            log(val.toString());
          },
          codeSent: (val, int) {
            isSent = true;
          },
          codeAutoRetrievalTimeout: (val) {});
      return isSent;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
