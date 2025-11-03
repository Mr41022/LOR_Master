import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_project/network/send_lor_request.dart';
import 'package:major_project/widgets/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfessorStudentStatusCardDetailsPage extends StatefulWidget {
  final String studentName;
  final String phoneNumber;
  final String email;
  final String department;
  final String universityName;
  final String lastDate;
  final bool formStatus;
  final String lorRequestId;
  final String? fileUrl;

  const ProfessorStudentStatusCardDetailsPage({
    Key? key,
    required this.studentName,
    required this.phoneNumber,
    required this.email,
    required this.department,
    required this.universityName,
    required this.lastDate,
    required this.formStatus,
    required this.lorRequestId,
    this.fileUrl,
  }) : super(key: key);

  @override
  State<ProfessorStudentStatusCardDetailsPage> createState() =>
      _ProfessorStudentStatusCardDetailsPageState();
}

class _ProfessorStudentStatusCardDetailsPageState
    extends State<ProfessorStudentStatusCardDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Details',
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
            Center(
              child: CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
            ),
            SizedBox(height: 20),
            ProfileInfoTile(title: 'Name', value: widget.studentName),
            ProfileInfoTile(title: 'Email', value: widget.email),
            if (widget.phoneNumber.isNotEmpty)
              ProfileInfoTile(title: 'Phone Number', value: widget.phoneNumber),
            ProfileInfoTile(title: 'Department', value: widget.department),
            if (widget.universityName.isNotEmpty)
              ProfileInfoTile(
                  title: 'University Name', value: widget.universityName),
            if (widget.universityName.isNotEmpty)
              Center(
                child: UploadPdf(
                    onTap: () {
                      LorRequests().uploadLOR(
                          docId: widget.lorRequestId,
                          studentEmail: widget.email);
                    },
                    pdftext: 'Upload LoR'),
              ),
            if (widget.fileUrl != null)
              Button(
                  buttonText: 'Download LoR',
                  onTap: () {
                    launchUrl(Uri.parse(widget.fileUrl!));
                  },
                  width: 340,
                  height: 50,
                  borderRadius: 25,
                  fontSize: 16)
          ],
        ),
      ),
    );
  }
}
