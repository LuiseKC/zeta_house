import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zeta_house/pages/sensores_page.dart';
import 'package:zeta_house/shared/drawer.dart';

class Rooms extends StatefulWidget {
  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  final title = 'Cômodos';
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final databaseReference = Firestore.instance;

  @override
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
              .orderBy("Descricao")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SensoresPage(
                            ds["ComodoID"].toString(),
                            ds["Descricao"].toString(),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textDirection: TextDirection.ltr,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 25.0, bottom: 25.0),
                        ),
                        Expanded(
                          child: Text(
                            ds["Descricao"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          flex: 5,
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Text("Nenhuma tarefa encontrada");
            }
          },
        ),
      ),
    );
  }

  Widget rooms(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("Comodo")
          .where("Excluido", isEqualTo: 0)
          .orderBy("Descricao")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return roomsList(snapshot);
        } else {
          return Text("Carregando...");
        }
      },
    );
  }

  showAlertDialog(BuildContext context, String comodoID) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Erro"),
      content: Container(
        width: double.maxFinite,
        height: 300.0,
        child: StreamBuilder(
          stream: Firestore.instance
              .collection("Sensor")
              .where("Excluido", isEqualTo: false)
              .where("ComodoID", isEqualTo: comodoID)
              .orderBy("Descricao")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.separated(
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => Divider(
                color: Color.fromRGBO(19, 137, 196, 0.5),
              ),
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              padding: const EdgeInsets.all(5.0),
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                Row row = Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                    ),
                    Expanded(
                      child: Text(
                        ds["Descricao"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      flex: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Switch(
                        value: ds["Automatico"],
                        onChanged: (value) {
                          setState(() {
                            Firestore.instance
                                .collection('Sensor')
                                .document(ds.documentID)
                                .updateData({
                              'Automatico': value,
                            });
                          });
                        },
                        activeTrackColor: Color.fromRGBO(19, 37, 69, 0.8),
                        activeColor: Color.fromRGBO(26, 58, 128, 0.8),
                      ),
                    ),
                  ],
                );
                return row;
              },
            );
          },
        ),
      ), //sensores(comodosDS),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  dialog(comodosDS) {
    sensores(comodosDS);
  }

  Widget sensores(String comodoID) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("Sensor")
          .where("Excluido", isEqualTo: false)
          .where("ComodoID", isEqualTo: comodoID)
          .orderBy("Descricao")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView.separated(
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => Divider(
            color: Color.fromRGBO(19, 137, 196, 0.5),
          ),
          shrinkWrap: true,
          itemCount: snapshot.data.documents.length,
          padding: const EdgeInsets.all(5.0),
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.documents[index];
            Row row = Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                ),
                Expanded(
                  child: Text(
                    ds["Descricao"],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  flex: 5,
                ),
                Expanded(
                  flex: 1,
                  child: Switch(
                    value: ds["Automatico"],
                    onChanged: (value) {
                      setState(() {
                        Firestore.instance
                            .collection('Sensor')
                            .document(ds.documentID)
                            .updateData({
                          'Automatico': value,
                        });
                      });
                    },
                    activeTrackColor: Color.fromRGBO(19, 37, 69, 0.8),
                    activeColor: Color.fromRGBO(26, 58, 128, 0.8),
                  ),
                ),
              ],
            );
            return row;
          },
        );
      },
    );
  }

  Future<Stream<QuerySnapshot>> loadSensor(String comodoID) async {
    return await Firestore.instance
        .collection("Sensor")
        .where("Excluido", isEqualTo: false)
        .where("ComodoID", isEqualTo: comodoID)
        .orderBy("Descricao")
        .snapshots();
  }

  roomsList(snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: snapshot.data.documents.length,
      padding: const EdgeInsets.all(5.0),
      itemBuilder: (context, index) {
        DocumentSnapshot ds = snapshot.data.documents[index];
        return GestureDetector(
          onTap: () {
            showAlertDialog(context, ds['ComodoID'].toString());

            /// concertar
            print('ojk!');
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 100,
            width: double.maxFinite,
            child: Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
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

  generateItems(comodoID) {
    return Container(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection("Sensor")
            .where("Excluido", isEqualTo: "false")
            .where("ComodoID", isEqualTo: comodoID)
            .orderBy("Descricao")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                DocumentSnapshot ds = snapshot.data.documents[index];
                Row row = Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                    ),
                    Expanded(
                      child: Text(
                        ds["Descricao"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      flex: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Switch(
                        value: ds["Ativado"] == 1 ? true : false,
                        onChanged: (value) {
                          setState(() {
                            Firestore.instance
                                .collection('Sensor')
                                .document(ds.documentID)
                                .updateData({
                              'Ativado': value ? 1 : 0,
                            });
                          });
                        },
                        activeTrackColor: Color.fromRGBO(19, 37, 69, 0.8),
                        activeColor: Color.fromRGBO(26, 58, 128, 0.8),
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
    );
  }
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
