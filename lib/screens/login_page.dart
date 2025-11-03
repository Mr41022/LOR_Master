import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:major_project/OTP_verificationpage.dart';
import 'package:major_project/core/user_roles.dart';
import 'package:major_project/network/auth.dart';
import 'package:major_project/network/firebase_otp.dart';
import 'package:major_project/screens/home_screen/home_screen.dart';
import 'package:major_project/widgets/constants.dart';
import 'package:major_project/screens/sign_up.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  String? selectedRole;

  _updateRole(String role) {
    setState(() {
      selectedRole = role;
    });
    print('Selected role: $role');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoWidget(),
            SizedBox(
              height: 45,
            ),
            SizedBox(height: 40),
            GestureDetector(
                onTap: () {
                  Auth().googleAuth(onSuccess: () async {
                    UserRoles role = await Auth().getRole();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(role: role),
                      ),
                    );
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue[700],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          height: 50,
                          width: 50,
                        ),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                )),
            SizedBox(height: 100),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Don\'t have an account as a student?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(
                      color: Colors.blue,
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('Sign up clicked');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Signup(),
                            ));
                      }),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
