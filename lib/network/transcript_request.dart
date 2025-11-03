import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:major_project/network/network.dart';

class TranscriptRequest extends Network {
  var kTranscriptCollection = 'transcripts';

  Stream<List<Map<String, dynamic>>> getTranscriptRequest() {
    return firebaseFirestore
        .collection(kTranscriptCollection)
        .orderBy("updated_at", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  updateTranscriptRequest(
      {required String transcriptId, required bool isApproved}) async {
    try {
      await firebaseFirestore
          .collection(kTranscriptCollection)
          .doc(transcriptId)
          .update({"status": isApproved ? "approved" : "rejected"});
    } catch (e) {
      print(e);
    }
  }

  Stream<List<Map<String, dynamic>>> getUserRequests() {
    return firebaseFirestore
        .collection(kTranscriptCollection)
        .where("uid", isEqualTo: firebaseauth.currentUser!.uid)
        .orderBy("updated_at", descending: true) // <-- sort by latest
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  createTranscriptRequest({required VoidCallback onSucess}) async {
    try {
      if (await checkTranscriptRequest()) {
        return;
      }

      await firebaseFirestore.collection(kTranscriptCollection).add({
        "created_at": Timestamp.now(),
        "status": "pending",
        "uid": firebaseauth.currentUser!.uid,
        "is_form_filled": false,
        "updated_at": Timestamp.now(),
      }).then((value) => onSucess());
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  checkTranscriptRequest() async {
    try {
      // Primary query: uid + orderBy
      QuerySnapshot<Map<String, dynamic>> doc = await firebaseFirestore
          .collection(kTranscriptCollection)
          .where("uid", isEqualTo: firebaseauth.currentUser!.uid)
          .get();

      List request = doc.docs.map((e) => e.data()).toList();

      if (request.isEmpty) {
        return false;
      } else {
        request.sort((a, b) => (b['updated_at'] as Timestamp)
            .compareTo(a['updated_at'] as Timestamp));

        Map<String, dynamic> latestRequest = request.first;

        switch (latestRequest['status']) {
          case "pending":
            Fluttertoast.showToast(msg: "You already have a pending request");
            return true;
          case "approved":
            Fluttertoast.showToast(msg: "You already have a approved request");
            return true;
          case "rejected":
            if (DateTime.now().isBefore(
                latestRequest["updated_at"].toDate().add(Duration(days: 1)))) {
              Fluttertoast.showToast(
                  msg: "Please wait for 24 hours to create a new request");
              return true;
            }
            return false;
          case "completed":
            Fluttertoast.showToast(
                msg: "Your already have a completed request");
            return true;
        }
      }
    } catch (e) {
      print("Full query failed (probably missing index). Error: $e");
    }
  }
}
