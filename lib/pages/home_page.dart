import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeta_house/ZetaApi/ZetaApiClient.dart';
import 'package:zeta_house/pages/rooms.dart';
import 'package:zeta_house/pages/settings.dart';
import 'package:zeta_house/pages/users.dart';
import 'package:zeta_house/shared/drawer.dart';

import 'rooms_actions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final title = 'Zeta House';

  ZetaApiClient _client = ZetaApiClient();
  String url = 'https://zeta-house.herokuapp.com';

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 190,
                  height: 80,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Rooms()),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color.fromRGBO(26, 58, 128, 0.8),
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.home, size: 50),
                            title: Text('Cômodos',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  //padding: EdgeInsets.all(5.0),
                  width: 190,
                  height: 80,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Users()),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color.fromRGBO(26, 58, 128, 0.8),
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.people, size: 50),
                            title: Text('Usuários',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 190,
                  height: 80,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RoomsActions('1')),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color.fromRGBO(26, 58, 128, 0.8),
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.home, size: 50),
                            title: Text('Lâmpada',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  //padding: EdgeInsets.all(5.0),
                  width: 190,
                  height: 80,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RoomsActions('2')),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color.fromRGBO(26, 58, 128, 0.8),
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.home, size: 50),
                            title: Text('Automação',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 190,
                  height: 80,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RoomsActions('5')),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color.fromRGBO(26, 58, 128, 0.8),
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.home, size: 50),
                            title: Text('Segurança',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  //padding: EdgeInsets.all(5.0),
                  width: 190,
                  height: 80,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Settings()),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color.fromRGBO(26, 58, 128, 0.8),
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.settings, size: 50),
                            title: Text('Configurações',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 190,
                  height: 200,
                  child: GestureDetector(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color.fromRGBO(26, 58, 128, 0.8),
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.home, size: 50),
                            title: Text('Temperatura',
                                style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(height: 20),
                          StreamBuilder(
                            stream: Firestore.instance
                                .collection("Temperatura")
                                .orderBy("Data", descending: true)
                                .limit(1)
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  separatorBuilder: (context, index) => Divider(
                                    color: Color.fromRGBO(19, 137, 196, 0.5),
                                  ),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.documents.length,
                                  padding: const EdgeInsets.all(5.0),
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot ds =
                                        snapshot.data.documents[index];
                                    Row row = Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      textDirection: TextDirection.ltr,
                                      children: <Widget>[
                                        Center(
                                          child: Text(
                                            ds["Temperatura"] + "°C",
                                            style: TextStyle(fontSize: 50),
                                          ),
                                        ),
                                      ],
                                    );
                                    return row;
                                  },
                                );
                              } else {
                                return Text("Carregando");
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  //padding: EdgeInsets.all(5.0),
                  width: 190,
                  height: 200,
                  child: GestureDetector(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color.fromRGBO(26, 58, 128, 0.8),
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.home, size: 50),
                            title: Text('Umidade',
                                style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(height: 20),
                          StreamBuilder(
                            stream: Firestore.instance
                                .collection("Temperatura")
                                .orderBy("Data", descending: true)
                                .limit(1)
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  separatorBuilder: (context, index) => Divider(
                                    color: Color.fromRGBO(19, 137, 196, 0.5),
                                  ),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.documents.length,
                                  padding: const EdgeInsets.all(5.0),
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot ds =
                                        snapshot.data.documents[index];
                                    Row row = Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      textDirection: TextDirection.ltr,
                                      children: <Widget>[
                                        Center(
                                          child: Text(
                                            ds["Umid"] + "%",
                                            style: TextStyle(fontSize: 50),
                                          ),
                                          //flex: 5,
                                        ),
                                      ],
                                    );
                                    return row;
                                  },
                                );
                              } else {
                                return Text("Carregando");
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
