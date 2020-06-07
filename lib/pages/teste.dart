import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp]); //tela somente em portrait
  runApp(MaterialApp(
    title: 'Tarefas',
    home: OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.landscape
            ? LandscapeMode()
            : PortraitMode();
      },
    ),
    theme: new ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.deepPurple,
    ),
  ));
}

class LandscapeMode extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection("planejamento")
              .orderBy("data")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return listaTarefas(snapshot);
            } else {
              return Text("Nenhuma tarefa encontrada");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroLandscape()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class PortraitMode extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection("planejamento")
              .orderBy("data")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
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
                          padding:
                          const EdgeInsets.only(top: 25.0, bottom: 25.0),
                        ),
                        Expanded(child: Text(ds["materia"]), flex: 3),
                        Expanded(
                            child: Text(
                              ds["descricao"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            flex: 2),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            shape: CircleBorder(),
                            child: Column(
                              // Replace with a Row for horizontal icon + text
                              children: <Widget>[
                                Icon(Icons.delete, color: Colors.blueGrey)
                              ],
                            ),
                            onPressed: () => {
                              deleteData(ds.documentID),
                            },
                          ),
                        ),
                      ],
                    );

                    //Se esse index for o último elemento, criaremos um espaço para que o FAB
                    //não esconda esse item
                    if (index == snapshot.data.documents.length - 1) {
                      return Padding(
                        child: row,
                        padding: EdgeInsets.only(bottom: 96),
                      );
                    }

                    return row;
                  });
            } else {
              return Text("Nenhuma tarefa encontrada");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroLandscape()),
          );
          //showDialogAddMateria(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

listaTarefas(snapshot) {
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
            Expanded(child: Text(ds["materia"]), flex: 3),
            Expanded(
                child: Text(
                  ds["descricao"],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                flex: 2),
            Expanded(
              flex: 1,
              child: FlatButton(
                shape: CircleBorder(),
                child: Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.delete, color: Colors.blueGrey)
                  ],
                ),
                onPressed: () => {
                  deleteData(ds.documentID),
                },
              ),
            ),
          ],
        );

        //Se esse index for o último elemento, criaremos um espaço para que o FAB
        //não esconda esse item
        if (index == snapshot.data.documents.length - 1) {
          return Padding(
            child: row,
            padding: EdgeInsets.only(bottom: 96),
          );
        }

        return row;
      });
}

deleteData(docId) {
  Firestore.instance
      .collection('planejamento')
      .document(docId)
      .delete()
      .catchError((e) {
    print(e);
  });
}

salvar(String materia, String descricao, DateTime data) async {
  Map map = Map<String, dynamic>();
  map['materia'] = materia;
  map['descricao'] = descricao;
  map['data'] = data;

  try {
    await Firestore.instance.collection('planejamento').add(map);

    print('ok');
    //DialogUtil.dismiss(context);

  } catch (e) {
    //DialogUtil.dismiss(context);

    showDialog(
      //context: context,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the user has typed in using our
          // TextEditingController
          content: Text(e),
        );
      },
    );
    print(e);
  }
}

class CadastroLandscape extends StatelessWidget {
  TextEditingController materiaController = new TextEditingController();
  TextEditingController tipoController = new TextEditingController();
  TextEditingController dataController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final FocusNode _materiaFocus = FocusNode();
  final FocusNode _descricaoFocus = FocusNode();
  final FocusNode _dataFocus = FocusNode();


  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  var parsedDate = DateTime.tryParse(
                      dataController.text.substring(6) +
                          '-' +
                          dataController.text.substring(3, 5) +
                          '-' +
                          dataController.text.substring(0, 2) +
                          ' 00:00:00');

                  salvar(
                      materiaController.text, tipoController.text, parsedDate);

                  Navigator.pop(context);
                }
              },
              child: Text('Salvar'),
              textColor: Colors.white,
            )
          ],
          title: Text("Add"),
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
            child: new Column(
              //padding: const EdgeInsets.symmetric(horizontal: 16.0),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Digite a matéria',
                    labelText: 'Matéria',
                  ),
                  controller: materiaController,
                  textInputAction: TextInputAction.next,
                  focusNode: _materiaFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _materiaFocus, _descricaoFocus);
                  },
                ),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Digite a descrição',
                      labelText: 'Descrição',
                    ),
                    controller: tipoController,
                    textInputAction: TextInputAction.next,
                    focusNode: _descricaoFocus,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(context, _descricaoFocus, _dataFocus);
                    }),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'dd/MM/yyyy',
                    labelText: 'Data',
                  ),
                  //keyboardType: TextInputType.datetime,
                  controller: dataController,
                  //textInputAction: TextInputAction.done,
                  focusNode: _dataFocus,
                ),
              ],
            )),
      ),
    );
  }
}

/*
    subprojects {
        project.configurations.all {
            resolutionStrategy.eachDependency { details ->
                if (details.requested.group == 'com.android.support'
                        && !details.requested.name.contains('multidex') ) {
                    details.useVersion "27.1.1"
                }
                if (details.requested.group == 'androidx.core'
                        && !details.requested.name.contains('androidx') ) {
                    details.useVersion "1.0.1"
                }
            }
        }
    }
  */