import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:zeta_house/entidade/ServiceResult.dart';
import 'package:zeta_house/entidade/usuario.dart';

class ZetaApiClient{

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
    print(requestUrl);
    try{
      http.Response resp = await http.get(requestUrl, headers: {'authorization': _createHeader(login, senha, true)});
      Map<String, dynamic> json = jsonDecode(resp.body);
      var user = Usuario.fromJson(json);
      print(json['data']);
      print(user.Admin);
    }catch(ex){

    }
  }


}