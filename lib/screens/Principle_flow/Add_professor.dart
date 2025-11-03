import 'package:flutter/material.dart';
import 'package:major_project/network/app_accounts.dart';
import 'package:major_project/widgets/constants.dart';

class AddProfessorPage extends StatefulWidget {
  @override
  _AddProfessorPageState createState() => _AddProfessorPageState();
}

class _AddProfessorPageState extends State<AddProfessorPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  void _submitForm() {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _departmentController.text.trim().isEmpty ||
        _roleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    final professorData = {
      "name": _nameController.text.trim(),
      "email": _emailController.text.trim(),
      "department": _departmentController.text.trim(),
      "role": _roleController.text.trim(),
    };
    AppAccount().addStaff(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: "",
        department: _departmentController.text.trim(),
        onSuccess: () {
          Navigator.pop(context);
        },
        role: _roleController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Professor"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: 340,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 340,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email ID"),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 340,
              child: DropdownMenu<String>(
                width: 340,
                inputDecorationTheme: InputDecorationTheme(
                  constraints: BoxConstraints(maxHeight: 50),
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Color(0xff2E81FF),
                        width: 1,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Color(0xff2E81FF),
                        width: 1,
                      )),
                ),
                label: Text("Department"),
                hintText: "Select Department",
                dropdownMenuEntries: const [
                  DropdownMenuEntry(
                      value: "Information Technology",
                      label: "Information Technology"),
                  DropdownMenuEntry(
                      value: "Computer Science", label: "Computer Science"),
                  DropdownMenuEntry(value: "Extc", label: "Extc"),
                  DropdownMenuEntry(value: "Mechanical", label: "Mechanical"),
                ],
                onSelected: (value) {
                  _departmentController.text = value!;
                },
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 340,
              child: DropdownMenu<String>(
                width: 340,
                inputDecorationTheme: InputDecorationTheme(
                  constraints: BoxConstraints(maxHeight: 50),
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Color(0xff2E81FF),
                        width: 1,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Color(0xff2E81FF),
                        width: 1,
                      )),
                ),
                label: Text("Role"),
                hintText: "Select Role",
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: "professor", label: "Professor"),
                  DropdownMenuEntry(value: "hod", label: "HOD"),
                  DropdownMenuEntry(value: "exam_cell", label: "Exam Cell"),
                ],
                onSelected: (value) {
                  _roleController.text = value!;
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 200),
            Button(
              buttonText: 'Submit',
              onTap: _submitForm,
              width: 340,
              height: 50,
              borderRadius: 25,
              fontSize: 18,
            )
          ],
        ),
      ),
    );
  }
}
