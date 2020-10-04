import 'package:flutter/material.dart';
import 'package:userprofile_demo/Loginscreen.dart';
// import 'package:userprofile_demo/Registerscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
      ),
      home: LoginScreen(),
    );
  }
}