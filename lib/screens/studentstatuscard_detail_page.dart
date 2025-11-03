import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_project/network/registration_requests.dart';
import 'package:major_project/widgets/constants.dart';

class StudentCardDetailsPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const StudentCardDetailsPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<StudentCardDetailsPage> createState() => _StudentCardDetailsPageState();
}

class _StudentCardDetailsPageState extends State<StudentCardDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Request Details',
          style: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(widget.data["doc_url"]),
              ),
              SizedBox(height: 20),
              ProfileInfoTile(title: 'Name', value: widget.data['name']),
              ProfileInfoTile(title: 'Email', value: widget.data['email']),
              ProfileInfoTile(
                  title: 'Phone Number', value: widget.data['phone']),
              ProfileInfoTile(
                  title: 'Department', value: widget.data['department']),
              ProfileInfoTile(
                  title: 'Student Id', value: widget.data['student_id']),
              ProfileInfoTile(
                  title: 'Uploaded Student id', value: widget.data['doc_url']),
              SizedBox(height: 8),
              Button(
                  buttonText: 'Accept Request',
                  onTap: () {
                    setState(() {
                      RegistrationRequests().acceptRegistrationRequest(
                        data: widget.data,
                      );
                      // Add logic to remove this card from the list
                    });
                  },
                  width: 340,
                  height: 50,
                  borderRadius: 25,
                  fontSize: 16),
              SizedBox(height: 14),
              Button(
                  buttonText: 'Reject Request',
                  onTap: () {
                    setState(() {
                      if (mounted) {
                        RegistrationRequests().rejectRequest(data: widget.data);
                      }
                      // Add logic to remove this card from the list
                    });
                  },
                  width: 340,
                  height: 50,
                  borderRadius: 25,
                  fontSize: 16),
            ],
          ),
        ),
      ),
    );
  }
}
