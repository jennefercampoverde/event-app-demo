import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:litm_project/screens/authenticate/sign_in.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteaccountState();
}

class _DeleteaccountState extends State<DeleteAccount> {




Widget _deleteInDB(){
  return ElevatedButton(
      onPressed:() async{
          try{
          
            //function to delete user from the database
            print("Account was deleted successfully.");
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignIn()),);

          }
          on FirebaseAuthException catch(e)
          {
            print("Unable to delete account");
          } 
      },style: ElevatedButton.styleFrom(backgroundColor: Colors.red[800]),
      child: Text('Delete My Account For Good', style: TextStyle(color: Colors.white),),
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
            DefaultTextStyle(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0, color: Color(0xFFFFC94A)), child: Text("Delete Account")),
          SizedBox(height: 20.0),
          SvgPicture.asset('assets/icons/Generic avatar.svg', width: 100, height: 100,),
          SizedBox(height: 20.0),
          DefaultTextStyle(style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFC94A), fontSize: 25.0 ), child: Text("We are sorry to see you go!")),
          DefaultTextStyle(style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFC94A), fontSize: 25.0 ), child: Text("Goodbye for Now!")),
          SizedBox(height: 20.0),
          _deleteInDB(),
          ],
        ),
      )
    );
  }
}