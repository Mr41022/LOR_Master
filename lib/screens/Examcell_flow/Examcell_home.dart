import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_project/widgets/constants.dart';

class ExamcellHomePage extends StatefulWidget {
  const ExamcellHomePage({super.key});

  @override
  State<ExamcellHomePage> createState() => ExamcellHomePageState();
}

class ExamcellHomePageState extends State<ExamcellHomePage> {
  final int notificationCount = 0;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    try {
      switch (_index) {
        case 0:
          child = Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Home',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      color: Color(0xFF231E3C)),
                ),
                actions: [
                  profileAndNotifcation(notificationCount: notificationCount),
                ],
              ),
              drawer: const principalDrawer(),
              body: ExamcellRequestAndHome(
                requestText: 'All Transcript Requests',
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
              body: ExamcellRequestAndHome(
                requestText: 'Pending Transcript Requests',
                isHistory: true,
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
    } catch (e, stackTrace) {
      child = Scaffold(
        body: Center(
          child: Text('An error occurred: $e'),
        ),
      );
    }
    return child;
  }

  Widget _bottomTab() {
    try {
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
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'History'),
          ],
        ),
      );
    } catch (e, stackTrace) {
      print('Error in _bottomTab: $e');
      print('Stack trace: $stackTrace');
      return Container();
    }
  }
}
