import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:major_project/network/network.dart';

class ProfileDetails extends Network {
  Future<Map> getProfileDetails({String? uid}) async {
    uid = uid ?? firebaseauth.currentUser!.uid;
    DocumentSnapshot userDetailsShapshot =
        await firebaseFirestore.collection('users').doc(uid).get();
    Map userDetails = userDetailsShapshot.data() as Map;
    Map data = {
      'Name': userDetails['name'],
      'Email': userDetails['email'],
      'Student Id': userDetails['student_id'],
      'Department': userDetails['department'],
    };
    return data;
  }
}
