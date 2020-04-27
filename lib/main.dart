import 'package:flutter/material.dart';
import 'package:zeta_house/pages/new_user.dart';
import 'package:zeta_house/pages/users.dart';

void main() => runApp(MyApp());

//colors;


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zeta House',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromRGBO(19, 137, 196, 1),
      ),
      home: NewUser(),
    );
  }
}
