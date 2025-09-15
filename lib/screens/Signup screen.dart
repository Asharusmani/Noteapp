import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../services/signupservices.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
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
                height: 180,
                child: Lottie.asset("images/Cxm6FNG6U9.json"),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Full Name",
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: userEmailController,
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
                  controller: userPhoneController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Phone Number",
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: userPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Password",
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Confirm Password",
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async{
                  var userName = userNameController.text.trim();
                  var userPhone = userPhoneController.text.trim();
                  var userEmail = userEmailController.text.trim();
                  var userPassword = userPasswordController.text.trim();

                 await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                        email: userEmail,
                        password: userPassword,
                      )
                      .then(
                        (value) => {
                          print("user created"),

                          signUpUser(userName,
                              userPhone,
                              userEmail,
                              userPassword)


                        },
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 130, vertical: 8),
                ),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
