import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Network{
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
}





