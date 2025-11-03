import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_project/network/profile_details.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
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
        title: Text(
          'Student Profile',
          style: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? CircularProgressIndicator()
          : Padding(
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
                  ...studentData!.entries.map((entry) => Column(
                            children: [
                              ProfileInfoTile(
                                  title: '${entry.key} -',
                                  value: "${entry.value}"),
                            ],
                          )
                      // ProfileInfoTile(title: widget.keyName, value: widget.studentName),
                      // ProfileInfoTile(title: widget.keyId, value: widget.studentId),
                      // ProfileInfoTile(title: widget.keyEmail, value: widget.email),
                      // ProfileInfoTile(title: widget.keyDepartment, value: widget.department),
                      ),
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
