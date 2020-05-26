import 'package:flutter/material.dart';
import 'package:zeta_house/pages/home_page.dart';
import 'package:zeta_house/pages/rooms.dart';
import 'package:zeta_house/pages/users.dart';

Widget drawer(context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/zeta.png'),
              ),
            ),
          ),
        ),
        ListTile(
          title: Text('Zeta House'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        ListTile(
          title: Text('Usuários'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Users()),
            );
          },
        ),
        ListTile(
          title: Text('Cômodos'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Rooms()),
            );
          },
        ),
      ],
    ),
  );
}
