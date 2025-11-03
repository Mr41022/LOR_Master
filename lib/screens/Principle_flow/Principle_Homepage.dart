import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_project/widgets/constants.dart';

class PrincpalHomePage extends StatefulWidget {
  const PrincpalHomePage({super.key});

  @override
  State<PrincpalHomePage> createState() => PrincpalHomePageState();
}

class PrincpalHomePageState extends State<PrincpalHomePage> {
  final int notificationCount = 0;
  int _index = 0;

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
            drawer: const principalDrawer(),
            body: professorRequestAndHome(
              requestText: 'Status',
              isHistory: false,
            ),
            bottomNavigationBar: _bottomTab());
        break;

      case 1:
        child = Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Requests',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    color: Color(0xFF231E3C)),
              ),
            ),
            body: professorRequestAndHome(
              requestText: 'Pending Requests',
              isHistory: false,
            ),
            bottomNavigationBar: _bottomTab());
        break;

      case 2:
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
            body: ExamcellHistory(requestText: 'Batch'),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions_rounded),
            label: 'Pending',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}
