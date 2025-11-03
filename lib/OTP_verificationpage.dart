// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:major_project/screens/Examcell_flow/Examcell_home.dart';
// import 'package:major_project/screens/HOD_flow/HOD_homepage.dart';
// import 'package:major_project/screens/Principle_flow/Principle_Homepage.dart';
// import 'package:major_project/screens/Professor_flow/Professor_homepage.dart';
// import 'package:major_project/screens/Student_flow/Student_homepage.dart';
// import 'package:major_project/widgets/constants.dart';

// class OTPVerificationPage extends StatefulWidget {
//   final String role;

//   const OTPVerificationPage({Key? key, required this.role}) : super(key: key);

//   @override
//   _OTPVerificationPageState createState() => _OTPVerificationPageState();
// }

// class _OTPVerificationPageState extends State<OTPVerificationPage> {
//   final List<TextEditingController> _controllers = List.generate(
//     6,
//     (index) => TextEditingController(text: (index + 1).toString()),
//   );
//   final List<FocusNode> _focusNodes = List.generate(
//     6,
//     (index) => FocusNode(),
//   );

//   @override
//   void dispose() {
//     _controllers.forEach((controller) => controller.dispose());
//     _focusNodes.forEach((node) => node.dispose());
//     super.dispose();
//   }

//   void _navigateToHomePage() async {
//     switch (widget.role.toLowerCase()) {
//       case 'principal':
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         );
//         await Future.delayed(Duration(seconds: 2));
//         Navigator.pop(context);
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PrincpalHomePage(),
//             ));
//         break;
//       case 'student':
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         );
//         await Future.delayed(Duration(seconds: 2));
//         Navigator.pop(context);
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => StudentHomePage(),
//             ));
//         break;
//       case 'faculty':
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         );
//         await Future.delayed(Duration(seconds: 2));
//         Navigator.pop(context);
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ProfessorHomePage(),
//             ));
//         break;
//       case 'hod':
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         );
//         await Future.delayed(Duration(seconds: 2));
//         Navigator.pop(context);
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => HODHomePage(),
//             ));
//         break;
//       case 'exam cell':
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         );
//         await Future.delayed(Duration(seconds: 2));
//         Navigator.pop(context);
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ExamcellHomePage(),
//             ));
//         break;
//       default:
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Invalid role')),
//         );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('OTP Verification'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(height: 120),
//             Text(
//               'Enter Verification Code',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 50),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(
//                 6,
//                 (index) => SizedBox(
//                   width: 50,
//                   child: TextField(
//                     controller: _controllers[index],
//                     focusNode: _focusNodes[index],
//                     textAlign: TextAlign.center,
//                     keyboardType: TextInputType.number,
//                     inputFormatters: [
//                       LengthLimitingTextInputFormatter(1),
//                       FilteringTextInputFormatter.digitsOnly,
//                     ],
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       counterText: '',
//                     ),
//                     onChanged: (value) {
//                       if (value.length == 1 && index < 5) {
//                         _focusNodes[index + 1].requestFocus();
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 80),
//             Button(
//               buttonText: 'Login',
//               onTap: () {
//                 String otp =
//                     _controllers.map((controller) => controller.text).join();
//                 // Add your verification logic here
//                 print('Entered OTP: $otp');
//                 _navigateToHomePage();
//               },
//               width: 200,
//               height: 50,
//               borderRadius: 25,
//               fontSize: 18,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
