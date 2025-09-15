import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

class EditNote extends StatefulWidget {
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set note text from arguments
    noteController.text = Get.arguments["note"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Edit Screen",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            TextFormField(
              controller: noteController,
              decoration: InputDecoration(hintText: "Edit Note"),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('notes')
                    .doc(Get.arguments['docId'])
                    .update({
                  'note': noteController.text.trim(),
                })
                    .then((value) {
                  print("Data Updated");
                  Get.back();// yahan ab error nahi aayega
                });
              },
              child: Text("Save Changes"),
            ),

          ],
        ),
      ),
    );
  }
}
