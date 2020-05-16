import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users extends StatelessWidget {
  final title = 'Usuários';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection("Usuarios")
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
}
