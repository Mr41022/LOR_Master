import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:major_project/network/network.dart';

class TranscriptForms extends Network {
  var kTranscriptCollection = 'transcripts';

  getTranscriptForms({required String transcriptId}) async {
    QuerySnapshot doc = await firebaseFirestore
        .collection(kTranscriptCollection)
        .doc(transcriptId)
        .collection("forms")
        .get();
    Map data = doc.docs.first.data() as Map;
    return data;
  }

  updateTranscriptForm(
      {required String transcriptId,
      required bool isFormFilled,
      required VoidCallback onSucess}) async {
    try {
      await firebaseFirestore
          .collection(kTranscriptCollection)
          .doc(transcriptId)
          .update({
        "status": isFormFilled ? "completed" : "rejected",
        "is_form_filled": isFormFilled
      }).then((value) {
        onSucess();
      });
    } catch (e) {
      print(e);
    }
  }

  addTranscriptForm(
      {required Map<String, dynamic> formData,
      required String transcriptionId,
      required VoidCallback onSucess}) async {
    formData['updated_at'] = DateTime.now();
    await firebaseFirestore
        .collection(kTranscriptCollection)
        .doc(transcriptionId)
        .collection("forms")
        .add(formData)
        .then((value) async {
      onSucess();
      await firebaseFirestore
          .collection(kTranscriptCollection)
          .doc(transcriptionId)
          .update({"is_form_filled": true});
    });
  }
}
