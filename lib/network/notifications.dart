import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:major_project/network/network.dart';

class Notification extends Network {
  sendNotificationToUser({required String uid,required String title, required String subtitle}) async{
    QuerySnapshot querySnapshot = await firebaseFirestore.collection("users").doc(uid).collection("fcmTokens").get();
    List fcmTokens = querySnapshot.docs.map((doc) {
      Map data = doc.data() as Map<String, dynamic>;
      return data['token'];
    }).toList();
  }
}
