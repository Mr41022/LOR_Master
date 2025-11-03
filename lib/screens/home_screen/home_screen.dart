import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:major_project/core/user_roles.dart';
import 'package:major_project/screens/HOD_flow/HOD_homepage.dart';
import 'package:major_project/screens/Principle_flow/Add_professor.dart';
import 'package:major_project/screens/Student_flow/Create_LoR_Request.dart';
import 'package:major_project/screens/Student_flow/Student_homepage.dart';
import 'package:major_project/screens/home_screen/widgets/prof_screen.dart';
import 'package:major_project/screens/home_screen/widgets/student_drawer.dart';
import 'package:major_project/screens/home_screen/widgets/students_screen.dart';
import 'package:major_project/widgets/constants.dart';

StateProvider<int> bottomNavIndex = StateProvider<int>((ref) {
  return 0;
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.role});
  final UserRoles role;

  Widget _bottomTab(ref) {
    final index = ref.watch(bottomNavIndex);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: BottomNavigationBar(
        currentIndex: index,
        onTap: (int index) {
          ref.read(bottomNavIndex.notifier).state = index;
        },
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

  getDrawer() {
    switch (role) {
      case UserRoles.principal:
        return principalDrawer();
      case UserRoles.hod:
        return professorDrawer();
      case UserRoles.professor:
        return professorDrawer();
      case UserRoles.student:
        return studentDrawer();
      case UserRoles.examCell:
        return professorDrawer();
    }
  }

  bodyItem(ref) {
    switch (role) {
      case UserRoles.principal:
        switch (ref.watch(bottomNavIndex)) {
          case 0:
            return principalHome(isHistory: false);
          case 1:
            return principalHome(isHistory: true);
        }
      case UserRoles.student:
        switch (ref.watch(bottomNavIndex)) {
          case 0:
            return StudentHomePage(
              isHistory: false,
            );
          case 1:
            return Container();
            return StudentHomePage(
              isHistory: true,
            );
          case 2:
            return Container();
          default:
            return Container();
        }
      case UserRoles.hod:
        switch (ref.watch(bottomNavIndex)) {
          case 0:
            return professorRequestAndHome(
              showRegistration: role == UserRoles.hod,
              requestText: 'Status',
              isHistory: false,
            );
          case 1:
            return professorRequestAndHome(
              showRegistration: false,
              requestText: 'Status',
              isHistory: true,
            );
          default:
            return Container();
        }
      case UserRoles.examCell:
        switch (ref.watch(bottomNavIndex)) {
          case 0:
            return ExamcellRequestAndHome(
              requestText: 'All Transcript Requests',
              isHistory: false,
            );
          case 1:
            return ExamcellRequestAndHome(
              requestText: 'All Transcript Requests',
              isHistory: true,
            );
          default:
            return Container();
        }
      default:
        switch (ref.watch(bottomNavIndex)) {
          case 0:
            return SingleChildScrollView(
              child: professorRequestAndHome(
                requestText: 'Status',
                isHistory: false,
              ),
            );
          case 1:
            return SingleChildScrollView(
              child: professorRequestAndHome(
                requestText: 'Status',
                isHistory: true,
              ),
            );
          case 2:
            return Container();
          default:
            return Container();
        }
    }
  }

  getAppBarText(int page) {
    switch (page) {
      case 0:
        return 'Home';
      case 1:
        return 'History';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(role);
    print(ref.read(loggedInUserRole));
    int page = ref.watch(bottomNavIndex);

    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      bottomNavigationBar: role != UserRoles.student ? _bottomTab(ref) : null,
      drawer: getDrawer(),
      appBar: role == UserRoles.student
          ? null
          : AppBar(
              title: Text(getAppBarText(page)),
              actions: [
                if (role == UserRoles.principal)
                  profileAndNotifcation(notificationCount: 10),
              ],
            ),
      body: bodyItem(ref),
    );
  }
}
