import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:litm_project/firebase_services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:litm_project/screens/homescreen/eventsPage.dart';
import 'package:litm_project/screens/homescreen/zipcode.dart';
import 'register.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

final User? user = AuthService().currentUser;

String? errMessage = '';
bool isLogin = true;



final TextEditingController _controllerEmail= TextEditingController();

final TextEditingController _controllerPassword= TextEditingController();




Future<void> signInToDb() async{

  final password = _controllerPassword.text.trim();
  
   final email= _controllerEmail.text.trim();


   //print(password);

   //print(email);

   if (password.isEmpty || email.isEmpty){
    return;
   }

  try{
   //Initialize Cloud FireStore
    var db = FirebaseFirestore.instance;

    final QuerySnapshot querySnapshot = await db.collection("Users").where("Email", isEqualTo:email).get();


    if (querySnapshot.docs.isNotEmpty){
    final doc =querySnapshot.docs.first;

    final data = doc.data() as Map<String, dynamic>;
    
    if(data["Password"] == password){
      final firstTime = data["FirstTimeLogin"];
      
      if(firstTime == false){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Zipcode()),);
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Eventspage()),);
      }
    }
    else{
      print("Password is invalid");
      return showDialog <void> (context:context, barrierDismissible: false, builder: (BuildContext context)=>AlertDialog(title: const Text("Password Invalid"), content: const SingleChildScrollView(child: ListBody(children: <Widget>[Text("You have entered invalid credentials")],),), actions: <Widget> [TextButton(child: const Text("I understand"),onPressed: (){Navigator.of(context).pop();},),],),);
    }
    }
    else{
      print("No user found");
      AlertDialog(title: const Text("Password Invalid"), content: const SingleChildScrollView(child: ListBody(children: <Widget>[Text("You have entered invalid credentials")],),), actions: <Widget> [TextButton(child: const Text("I understand"),onPressed: (){Navigator.of(context).pop();},),],);
    }
  }
  catch(e){
    print("Error getting document: $e");
  }

}
Widget _title(){
  return const Text('Firebase Auth');
}

Widget _entryField(
  String title,
  TextEditingController controller,

){
  return TextField(
    controller:controller,
    //obscureText: true,
    decoration: InputDecoration(
      filled: true,
            fillColor: Color.fromARGB(255, 179, 167, 185),
            border: OutlineInputBorder(),
            hoverColor: Colors.transparent,
            labelStyle: TextStyle(color: Colors.black
            ),
    ),
  );
}

Widget _submitButton(){
  return ElevatedButton(
      onPressed:() async{
          try{
          
            await signInToDb();
            //Navigator.push(context, MaterialPageRoute(builder: (context)=> const Zipcode ()),);

          }
          on FirebaseAuthException catch(e)
          {
            print("Unable to login");
          } 
      },style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
      child: Text('Login', style: TextStyle(color: Colors.white),),
    );
}


//final AuthService _authPriv = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF11224E),
      
    
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
        child:Column(
          children: [
        SizedBox(height: 50.0),
        DefaultTextStyle(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0, color: Color(0xFFFFC94A)), child: Text("LOGIN")),
        SizedBox(height: 15.0),
        SvgPicture.asset('assets/icons/Generic avatar.svg', width: 100, height: 100,),
        SizedBox(height: 10.0),
        DefaultTextStyle(style: TextStyle(fontSize: 20.0, color: Color(0xFFFFC94A)), child: Text("Welcome Back!")),
        DefaultTextStyle(style: TextStyle(fontSize: 20.0, color: Color(0xFFFFC94A)), child: Text("Please enter your details below")),
        
        SizedBox(height: 30.0),
        DefaultTextStyle(style: TextStyle(fontSize: 15.0, color: Colors.white), child: Text("Email")),
         SizedBox(height: 10.0),
        _entryField('email', _controllerEmail),
        SizedBox(height: 25.0),
        DefaultTextStyle(style: TextStyle(fontSize: 15.0, color: Colors.white), child: Text("Password")),
         SizedBox(height: 10.0),
        _entryField('password', _controllerPassword),
        SizedBox(height: 20.0),
        _submitButton(),
        SizedBox(height: 15.0),
      GestureDetector( 
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Register()),);

      },
      child: const Text("New User? Register Here ", style: TextStyle(color: Colors.blue)),
      )
      ]
        )
      )

    );
  }
}