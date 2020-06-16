import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zeta_house/shared/drawer.dart';

// ignore: must_be_immutable
class SensoresPage extends StatefulWidget {
  String comodoID;
  String comodoDescricao;

  SensoresPage(this.comodoID, this.comodoDescricao);

  @override
  _SensoresPageState createState() => _SensoresPageState(this.comodoID, this.comodoDescricao);
}

class _SensoresPageState extends State<SensoresPage> {
  String comodoID;
  String comodoDescricao;

  _SensoresPageState(this.comodoID, this.comodoDescricao);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        title: Text(comodoDescricao),
      ),
      body: Container(
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
}
