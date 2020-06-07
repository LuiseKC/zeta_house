import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zeta_house/entidade/usuario.dart';
import 'package:zeta_house/pages/users.dart';
import 'package:zeta_house/shared/drawer.dart';

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

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Novo Usuário';

    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          Column(
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.next,
                focusNode: _nameFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _nameFocus, _emailFocus);
                },
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
              TextFormField(
                textInputAction: TextInputAction.next,
                focusNode: _emailFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _emailFocus, _passwordFocus);
                },
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
              TextFormField(
                textInputAction: TextInputAction.done,
                focusNode: _passwordFocus,
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
                  createRecord(
                      controllerName.text, controllerEmail.text, admin);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Users()),
                  );
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
    DocumentReference ref = await databaseReference.collection("Usuario").add({
      'Nome': nome,
      'Email': email,
      'Admin': isAdmin,
      'Excluido': false,
    });
  }
}
