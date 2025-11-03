import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_project/network/transcript_forms.dart';
import 'package:major_project/screens/Student_flow/Student_homepage.dart';
import 'package:major_project/widgets/constants.dart';

class TranscriptForm extends StatefulWidget {
  const TranscriptForm({super.key, required this.transcriptId});
  final String transcriptId;

  @override
  State<TranscriptForm> createState() => _TranscriptFormState();
}

class _TranscriptFormState extends State<TranscriptForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController passoutYearController = TextEditingController();
  final TextEditingController syllabusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Transcript Request Form',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: GoogleFonts.inter().fontFamily,
              color: Color(0xFF231E3C)),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            AuthTextField(
              controller: nameController,
              horizontalPadding: 15,
              verticalPadding: 15,
              borderRadius: 30,
              boxHeight: 80,
              labelText: 'Name',
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 15,
            ),
            AuthTextField(
              controller: studentIdController,
              horizontalPadding: 15,
              verticalPadding: 15,
              borderRadius: 30,
              boxHeight: 80,
              labelText: 'Student ID',
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 15,
            ),
            AuthTextField(
              controller: ageController,
              horizontalPadding: 15,
              verticalPadding: 15,
              borderRadius: 30,
              boxHeight: 80,
              labelText: 'age',
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 15,
            ),
            AuthTextField(
              controller: passoutYearController,
              horizontalPadding: 15,
              verticalPadding: 15,
              borderRadius: 30,
              boxHeight: 80,
              labelText: 'Passout Year',
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 15,
            ),
            AuthTextField(
              controller: syllabusController,
              horizontalPadding: 15,
              verticalPadding: 15,
              borderRadius: 30,
              boxHeight: 80,
              labelText: 'Syllabus',
              hintText: '2019 - 2022',
              keyboardType: TextInputType.numberWithOptions(),
            ),
            SizedBox(
              height: 150,
            ),
            Button(
                width: 340,
                height: 60,
                borderRadius: 30,
                fontSize: 18,
                buttonText: 'Send Form',
                onTap: () {
                  if (nameController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Name is required");
                    return;
                  }
                  if (studentIdController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "student Id is required");
                    return;
                  }
                  if (ageController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "age is required");
                    return;
                  }
                  if (passoutYearController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Passout Year is required");
                    return;
                  }
                  if (syllabusController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Syllabus is required");
                    return;
                  }
                  TranscriptForms().addTranscriptForm(
                      formData: {
                        "name": nameController.text,
                        "studentId": studentIdController.text,
                        "age": ageController.text,
                        "passoutYear": passoutYearController.text,
                        "syllabus": syllabusController.text
                      },
                      transcriptionId: widget.transcriptId,
                      onSucess: () {
                        Fluttertoast.showToast(msg: "Form Sent Successfully");
                        Navigator.pop(context);
                      });
                })
          ],
        ),
      ),
    );
  }
}
