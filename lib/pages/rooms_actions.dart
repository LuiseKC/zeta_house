import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zeta_house/shared/drawer.dart';
import 'package:flip_card/flip_card.dart';


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

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        title: pageTitle(),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection("Comodo")
              .where("Excluido", isEqualTo: 0)
              .where(tipoID, isEqualTo: true)
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
            onTap: () {
              showAlertDialog(context);
            },
            child: FlipCard(
              direction: FlipDirection.VERTICAL,
              flipOnTouch: true,
             // elevation: 5,
              front: cardContainer(ds),
              back: cardContainer(ds),
            ),
          ),
        );
      },
    );
  }

  Widget pageTitle(){
    if(tipoID == 'Tipo1'){
      return Text('Lâmpada');
    }else{
      if(tipoID == 'Tipo2'){
        return Text('Automação');
      }else{
        return Text('Segurança');
      }
    }
  }

  Widget cardContainer(DocumentSnapshot ds){
    return Container(
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
    );
  }

  void actionPress(){

  }

  showAlertDialog(BuildContext context) {
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
      content: Text("Login ou senha incorretos."),
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

}
