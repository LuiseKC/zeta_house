import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:zeta_house/entidade/ServiceResult.dart';
import 'package:zeta_house/entidade/usuario.dart';
import 'package:zeta_house/entidade/action.dart';

class ZetaApiClient{

  Usuario usuarioLogado;

  ServiceResult result;
  String urlApi = 'https://zeta-house.herokuapp.com';
  HttpClient _client;

  ZetaApiClient(){
    urlApi = 'https://zeta-house.herokuapp.com';
    HttpClient _client = HttpClient();
  }


  String _createHeader(String login, String senha,bool isAuth,[String token]){
    String auth = base64Encode(utf8.encode('$login:$senha'));
    if(isAuth)
      return 'Basic $auth';
    else
      return "Bearer $token";
  }

  // ignore: non_constant_identifier_names
  Future<Map> TryLogin(String login, String senha) async{
    String requestUrl = urlApi + '/login';
    try{
      http.Response resp = await http.get(requestUrl, headers: {'authorization': _createHeader(login, senha, true)});
      print(resp.statusCode);
      Map<String, dynamic> json = jsonDecode(resp.body);
      usuarioLogado = Usuario.fromJson(json);
      requestUrl = urlApi + '/apptoken';
      String token;
      FirebaseMessaging().getToken().then((val) {
        token = val;
      });
      resp = await http.get(requestUrl, headers: {'authorization': _createHeader(login, senha, true)});
      Map<String, dynamic> tokenJson = {
        'token': token,
      };
      resp = await http.post(requestUrl, body: tokenJson);
      print(json);
      print(json['success']);
//      if(json['success']){
//        return true;
//      }
//      return false;
    return json;
    }catch(ex){
      return null;
    }
  }

  void HandleAction () async {
    //headers: {'authorization': _createHeader('','', false, usuarioLogado.ApiToken)}
    Action action = Action();
    action.Type = ActionType.LIGHT_ON;
    action.Id = ActionID.LEDS_SALA;
    String requestUrl = urlApi + '/action';
    Map<String, dynamic> json = action.toJson();
    print(json);
    http.Response resp = await http.post(requestUrl, body: json);
  }


  void user() async{
    String requestUrl = urlApi + '/usuarios';
    try{
      print(requestUrl);
      http.Response resp = await http.get(requestUrl, headers: {'authorization': _createHeader('','', false, usuarioLogado.ApiToken)});
      Map<String, dynamic> json = jsonDecode(resp.body);
      usuarioLogado = Usuario.fromJson(json);
      print(usuarioLogado);

//      requestUrl = urlApi + '/apptoken';
//      String token;
//      FirebaseMessaging().getToken().then((val) {
//        token = val;
//      });
//      resp = await http.get(requestUrl, headers: {'authorization': _createHeader(login, senha, true)});
//      Map<String, dynamic> tokenJson = {
//        'token': token,
//      };
      //resp = await http.post(requestUrl, body: json);
    }catch(ex){

    }
  }


}