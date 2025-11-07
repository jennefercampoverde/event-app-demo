import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:litm_project/firebase_services/auth.dart';
import 'package:litm_project/screens/authenticate/sign_in.dart';

class Eventspage extends StatefulWidget {
  const Eventspage({super.key});

  @override
  State<Eventspage> createState() => _EventspageState();
}

class _EventspageState extends State<Eventspage> {

var errMessage;
Future<void> signOut() async{
  try{
    await AuthService().signOut();
  }
  on FirebaseAuthException catch (e){

  setState((){
     errMessage= e.message;
  });
  }
}


  Widget _logOut(){
  return ElevatedButton(
      onPressed:() async{
          try{
          
            await signOut();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignIn()),);

          }
          on FirebaseAuthException catch(e)
          {
            errMessage=e.message;
          } 
      },
      child: Text('Log out' ),
    );
}

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Color(0xFF11224E),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal:10.0),
        child: Column(
          children: [
          SizedBox(height: 50.0),
          DefaultTextStyle(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0, color: Color(0xFFFFC94A)), child: Text("Events")),
          SizedBox(height: 25.0),
          DefaultTextStyle(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0, color: Color(0xFFFFC94A)), child: Text("Near You")),
          SizedBox(height: 25.0),
          _logOut(),
          
          
          ],
        ),
      )
    );
  }
}