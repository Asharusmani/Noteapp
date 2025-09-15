import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/screens/Forgetscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'Signup screen.dart';
import 'main_HomePage.dart';

class HomePage extends StatelessWidget {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Screen",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 200,
                child: Lottie.asset("images/Cxm6FNG6U9.json"),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: loginEmailController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Email",
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: loginPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Password",
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {
                    Get.to(()=> ForgetScreen());
                  }, child: Text("Forget Password")),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  var loginEmail = loginEmailController.text.trim();
                  var loginPassword = loginPasswordController.text.trim();
                  try {
                    final User? firebaseUser =
                        (await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: loginEmail,
                          password: loginPassword,
                        )).user;
                    if (firebaseUser!= null){
                      Get.to(() => HomeScreen());
                    }else{
                      print("Check Email And Password");
                    }
                  } on FirebaseException catch (e) {
                    print("Error $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 130, vertical: 8),
                  backgroundColor: Colors.deepPurple,
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Get.to(() => SignUpPage());
                },
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
