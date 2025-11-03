import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_project/network/transcript_forms.dart';
import 'package:major_project/widgets/constants.dart';

class FormDetails extends StatefulWidget {
  final String transcriptId;

  const FormDetails({
    Key? key,
    required this.transcriptId,
  }) : super(key: key);

  @override
  State<FormDetails> createState() => _FormDetailsState();
}

class _FormDetailsState extends State<FormDetails> {
  bool isLoading = false;
  Map? formDetails;
  @override
  void initState() {
    getDetails();
    // TODO: implement initState
    super.initState();
  }

  getDetails() {
    TranscriptForms()
        .getTranscriptForms(transcriptId: widget.transcriptId)
        .then((value) {
      setState(() {
        formDetails = value;
        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transcript Form Details',
          style: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            ProfileInfoTile(title: 'Name', value: formDetails!['name'] ?? ""),
            ProfileInfoTile(
                title: 'Student ID', value: formDetails!['studentId'] ?? ""),
            ProfileInfoTile(title: 'age', value: formDetails!['age'] ?? ""),
            ProfileInfoTile(
                title: 'Passout Year',
                value: formDetails!['passoutYear'] ?? ""),
            ProfileInfoTile(
                title: 'syllabus', value: formDetails!['syllabus'] ?? ""),
            SizedBox(
              height: 20,
            ),
            Text(
              "   After Completion the student will collect the transcript from the exam cell  ",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Row(
              children: [
                SizedBox(width: 4),
                Button(
                    buttonText: 'Reject',
                    onTap: () {
                      TranscriptForms().updateTranscriptForm(
                          transcriptId: widget.transcriptId,
                          isFormFilled: false,
                          onSucess: () {
                            Navigator.pop(context);
                            Fluttertoast.showToast(msg: "Form Rejected");
                          });
                    },
                    width: 150,
                    height: 50,
                    borderRadius: 25,
                    fontSize: 20),
                SizedBox(width: 20),
                Button(
                    buttonText: 'Complete',
                    onTap: () {
                      TranscriptForms().updateTranscriptForm(
                          transcriptId: widget.transcriptId,
                          isFormFilled: true,
                          onSucess: () {
                            Navigator.pop(context);
                            Fluttertoast.showToast(msg: "Form Accepted");
                          });
                    },
                    width: 150,
                    height: 50,
                    borderRadius: 25,
                    fontSize: 20),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  final String title;
  final String value;

  const ProfileInfoTile({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
