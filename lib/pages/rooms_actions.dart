import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zeta_house/shared/drawer.dart';

// ignore: must_be_immutable
class RoomsActions extends StatefulWidget {
  String tipoID;

  RoomsActions(this.tipoID);

  @override
  _RoomsActionsState createState() => _RoomsActionsState(this.tipoID);
}

class _RoomsActionsState extends State<RoomsActions> {
  String tipoID;

  _RoomsActionsState(this.tipoID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        title: pageTitle(),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection("Sensor")
              .where("Excluido", isEqualTo: "false")
              .where("TipoID", isEqualTo: tipoID)
              .orderBy("ComodoDescricao")
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
                        flex: 2,
                      ),
                      Expanded(
                        child: Text(
                          ds["ComodoDescricao"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        flex: 3,
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
              return Text("Carregando...");
            }
          },
        ),
      ),
    );
  }

  Widget pageTitle() {
    if (tipoID == '1') {
      return Text('Lâmpada');
    } else {
      if (tipoID == '2') {
        return Text('Automação');
      } else {
        return Text('Segurança');
      }
    }
  }
}
