import 'package:firebase_app/screens/homescreen.dart';
import 'package:firebase_app/screens/main_HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Get;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  User? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    user = FirebaseAuth.instance.currentUser;
    print(user?.uid.toString());
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     debugShowCheckedModeBanner: false,
      home: user != null ? HomePage() : HomeScreen(),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
