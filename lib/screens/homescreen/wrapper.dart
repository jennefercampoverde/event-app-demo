import 'package:flutter/material.dart';
import 'package:litm_project/screens/authenticate/authenticate.dart';
import 'package:litm_project/screens/homescreen/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

//want to return either the home or the authenticate widget 
    return Authenticate();
  }
}