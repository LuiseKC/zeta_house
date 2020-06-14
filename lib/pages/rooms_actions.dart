import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zeta_house/shared/drawer.dart';


class RoomsActions extends StatefulWidget {
  String sensorID;
 // RoomsActions(sensorID);
  @override
  _RoomsActionsState createState() => _RoomsActionsState();
}

class _RoomsActionsState extends State<RoomsActions> {
  final title = 'Acender Luzes';

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection("Comodo")
              .where("Excluido", isEqualTo: 0)
              .where("Tipo3", isEqualTo: true)
              .orderBy("Descricao")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return roomsList(snapshot);
            } else {
              return Text("Nenhuma cômodo encontrado");
            }
          },
        ),
      ),
    );
  }

  roomsList(snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: snapshot.data.documents.length,
      padding: const EdgeInsets.all(5.0),
      itemBuilder: (context, index) {
        DocumentSnapshot ds = snapshot.data.documents[index];
        return Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          height: 100,
          width: double.maxFinite,
          child: GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
//                border: Border(
//                  top: BorderSide(
//                      width: 1.5,
//                      color: ds["automatico"] ? Colors.yellow : Colors.transparent),
//                  bottom: BorderSide(
//                      width: 1.5,
//                      color: ds["automatico"] ? Colors.yellow : Colors.transparent),
//                  left: BorderSide(
//                      width: 1.5,
//                      color: ds["automatico"] ? Colors.yellow : Colors.transparent),
//                  right: BorderSide(
//                      width: 1.5,
//                      color: ds["automatico"] ? Colors.yellow : Colors.transparent),
//                ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    textDirection: TextDirection.ltr,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25.0, bottom: 25.0),
                                      ),
                                      Expanded(
                                        child: Text(
                                          ds["Descricao"],
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        //    flex: 2
                                      ),
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
          ),
        );
      },
    );
  }
}
