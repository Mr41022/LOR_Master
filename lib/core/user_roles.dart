import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserRoles {
  principal,
  student,
  professor, 
  examCell,
  hod,
}

StateProvider<UserRoles?> loggedInUserRole = StateProvider<UserRoles?>((ref) {
  return null;
});


setRole ({required String role, required WidgetRef ref}) {
  if (role == "principal") {
    ref.read(loggedInUserRole.notifier).state = UserRoles.principal;
  } else if (role == "student") {
    ref.read(loggedInUserRole.notifier).state = UserRoles.student;
  } else if (role == "professor") {
    ref.read(loggedInUserRole.notifier).state = UserRoles.professor;
  } else if (role == "hod") {
    ref.read(loggedInUserRole.notifier).state = UserRoles.hod;
  } else if (role == "examCell") {
    ref.read(loggedInUserRole.notifier).state = UserRoles.examCell;
  }
}



getRoleEnum ({required String role}) {
  if (role == "principal") {
    return UserRoles.principal;
  } else if (role == "student") {
    return UserRoles.student;
  } else if (role == "professor") {
    return UserRoles.professor;
  } else if (role == "hod") {
    return UserRoles.hod;
  } else if (role == "examCell") {
    return UserRoles.examCell;
  }
}