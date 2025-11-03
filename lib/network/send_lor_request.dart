import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:major_project/network/network.dart';

class LorRequests extends Network {
  Future<void> sendLorRequests({
    required List<String> emails,
    required List<String> names,
    required String universityName,
    required String department,
    required VoidCallback onSuccess,
    required String lastDate,
    required String phoneNumber,
    XFile? file,
  }) async {
    try {
      print(emails);
      Map<String, dynamic> myData = {};

      // Fetch the current user's data
      final snapshot = await firebaseFirestore
          .collection("users")
          .doc(firebaseauth.currentUser!.uid)
          .get();

      myData = snapshot.data() ?? {};

      // Upload file if provided
      String? fileUrl;
      if (file != null) {
        fileUrl = await _uploadFile(file, firebaseauth.currentUser!.uid);
      }

      // Send LOR requests
      for (int i = 0; i < emails.length; i++) {
        firebaseFirestore
            .collection("users")
            .where("email", isEqualTo: emails[i])
            .get()
            .then((value) {
          for (var element in value.docs) {
            firebaseFirestore
                .collection("users")
                .doc(element.id)
                .collection("LORRequests")
                .add({
              "professor_name": names[i],
              "professor_email": emails[i],
              "university_name": universityName,
              "department": department,
              "email": firebaseauth.currentUser!.email,
              "name": myData["name"],
              "fileUrl": fileUrl,
              "last_date": lastDate,
              "phone_number": phoneNumber,
              "status": "pending",
              "student_id": myData["student_id"]
            }).then((value) async {
              firebaseFirestore
                  .collection("users")
                  .doc(firebaseauth.currentUser!.uid)
                  .collection("LORRequests")
                  .doc(value.id)
                  .set({
                "professor_name": names[i],
                "professor_email": emails[i],
                "university_name": universityName,
                "department": department,
                "email": firebaseauth.currentUser!.email,
                "name": myData["name"],
                "fileUrl": fileUrl,
                "last_date": lastDate,
                "phone_number": phoneNumber,
                "status": "pending",
                "student_id": myData["student_id"]
              });
            });
          }
        });
      }
      onSuccess();
      Fluttertoast.showToast(
          msg: "LOR Request Sent to ${names.length} Faculty");
    } catch (e) {
      print(e);
    }
  }
  

  removeLor({required id, required String studentEmail}) {
    firebaseFirestore
        .collection("users")
        .doc(firebaseauth.currentUser!.uid)
        .collection("LORRequests")
        .doc(id)
        .update({"status": "rejected"});
    firebaseFirestore
        .collection("users")
        .where("email", isEqualTo: studentEmail)
        .get()
        .then((value) {
      for (var element in value.docs) {
        firebaseFirestore
            .collection("users")
            .doc(element.id)
            .collection("LORRequests")
            .doc(id)
            .update({"status": "rejected"});
      }
    });
  }

  uploadLOR({required String docId, required studentEmail}) async {
    ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      try {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('LOR/${firebaseauth.currentUser!.uid}/${image.name}');
        UploadTask uploadTask = ref.putFile(File(image.path));
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        await firebaseFirestore
            .collection("users")
            .doc(firebaseauth.currentUser!.uid)
            .collection("LORRequests")
            .doc(docId)
            .update({"lor_url": downloadUrl, "status": "completed"});
        await firebaseFirestore
            .collection("users")
            .where("email", isEqualTo: studentEmail)
            .get()
            .then((value) {
          final doc = value.docs.first;
          doc.reference
              .collection("LORRequests")
              .doc(docId)
              .update({"lor_url": downloadUrl, "status": "completed"});
        });
      } catch (e) {
        print("Error uploading LOR: $e");
        return null;
      }
    }
    return null;
  }

  Stream<List<Map<String, dynamic>>> getRequests() {
    return firebaseFirestore
        .collection("users")
        .doc(firebaseauth.currentUser!.uid)
        .collection("LORRequests")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => {
                ...doc.data(),
                'doc_id': doc.id,
              })
          .toList();
    });
  }

  // Method to upload file to Firebase Storage
  Future<String> _uploadFile(XFile file, String userId) async {
    try {
      Reference ref =
          FirebaseStorage.instance.ref().child('LORReq/$userId/${file.name}');
      UploadTask uploadTask = ref.putFile(File(file.path));
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print("File upload error: $e");
      return '';
    }
  }
}
