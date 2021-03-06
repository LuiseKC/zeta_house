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
}
