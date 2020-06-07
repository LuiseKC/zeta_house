import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeta_house/shared/drawer.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final title = 'Configurações';

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
              .where("Excluido", isEqualTo: false)
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
                        Expanded(
                          flex: 1,
                          child: Switch(
                            value: ds["automatico"],
                            onChanged: (value) {
                              setState(() {
                                Firestore.instance
                                    .collection('Comodo')
                                    .document(ds.documentID)
                                    .updateData({
                                  'automatico': value,
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
                  });
            } else {
              return Text("Nenhuma tarefa encontrada");
            }
          },
        ),
      ),
    );
  }
}