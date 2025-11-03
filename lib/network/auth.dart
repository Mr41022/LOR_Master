import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:major_project/core/user_roles.dart';
import 'package:major_project/network/network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends Network {
  Future<void> logout({required VoidCallback onSuccess}) async {
    removeTokenFromFirestore();
    await GoogleSignIn().signOut();
    await firebaseauth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    onSuccess();
  }

  Future<UserRoles> getRole() async {
    final userId = firebaseauth.currentUser!.uid;
    final userDoc =
        await firebaseFirestore.collection("users").doc(userId).get();
    return getRoleEnum(
      role: userDoc.data()!["role"],
    );
  }

  addTokenToFirestore() async {
    try {
      final userId = firebaseauth.currentUser?.uid;
      if (userId != null) {
        // === Get the token from the Firebase
        // Messaging instance based on the platform ===
        final token = Platform.isIOS
            ? await FirebaseMessaging.instance.getAPNSToken()
            : await FirebaseMessaging.instance.getToken();
        if (token != null) {
          // Check if the token already exists in Firestore
          final existingTokenQuery = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('fcmTokens')
              .where('token', isEqualTo: token)
              .get();

          // If no document exists with this token, add it
          if (existingTokenQuery.docs.isEmpty) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .collection('fcmTokens')
                .add({
              'token': token,
              'from_date': Timestamp.now(),
            });
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  removeTokenFromFirestore() async {
    final userId = firebaseauth.currentUser?.uid;
    if (userId != null) {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        // Query to find the token document
        final tokenQuery = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('fcmTokens')
            .where('token', isEqualTo: token)
            .get();

        // If the token is found, delete it
        if (tokenQuery.docs.isNotEmpty) {
          for (var doc in tokenQuery.docs) {
            doc.reference.delete();
          }
        }
      }
    }
  }

  Future<void> googleAuth({required VoidCallback onSuccess}) async {
    try {
      await GoogleSignIn().signOut();
      await firebaseauth.signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await firebaseauth.signInWithCredential(credential).then((value) async {
        final userId = firebaseauth.currentUser!.uid;
        final userDoc =
            await firebaseFirestore.collection("users").doc(userId).get();
        if (userDoc.exists) {
          onSuccess();
          addTokenToFirestore();
        } else if (!userDoc.exists) {
          final email = firebaseauth.currentUser!.email;
          final approvedDoc = await firebaseFirestore
              .collection("approvedRequests")
              .where("email", isEqualTo: email)
              .get();
          if (approvedDoc.docs.isNotEmpty) {
            Map<String, dynamic> data = approvedDoc.docs.first.data();
            data["created_at"] = Timestamp.now();
            await firebaseFirestore
                .collection("users")
                .doc(userId)
                .set(data)
                .then((value) {
              onSuccess();
              addTokenToFirestore();
            }).then((value) {
              firebaseFirestore
                  .collection("approvedRequests")
                  .doc(approvedDoc.docs.first.id)
                  .delete();
            });
          } else {
            firebaseauth.signOut();
            GoogleSignIn().signOut();
            Fluttertoast.showToast(
                msg: "Please Contact admin if you are member of DBIT.");
          }
        }
      });
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: "Error in google sign in");
    }
  }
}
