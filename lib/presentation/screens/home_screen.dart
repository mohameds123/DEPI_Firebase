import 'package:depi/presentation/screens/Login_screen.dart';
import 'package:depi/presentation/screens/create_note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: ()async{
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
            },
            child: Center(
              child: Text("Log Out"),
            ),
          ),
          InkWell(
            onTap: ()async{

              Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateNote()));
            },
            child: Center(
              child: Text("Create Note"),
            ),
          ),
        ],
      ),
    );
  }
}
