import 'package:flutter/material.dart';
import 'package:major_project/network/auth.dart';
import 'package:major_project/network/profile_details.dart';
import 'package:major_project/screens/Student_flow/Student_profile_page.dart';
import 'package:major_project/screens/login_page.dart';

class studentDrawer extends StatefulWidget {
  const studentDrawer({
    super.key,
  });

  @override
  State<studentDrawer> createState() => _studentDrawerState();
}

class _studentDrawerState extends State<studentDrawer> {
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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            onTap: () {
              isLoading
                  ? CircularProgressIndicator()
                  : Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                      return StudentProfilePage();
                    }));
            },
            child: UserAccountsDrawerHeader(
              accountName: Text("${studentData?.entries.first.value}",
                  style: TextStyle(color: Colors.white, fontSize: 30)),
              accountEmail: Text("${studentData?.entries.elementAt(1).value}",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Auth().logout(onSuccess: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Loginpage(),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
