import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User extends StatelessWidget {
  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    final title = 'Users';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: List.generate(
          choices.length,
          (index) {
            return Center(
              child: ChoiceCard(choice: choices[index], item: choices[index]),
            );
          },
        ),
      ),
    );
  }
}

class Users extends StatelessWidget {
  final title = 'Users';
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection("Usuario")
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
    return ListView.separated(
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) => Divider(
          color: Colors.greenAccent,
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
              Expanded(child: Text(ds["Nome"]), flex: 2),
              Expanded(
                  child: Text(
                    ds["Email"],
                  ),
                  flex: 3),
              Expanded(
                  child: Text(
                    ds["Admin"].toString(),
                  ),
                  flex: 1),
            ],
          );

          return row;
        });
  }

  test7UusersList(snapshot) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: List.generate(
        snapshot.data.documents.length,
            (index) {
          return Center(
            child: ChoiceCard(choice: choices[index], item: choices[index]),
          );
        },
      ),
    );
  }
}

class Choice {
  const Choice({this.name, this.email, this.icon});

  final String name;
  final String email;
  final IconData icon;
}

//region choices
const List<Choice> choices = const <Choice>[
  const Choice(
      name: 'This is a Boat, because its a Boat. So, it\'s a Boat',
      icon: Icons.directions_boat),
];
//endregion

class ChoiceCard extends StatelessWidget {
  const ChoiceCard(
      {Key key,
      this.choice,
      this.onTap,
      @required this.item,
      this.selected: false})
      : super(key: key);

  final Choice choice;
  final VoidCallback onTap;
  final Choice item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final databaseReference = Firestore.instance;
    databaseReference.collection("Usuarios").getDocuments();
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Card(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.topLeft,
              child: Icon(
                choice.icon,
                size: 80.0,
                color: Color.fromRGBO(19, 37, 69, 1),
              )),
          Expanded(
            child: new Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.topLeft,
              child: Text(
                //choice.name,
                "Teste",
                style: TextStyle(
                  color: Color.fromRGBO(19, 37, 69, 1),
                ),
                textAlign: TextAlign.left,
                maxLines: 5,
              ),
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
