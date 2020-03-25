import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 0.6 * height,
                  child: Image(
                    image: AssetImage('images/logo_zeta2.png'),
                  ),
                ),
                //SizedBox(height: 30),
                TextField(
                  style: TextStyle(
                    color: Color.fromRGBO(15, 184, 214, 1),
                  ),
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(15, 184, 214, 1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(15, 184, 214, 1),
                      ),
                    ),
                    //hintText: 'E-mail',
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(15, 184, 214, 0.7),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  style: TextStyle(color: Color.fromRGBO(15, 184, 214, 1)),
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(15, 184, 214, 1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(15, 184, 214, 1),
                      ),
                    ),
                    labelText: 'Senha',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(15, 184, 214, 0.7),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                RaisedButton(
                  onPressed: () {},
                  //textColor: Colors.white,
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color.fromRGBO(26, 58, 128, 0.8),
                          Color.fromRGBO(19, 137, 196, 1),
                          Color.fromRGBO(15, 184, 214, 1),
                          Color.fromRGBO(26, 58, 128, 0.8),
                        ],
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ), //EdgeInsets.all(10.0),
                    child: const Text('Entrar',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(255, 250, 250, 0.7),
                        )),
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Criar conta',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 250, 250, 0.7),
                    ),
                  ),
                  onPressed: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
