import 'package:crud_users/src/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(GetMaterialApp(home:MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }

}