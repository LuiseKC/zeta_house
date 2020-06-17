import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zeta_house/entidade/usuario.dart';
import 'package:zeta_house/pages/users.dart';
import 'package:zeta_house/shared/drawer.dart';

// ignore: must_be_immutable
class EditUser extends StatefulWidget {
  DocumentSnapshot ds;

  EditUser(this.ds);

  @override
  _EditUserState createState() => _EditUserState(this.ds);
}

class _EditUserState extends State<EditUser> {
  DocumentSnapshot ds;

  _EditUserState(this.ds);


  Usuario user;

  final databaseReference = Firestore.instance;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  var controllerName = TextEditingController();
  var controllerEmail = TextEditingController();
  bool admin = false;

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void initState() {
    controllerName.text = ds['Nome'];
    controllerEmail.text = ds['Email'];
    admin = ds['Admin'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Editar Usuário';



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
                //enable: false,
                //textInputAction: TextInputAction.next,
                //focusNode: _emailFocus,
                readOnly: true,
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
                  updateRecord(controllerName.text, admin);
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

  void updateRecord(String nome, bool isAdmin) async {
    Firestore.instance
        .collection('Usuario')
        .document(ds.documentID)
        .updateData({
      'Nome': nome,
      'Admin': isAdmin,
    });
  }
}
