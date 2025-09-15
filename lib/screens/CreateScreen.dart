import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNoteScreen extends StatefulWidget {
  @override
  State<CreateNoteScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateNoteScreen> {
  TextEditingController AddNoteController = TextEditingController();
User? userid = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Note",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  controller: AddNoteController,
                  maxLines: null,
                  decoration: InputDecoration(hintText: "Add Note"),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(onPressed: () async{
                var note = AddNoteController.text.trim();
                if(note != ""){
                  try{
                    await FirebaseFirestore.instance.collection("notes").doc().set({
                      "createdAt": DateTime.now(),
                      "note":note,
                      "userid": userid?.uid,
                    });

                  }catch(e){
                    print("Error $e");
                  }

                }else{
                  print("Error");
                }
              }, child: Text("Add Note")),
            ],
          ),
        ),
      ),
    );
  }
}
