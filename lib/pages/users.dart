import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zeta_house/pages/new_user.dart';
import 'package:zeta_house/pages/rooms.dart';

class Users extends StatelessWidget {
  final title = 'Usuários';
  final userCollection = 'Usuario';

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/zeta.png'),
                ),
              ),
            ),
            ListTile(
              title: Text('Usuários'),
              onTap: () {
                Navigator.pop(context);
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
      ),
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection(userCollection)
              .orderBy("Nome")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return usersList(snapshot);
            } else {
              return Text("Nenhuma usuário encontrado");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(19, 137, 196, 1),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewUser()),
          );
          //showDialogAddMateria(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  usersList(snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: snapshot.data.documents.length,
      padding: const EdgeInsets.all(5.0),
      itemBuilder: (context, index) {
        DocumentSnapshot ds = snapshot.data.documents[index];
        return Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          //height: 100,
          width: double.maxFinite,
          child: Card(
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
//                  top: BorderSide(
//                      width: 1.5,
//                      color: ds["Admin"] ? Colors.green : Colors.transparent),
//                  bottom: BorderSide(
//                      width: 1.5,
//                      color: ds["Admin"] ? Colors.green : Colors.transparent),
//                  left: BorderSide(
//                      width: 1.5,
//                      color: ds["Admin"] ? Colors.green : Colors.transparent),
//                  right: BorderSide(
//                      width: 1.5,
//                      color: ds["Admin"] ? Colors.green : Colors.transparent),
                    ),
                color: Color.fromRGBO(26, 58, 128, 0.5),
              ),
              child: Padding(
                padding: EdgeInsets.all(7),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 25.0, bottom: 25.0),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ds["Nome"],
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      //    flex: 2
                                    ),
                                    Expanded(
                                      child: Text(
                                        ds["Email"],
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      //    flex: 3
                                    ),
//                                            Expanded(
//                                                child: Text(
//                                                  ds["Admin"].toString(),
//                                                ),
//                                                flex: 1),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  deleteData(docId) {
    Firestore.instance
        .collection(userCollection)
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
