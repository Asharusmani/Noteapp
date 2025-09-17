import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/screens/CreateScreen.dart';
import 'package:firebase_app/screens/editnotescreen.dart';
import 'package:firebase_app/screens/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userid = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.off(() => HomePage());
            },

            child: Icon(Icons.logout, color: Colors.white),
          ),
        ],
        elevation: 0,
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateNoteScreen());
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance
                  .collection("notes")
                  .where("userid", isEqualTo: userid?.uid)
                  .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong!");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No data found!"));
            }
            if (snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  var note = snapshot.data!.docs[index]["note"];
                  var noteid = snapshot.data!.docs[index]["userid"];
                  var docId = snapshot.data!.docs[index].id;
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data?.docs[index]["note"]),
                      subtitle: Text(noteid),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => EditNote(), arguments: {
                                "note": note,
                                "docId": docId,
                              });
                            },
                            child: Icon(Icons.edit),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(onTap: () {
                            FirebaseFirestore.instance.collection("notes").doc(docId).delete();
                          },
                              child: Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
