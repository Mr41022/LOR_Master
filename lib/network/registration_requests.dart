import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:major_project/network/network.dart';

class RegistrationRequests extends Network {
  Future<Stream<List<Map<String, dynamic>>>> getRegistrationRequests() async {
    DocumentSnapshot profileDetails = await firebaseFirestore
        .collection("users")
        .doc(firebaseauth.currentUser!.uid)
        .get();
    Map data = profileDetails.data() as Map;
    return firebaseFirestore
        .collection("registrationRequests")
        .where("department", isEqualTo: data["department"])
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  acceptRegistrationRequest({required Map<String, dynamic> data}) async {
    try {
      firebaseFirestore
          .collection("registrationRequests")
          .where("email", isEqualTo: data["email"])
          .get()
          .then((value) {
        value.docs.forEach((element) {
          element.reference.delete();
        });
      });
      data["approved_by"] = firebaseauth.currentUser!.uid;
      data["created_at"] = Timestamp.now();
      firebaseFirestore.collection("approvedRequests").add(data);
      Fluttertoast.showToast(msg: "Student has been Approved");
    } catch (e) {
      print(e);
    }
  }

  rejectRequest({required Map<String, dynamic> data}) async {
    try {
      firebaseFirestore
          .collection("registrationRequests")
          .where("email", isEqualTo: data["email"])
          .get()
          .then((value) {
        value.docs.forEach((element) {
          element.reference.delete();
        });
      });
      Fluttertoast.showToast(msg: "Request has been Rejected");
    } catch (e) {
      print(e);
    }
  }

  checkUser({required String key, required String value}) async {
    try {
      var val = await firebaseFirestore
          .collection("users")
          .where(key, isEqualTo: value)
          .get();
      if (val.docs.isNotEmpty) {
        Fluttertoast.showToast(msg: "User already exists");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return true;
    }
  }
}
