import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:litm_project/firebase_services/auth.dart';
import 'package:litm_project/screens/homescreen/zipcode.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool isLogin = true;
  String? errMessage = '';

 
final TextEditingController _controllerFirstName= TextEditingController();

final TextEditingController _controllerLastName= TextEditingController();

final TextEditingController _controllerEmail= TextEditingController();

final TextEditingController _controllerPassword= TextEditingController();


Future<void> addUserToDb() async{
  try{
   final data= await FirebaseFirestore.instance.collection("Users").add({
      "FirstName" : _controllerFirstName.text.trim(),
      "LastName" : _controllerLastName.text.trim(),
      "Email" : _controllerEmail.text.trim(),
      "Password" : _controllerPassword.text.trim(),
    });
    print(data.id);
  }
  catch(e){
    print(e);
  }

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
  );}

Widget _submitButton(){
  return ElevatedButton(
      onPressed: ()async {
            await addUserToDb();
          },style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple
            ),child: Text("Register", style: TextStyle(color: Colors.white
            ),),
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
          DefaultTextStyle(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0, color: Color(0xFFFFC94A)), child: Text("SIGN UP")),
          SizedBox(height: 10.0),
          SvgPicture.asset('assets/icons/Generic avatar.svg', width: 100, height: 100,),
          SizedBox(height: 10.0),
          DefaultTextStyle(style: TextStyle(fontSize: 20.0, color: Color(0xFFFFC94A)), child: Text("Welcome!")),
          DefaultTextStyle(style: TextStyle(fontSize: 20.0, color: Color(0xFFFFC94A)), child: Text("We're excited to have you here")),
          SizedBox(height: 30.0),
          Text("First Name", textAlign:TextAlign.center, style:TextStyle(color: Colors.white, fontSize: 20.0 )),
          SizedBox(height: 10.0),      
          _entryField('firstName', _controllerFirstName),
          SizedBox(height: 10.0),
          Text("Last Name", textAlign:TextAlign.center, style:TextStyle(color: Colors.white, fontSize: 20.0 )),
          _entryField('lastName', _controllerLastName),
          Text("Email", textAlign:TextAlign.center, style:TextStyle(color: Colors.white, fontSize: 20.0 )),
          _entryField('email', _controllerEmail),
          Text("Password", textAlign:TextAlign.center, style:TextStyle(color: Colors.white, fontSize: 20.0 )),
          _entryField('password', _controllerPassword),
          SizedBox(height: 25.0),
          _submitButton(),
          GestureDetector( 
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Register()),);

      },
      child: const Text("Already have an Account? Sign In Here ", style: TextStyle(color: Colors.blue)),
      )
      ]
        )
      )

    );
  }
}