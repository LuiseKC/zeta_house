import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zeta_house/entidade/usuario.dart';

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  bool admin = false;
  Usuario user;
  final controllerName = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerEmail = TextEditingController();

  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    final title = 'Novo Usuário';
    //final ref = fb.reference();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          Column(
            children: <Widget>[
              TextField(
                controller: controllerName,
                style: TextStyle(
                  color: Color.fromRGBO(15, 184, 214, 1),
                ),
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(15, 184, 214, 0.7),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controllerEmail,
                style: TextStyle(
                  color: Color.fromRGBO(15, 184, 214, 1),
                ),
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(15, 184, 214, 0.7),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controllerPassword,
                obscureText: true,
                style: TextStyle(color: Color.fromRGBO(15, 184, 214, 1)),
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(15, 184, 214, 0.7),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CheckboxListTile(
                    title: Text(
                      "Administrador",
                      style: TextStyle(
                        color: Color.fromRGBO(15, 184, 214, 0.7),
                      ),
                    ),
                    value: admin,
                    onChanged: (bool value) {
                      setState(() {
                        admin = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              OutlineButton(
                child: Text(
                  'Salvar',
                  style: TextStyle(
                    color: Color.fromRGBO(15, 184, 214, 0.7),
                  ),
                ),
                onPressed: () {
                  createRecord(controllerName.text, controllerEmail.text, admin);
                },
                borderSide: BorderSide(
                  color: Color.fromRGBO(15, 184, 214, 0.7),
                  style: BorderStyle.solid,
                  width: 0.7,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void createRecord(String nome, String email, bool isAdmin) async {
//    await databaseReference.collection("books")
//        .document("1")
//        .setData({
//      'title': 'Mastering Flutter',
//      'description': 'Programming Guide for Dart'
//    });

    DocumentReference ref = await databaseReference.collection("Usuario")
        .add({
      'Nome': nome,
      'Email': email,
      'Admin': isAdmin,
    });
    print(ref.documentID);
  }

}
