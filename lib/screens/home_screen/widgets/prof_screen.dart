import 'package:flutter/material.dart';
import 'package:major_project/widgets/constants.dart';

Widget principalHome({required bool isHistory}) {
  return ListView(
    children: [
      professorRequestAndHome(
        requestText: "Status",
        isHistory: isHistory,
      )
    ],
  );
}

// Widget principalReq() {
//   return ListView(
//     children: [
//       professorRequestAndHome(
//         requestText: "History",
//         isHistory: true,
//       )
//     ],
//   );
// }
