import 'package:flutter/material.dart';
import 'package:zeta_house/pages/login.dart';
import 'package:zeta_house/pages/new_user.dart';
import 'package:zeta_house/pages/rooms.dart';
import 'package:zeta_house/pages/users.dart';



void main() async {


  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zeta House',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromRGBO(19, 137, 196, 1),
      ),
      home: LoginPage(),
    );
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}