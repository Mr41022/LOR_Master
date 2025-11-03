import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:major_project/network/app_accounts.dart';
import 'package:major_project/widgets/constants.dart';
import 'package:major_project/widgets/registration_form/doc_display.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? selectedRole;

  _updateRole(String role) {
    setState(() {
      selectedRole = role;
    });
  }

  String department = '';

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final studentIdController = TextEditingController();

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        doc = pickedFile;
      });
    }
  }

  XFile? doc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              centerTitle: true,
              title: Text(
                "Hello, Welcome",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 26,
            ),
            AuthTextField(
              horizontalPadding: 30,
              controller: nameController,
              verticalPadding: 10,
              borderRadius: 25,
              boxHeight: 50,
              labelText: 'Name',
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 8,
            ),
            AuthTextField(
              controller: emailController,
              horizontalPadding: 30,
              verticalPadding: 10,
              borderRadius: 25,
              boxHeight: 50,
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 8,
            ),
            NormalDropdownExample(
                horizontalPadding: 30,
                verticalPadding: 10,
                borderRadius: 25,
                boxHeight: 50,
                dropDownText: 'Department',
                dropDownList: [
                  'Information Technology',
                  'Computer Science',
                  'Extc',
                  'Mechanical'
                ],
                onChanged: (val) {
                  department = val;
                }),
            SizedBox(
              height: 8,
            ),
            AuthTextField(
              controller: phoneNumberController,
              horizontalPadding: 30,
              verticalPadding: 10,
              borderRadius: 25,
              boxHeight: 50,
              labelText: 'Phone Nuber',
              obscureText: true,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 8,
            ),
            AuthTextField(
              controller: studentIdController,
              horizontalPadding: 30,
              verticalPadding: 10,
              borderRadius: 25,
              boxHeight: 50,
              labelText: 'Student Id',
              obscureText: true,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 8,
            ),
            doc == null
                ? UploadPdf(
                    onTap: () {
                      _pickImage();
                    },
                    pdftext: 'Upload Student Id',
                  )
                : DocDisplay(
                    doc: File(doc!.path),
                    onTap: () {
                      setState(() {
                        doc = null;
                      });
                    },
                  ),
            SizedBox(
              height: 50,
            ),
            Button(
              width: 300,
              height: 50,
              borderRadius: 25,
              fontSize: 18,
              buttonText: 'REGISTER',
              onTap: () {
                print(nameController.text);
                print(department);
                print(emailController.text);
                print(phoneNumberController.text);
                print(studentIdController.text);
                if (doc != null) {
                  AppAccount().accountCreationRequest(
                      name: nameController.text,
                      email: emailController.text,
                      department: department,
                      phoneNumber: phoneNumberController.text,
                      studentId: studentIdController.text,
                      onSuccess: () {
                        openDialog(context);
                        nameController.clear();
                        emailController.clear();
                        phoneNumberController.clear();
                        studentIdController.clear();
                        doc = null;
                        department = '';
                        setState(() {});
                      },
                      doc: doc!);
                } else {
                  Fluttertoast.showToast(msg: "Upload Image of ID Card.");
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}

Future openDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Success',
            textAlign: TextAlign.center,
          ),
          content: Text(
              'You Details have been submitted for verification, Once Approve your account will be created'),
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
