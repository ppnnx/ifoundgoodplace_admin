import 'package:flutter/material.dart';
import 'package:ifgpadmin/screens/contents/contents_screen.dart';
import 'package:ifgpadmin/screens/dashboard/dashboard_screen.dart';
import 'package:ifgpadmin/screens/login/login_screen.dart';
import 'package:ifgpadmin/screens/users/users_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

