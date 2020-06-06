import 'dart:convert';
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

  void TryLogin(String login, String senha) async{
    String requestUrl = urlApi + '/login';
    try{
      http.Response resp = await http.get(requestUrl, headers: {'authorization': _createHeader(login, senha, true)});
      Map<String, dynamic> json = jsonDecode(resp.body);
      usuarioLogado = Usuario.fromJson(json);
    }catch(ex){

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


}