import 'package:firebase_app/screens/main_HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'homescreen.dart';

class ForgetScreen extends StatefulWidget {
  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  TextEditingController ForgetPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forget Password",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forget Password',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: ForgetPasswordController,
              decoration: InputDecoration(
                hintText: "Email",
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                var ForgetEmail = ForgetPasswordController.text.trim();
                try {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: ForgetEmail)
                      .then(
                        (value) => {
                          print("Email Send"),
                          Get.off(() => HomePage()),
                        },
                      );
                } on FirebaseAuthException catch (e) {
                  print("Error $e");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 90),
              ),
              child: Text(
                "Forget Password",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
