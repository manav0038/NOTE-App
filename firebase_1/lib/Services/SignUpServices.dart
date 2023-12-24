import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_1/home_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

SignUpUser(String username, String userphone, String useremail,
    String userpassword) async {
  User? userid = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance.collection("Users").doc(userid!.uid).set({
      'userName': username,
      'userPhone': userphone,
      'userEmail': useremail,
      'createdAt': DateTime.now(),
      'userId': userid.uid,
    }).then((value) =>
        {FirebaseAuth.instance.signOut(), Get.to(() => HomeScreen())});
  } on FirebaseAuthException catch (e) {
    print("Error $e");
  }
}
