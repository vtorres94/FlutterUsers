import 'package:crud_users/src/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _initAdmin();
    return MaterialApp(
      home: LoginPage(),
    );
  }

  _initAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', 'admin');
    await prefs.setString('pass', 'admin');
    await prefs.setString('admin', 'admin');
  }
}