import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_project/network/profile_details.dart';
import 'package:major_project/network/transcript_request.dart';
import 'package:major_project/screens/Student_flow/Student_homepage.dart';
import 'package:major_project/widgets/constants.dart';

class CreateTranscriptRequest extends StatefulWidget {
  const CreateTranscriptRequest({super.key});

  @override
  State<CreateTranscriptRequest> createState() =>
      _CreateTranscriptRequestState();
}

class _CreateTranscriptRequestState extends State<CreateTranscriptRequest> {
  Map? studentData;
  bool isLoading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    studentData = await ProfileDetails().getProfileDetails();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Transcript Request',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: GoogleFonts.inter().fontFamily,
              color: Color(0xFF231E3C)),
        ),
      ),
      body: isLoading
          ? CircularProgressIndicator()
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  ...studentData!.entries.map(
                    (entry) => Column(
                      children: [
                        Text(
                          '${entry.key} -',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${entry.value}",
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'Your details will be sent to the Examcell for verification, and if accepted you will be able to fill Transcript Request Form',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Spacer(),
                  Button(
                      width: 340,
                      height: 60,
                      borderRadius: 30,
                      fontSize: 18,
                      buttonText: 'Submit',
                      onTap: () {
                        TranscriptRequest().createTranscriptRequest(
                            onSucess: () {
                          openDialog(context);
                        });
                      }),
                  SizedBox(
                    height: 30,
                  )
                ],
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
          title: Text(
            'Success',
            textAlign: TextAlign.center,
          ),
          content: Text('Request Sent Successfully'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'))
          ],
        );
      });
}
