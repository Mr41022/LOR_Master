import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:major_project/network/network.dart';
import 'package:major_project/network/registration_requests.dart';

class AppAccount extends Network {
  Future<void> deleteUser(String emailId) async {
    try {
      QuerySnapshot userQuery = await firebaseFirestore
          .collection("users")
          .where("email", isEqualTo: emailId)
          .get();

      if (userQuery.docs.isNotEmpty) {
        for (var doc in userQuery.docs) {
          await firebaseFirestore.collection("users").doc(doc.id).delete();
        }
      }
      QuerySnapshot duserQuery = await firebaseFirestore
          .collection("approvedRequests")
          .where("email", isEqualTo: emailId)
          .get();

      if (duserQuery.docs.isNotEmpty) {
        for (var doc in duserQuery.docs) {
          await firebaseFirestore
              .collection("approvedRequests")
              .doc(doc.id)
              .delete();
        }
      }
    } catch (e) {
      log("Error deleting user: $e");
    }
  }

  Future<void> addStaff(
      {required String name,
      required String email,
      required String phoneNumber,
      required String department,
      required VoidCallback onSuccess,
      required String role}) async {
    if (await RegistrationRequests().checkUser(key: "email", value: email)) {
      return;
    }
    print("$name $email $phoneNumber $department $role yo");
    firebaseFirestore.collection("approvedRequests").add({
      "name": name,
      "email": email,
      "phone": phoneNumber,
      "department": department,
      "role": role,
      "created_by": firebaseauth.currentUser!.uid,
      "created_at": Timestamp.now(),
    }).then((value) {
      onSuccess();
    });
  }

  Stream<List<Map<String, dynamic>>> getStaff() {
    return firebaseFirestore
        .collection("users")
        .where("role", isNotEqualTo: "student")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> getStaffRequests() {
    return firebaseFirestore
        .collection("approvedRequests")
        .where("role", isNotEqualTo: "student")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> accountCreationRequest({
    required String name,
    required String email,
    required String phoneNumber,
    required String studentId,
    required String department,
    required XFile doc,
    required VoidCallback onSuccess,
  }) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      FirebaseStorage storage = FirebaseStorage.instance;

      // Check for duplicate email or phone number
      var existingRequests = await firestore
          .collection("registrationRequests")
          .where("email", isEqualTo: email)
          .get();

      if (existingRequests.docs.isNotEmpty) {
        Fluttertoast.showToast(msg: "Request with phone number already exists");
        return;
      }

      existingRequests = await firestore
          .collection("registrationRequests")
          .where("phone", isEqualTo: phoneNumber)
          .get();

      if (existingRequests.docs.isNotEmpty) {
        Fluttertoast.showToast(msg: "Request with phone number already exists");
        return;
        // throw Exception("Phone number already exists");
      }

      // Generate unique file name with studentId, timestamp, and file extension
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String fileExtension = doc.name.split('.').last;
      String filePath =
          "documents/$studentId/${studentId}_$timestamp.$fileExtension";
      Reference ref = storage.ref().child(filePath);
      UploadTask uploadTask = ref.putData(await doc.readAsBytes());
      TaskSnapshot snapshot = await uploadTask;
      String fileUrl = await snapshot.ref.getDownloadURL();

      // Add request to Firestore
      await firestore.collection("registrationRequests").add({
        "name": name,
        "email": email,
        "role": "student",
        "phone": phoneNumber,
        "student_id": studentId,
        "doc_url": fileUrl,
        "department": department,
        "timestamp": Timestamp.now(),
      }).then((value) {
        onSuccess();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to create account request");
      log("Error: ${e.toString()}");
      throw Exception("Failed to create account request");
    }
  }
}
