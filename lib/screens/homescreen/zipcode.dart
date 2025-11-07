import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:litm_project/firebase_services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:litm_project/screens/authenticate/deleteAccount.dart';
import 'package:litm_project/screens/authenticate/sign_in.dart';
import 'package:litm_project/screens/authenticate/deleteAccount.dart';


class Zipcode extends StatefulWidget {
  const Zipcode({super.key});

  @override
  State<Zipcode> createState() => _ZipcodeState();
}



class _ZipcodeState extends State<Zipcode> {

  final TextEditingController _controllerZipcode = TextEditingController();


  
  String? errMessage = '';
  bool isLogin = true;

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


Widget _submitButton(){
  return ElevatedButton(
      onPressed:() async{
          try{
          
            //function to submit zipcode
            

          }
          on FirebaseAuthException catch(e)
          {
            print("Unable to login");
          } 
      },style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
      child: Text('Continue', style: TextStyle(color: Colors.white),),
    );
}

Widget _deleteAccount(){
  return ElevatedButton(
      onPressed:() async{
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const DeleteAccount()),);
      },style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[300]),
      child: Text('Delete Account', style: TextStyle(color: Colors.white),),
    );
}


Widget _entryField(
  String title,
  TextEditingController controller,

){
  return TextField(
    controller:controller,
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
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF11224E),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
        child:Column(
          children: [
            SizedBox(height: 100.0),
            DefaultTextStyle(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Color(0xFFFFC94A)), child: Text("Let us find")),
            DefaultTextStyle(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Color(0xFFFFC94A)), child: Text("nearby events")),
            DefaultTextStyle(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Color(0xFFFFC94A)), child: Text("for you")),
            SizedBox(height: 20.0),
            SvgPicture.asset('assets/icons/location_on.svg', width: 50, height: 50,),
            SizedBox(height: 10.0),
            DefaultTextStyle(style: TextStyle(fontSize: 15.0, color: Colors.white), child: Text("Enter Your Zipcode")),
            SizedBox(height: 50.0),
            _entryField('zipcode', _controllerZipcode),
            SizedBox(height: 50.0),
            _submitButton(),
        _logOut(),
        _deleteAccount(),
          ],
        )
      )

    );
  }
}