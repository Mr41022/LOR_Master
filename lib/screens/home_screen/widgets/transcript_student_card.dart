import 'package:flutter/material.dart';
import 'package:major_project/network/profile_details.dart';
import 'package:major_project/network/transcript_request.dart';
import 'package:major_project/screens/Examcell_flow/form_details.dart';
import 'package:major_project/widgets/constants.dart';

class TranscriptStudentCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const TranscriptStudentCard({
    super.key,
    required this.onAccept,
    required this.onReject,
    required this.data,
  });

  @override
  State<TranscriptStudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<TranscriptStudentCard> {
  bool isloading = true;
  Map? profileData;
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  getData() async {
    profileData =
        await ProfileDetails().getProfileDetails(uid: widget.data['uid']);
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            // Professor details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 340,
                      height: 25,
                      child: Text(
                        profileData?['Name'] ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      profileData?['Student Id'] ?? "",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      profileData?['Email'] ?? "",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      profileData?['Department'] ?? "",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Action buttons
            Positioned(
                top: 15,
                right: 0,
                child: actionWidget(
                    isFormFilled: widget.data['is_form_filled'],
                    status: widget.data['status'],
                    transcriptId: widget.data['id'])),
          ],
        ),
      ),
    );
  }

  actionWidget(
      {required bool isFormFilled,
      required String status,
      required String transcriptId}) {
    if (isFormFilled) {
      switch (status) {
        case "approved":
          return Button(
              width: 150,
              height: 48,
              borderRadius: 30,
              fontSize: 16,
              buttonText: 'View For m Details',
              onTap: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormDetails(
                                transcriptId: widget.data['id'],
                              )));
                });
              });
        case "completed":
          return Text(
            "Completed    ",
            style: TextStyle(color: Color.fromARGB(224, 6, 179, 12)),
          );
      }
    } else {
      switch (status) {
        case "pending":
          return Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 18),
                onPressed: () {
                  TranscriptRequest().updateTranscriptRequest(
                      transcriptId: transcriptId, isApproved: false);
                },
                style: IconButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const CircleBorder(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.check, color: Colors.white, size: 18),
                onPressed: () {
                  TranscriptRequest().updateTranscriptRequest(
                      transcriptId: transcriptId, isApproved: true);
                },
                style: IconButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: const CircleBorder(),
                ),
              ),
            ],
          );
        case "rejected":
          return Text(
            "Rejected    ",
            style: TextStyle(color: Color.fromARGB(223, 227, 14, 14)),
          );
        case "approved":
          return Text(
            "Waiting for Student Response    ",
            style: TextStyle(color: Color.fromARGB(224, 6, 179, 12)),
          );
      }
    }
  }
}
