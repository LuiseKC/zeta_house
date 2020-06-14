import 'package:flutter/material.dart';
import 'package:zeta_house/ZetaApi/ZetaApiClient.dart';
import 'package:zeta_house/pages/home_page.dart';
import 'package:zeta_house/shared/loading.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final controllerName = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerEmail = TextEditingController();
  ZetaApiClient _client = ZetaApiClient();
  bool isValid = true;
  String errorText;
  String url = 'https://zeta-house.herokuapp.com';

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

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
                SizedBox(height: 30),
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
                    errorText: !isValid ? errorText : null,
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
                  onPressed: () {
                    TryLogin(context);
                  },
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
                    'Esqueceu senha?',
                    style: TextStyle(
                      color: Color.fromRGBO(19, 137, 196, 1),
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> TryLogin(BuildContext context) async {
    try {
      Loading.showLoadingDialog(context, _keyLoader); //invoking login
      _client.urlApi = url;
      Map auth =
          await _client.TryLogin(controllerEmail.text, controllerPassword.text);
      Navigator.of(_keyLoader.currentContext, rootNavigator: true)
          .pop(); //close the dialoge
      if (auth['success']) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        showAlertDialog(context);
      }
    } catch (error) {
      print(error);
    }
    //_client.HandleAction();
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
