import 'package:flutter/material.dart';

class NewUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Novo Usuário';

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
              FlatButton(
                child: Text(
                  'Salvar',
                  style: TextStyle(
                    color: Color.fromRGBO(15, 184, 214, 0.7),
                  ),
                ),
                onPressed: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
