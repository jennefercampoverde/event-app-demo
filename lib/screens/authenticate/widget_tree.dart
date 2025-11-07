import 'package:flutter/material.dart';
import 'package:litm_project/screens/homescreen/zipcode.dart';
import 'package:litm_project/screens/authenticate/register.dart';
import 'package:litm_project/screens/authenticate/sign_in.dart';
import 'package:litm_project/firebase_services/auth.dart';


class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChanges,
      builder:(context,snapshot){
        if(snapshot.hasData){
          return Zipcode();
        }
        else{
          return const SignIn();
        }
      },

    );
  }
}