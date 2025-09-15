import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/screens/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

signUpUser(
  String userName,
  String userPhone,
  String userEmail,
  String userPassword,
) async {

    User? userid = FirebaseAuth.instance.currentUser;

    try{
      await FirebaseFirestore.instance.collection("user").doc(userid?.uid).set({
        "UserName": userName,
        "UserPhone": userPhone,
        "UserPassword": userPassword,
        "UserEmail": userEmail,
        "CreatedAt": DateTime.now(),
        "userid": userid?.uid,
      }).then((value)=> {
        FirebaseAuth.instance.signOut(),
        Get.to(() => HomePage())
      });
    }on FirebaseAuthException catch (e){
      print("Error $e");
    }

}
