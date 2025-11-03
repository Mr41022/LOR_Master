import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:major_project/core/user_roles.dart';
import 'package:major_project/network/auth.dart';
import 'package:major_project/screens/home_screen/home_screen.dart';
import 'package:major_project/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  double _size = 200;

  getDeviceId() async {
    final deviceId = await FirebaseMessaging.instance.getToken();
    log(deviceId.toString());
    print(deviceId);
    return deviceId;
  }

  navigaton() async {
    try {
      bool isLoggedIn = false;
      await Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _size = MediaQuery.sizeOf(context).height;
        });
      });

      final tasks = await Future.wait([
        Future.delayed(
          Duration(seconds: 3),
        ),
        checkLogin()
      ]);
      isLoggedIn = tasks[1];

      if (!isLoggedIn) {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Loginpage(),
            ),
          );
        }
      } else {
        UserRoles role = await Auth().getRole();
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      role: role,
                    )),
          );
        }
      }
    } catch (e) {
      log(e.toString());
      Auth().logout(onSuccess: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Loginpage(),
          ),
        );
      });
    }
  }

  Future<bool> checkLogin() async {
    try {
      User? currentUser = await FirebaseAuth.instance.currentUser;
      print(currentUser!.email.toString());
      if (currentUser == null) {
        return false;
      }
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (await prefs.getString("userRole") != null) {
        return true;
      }

      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.uid)
          .get();
      if (doc.exists) {
        await prefs.setString("userRole", doc.data()!["role"]);
        setRole(role: doc.data()!["role"], ref: ref);
        // ref.read(loggedInUserRole.notifier).state = ;
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    getDeviceId();
    navigaton();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 126, 139, 205),
      body: Center(
        child: UnconstrainedBox(
          child: AnimatedContainer(
            duration: Duration(seconds: 2),
            height: _size,
            width: _size,
            decoration: BoxDecoration(
              color: Color(0xFFD6DADB),
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              height: 200,
              width: 200,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.asset(
                    'assets/images/logo.jpg',
                    fit: BoxFit.fill,
                    height: 200,
                    width: 200,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
