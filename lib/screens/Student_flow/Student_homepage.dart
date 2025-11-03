import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_project/screens/Student_flow/Create_LoR_Request.dart';
import 'package:major_project/screens/Student_flow/Create_Transcript_Request.dart';
import 'package:major_project/screens/home_screen/widgets/student_drawer.dart';
import 'package:major_project/widgets/constants.dart';

class StudentHomePage extends StatefulWidget {
  final bool isHistory;
  const StudentHomePage({super.key, required this.isHistory});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final int notificationCount = 0;
  int _index = 0;
  int _selectedRequestType = 0;

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    switch (_index) {
      case 0:
        child = Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Home'),
              actions: [
                profileAndNotifcation(notificationCount: notificationCount),
              ],
            ),
            drawer: studentDrawer(),
            body: studentHistoryAndHome(
              requestText: 'Recent Request\'s',
              onRequestTypeChanged: (index) {
                setState(() {
                  _selectedRequestType = index;
                });
              }, isHistory: false,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (_selectedRequestType == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateLoRRequest(),
                    ),
                  );
                } else if (_selectedRequestType == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateTranscriptRequest(),
                    ),
                  );
                }
              },
              foregroundColor: Color.fromRGBO(126, 139, 205, 0.9),
              shape: CircleBorder(),
              child: Icon(Icons.add),
            ),
            bottomNavigationBar: _bottomTab());
        break;

      case 1:
        child = Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'History',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    color: Color(0xFF231E3C)),
              ),
            ),
            body: studentHistoryAndHome(
              requestText: 'All Request\'s',
              onRequestTypeChanged: (index) {
                setState(() {
                  _selectedRequestType = index;
                });
              }, isHistory: true,
            ),
            bottomNavigationBar: _bottomTab());
        break;
    }
    return child;
  }

  Widget _bottomTab() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: BottomNavigationBar(
        currentIndex: _index,
        onTap: (int index) => setState(() => _index = index),
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}
