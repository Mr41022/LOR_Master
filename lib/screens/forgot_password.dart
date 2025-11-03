import 'package:flutter/material.dart';
import 'package:major_project/widgets/constants.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              LogoWidget(),
              SizedBox(
                height: 80,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: RichText(
                  text: TextSpan(
                      text: 'Forgot Password\n',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: const <TextSpan>[
                        TextSpan(
                            text:
                                'Reset Password Link will be sent\n to your Registerd Email ID',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                                color: Colors.black54)),
                      ]),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              AuthTextField(
                horizontalPadding: 15,
                verticalPadding: 15,
                borderRadius: 30,
                boxHeight: 80,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 20,
              ),
              Button(
                width: 300,
                height: 50,
                borderRadius: 25,
                fontSize: 18,
                buttonText: 'Send Link',
                onTap: () {
                  openDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future openDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content:
              Text('An email has been sent to your registered email address'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'))
          ],
        );
      });
}
