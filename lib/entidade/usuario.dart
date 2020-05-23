import 'dart:convert';

class Usuario {
  String Id;
  String Email;
  String Senha;
  bool Admin;
  String GrupoId;
  String Nome;
  String ApiToken;

//String enderecoId;
//DateTime dateUltimoAcesso;
//int grupoId;
//bool excluido;

  Usuario();
  void CreateUserFromJson(Map<String, dynamic> jsonUsuario){
    Id = jsonUsuario['Id'];
    Email = jsonUsuario['Email'];
    Senha = jsonUsuario['Senha'];
    GrupoId = jsonUsuario['GrupoId'];
    Nome = jsonUsuario['Nome'];
    ApiToken = jsonUsuario['ApiToken'];
  }

  Usuario.fromJson(Map<String, dynamic> json)
      : Nome = json['data']['Nome'],
        Email= json['data']['Email'],
        Senha= json['data']['Senha'],
        Admin = json['data']['Admin'] == 'true'? true: false,
        GrupoId = json['data']['GrupoId'],
        ApiToken = json['data']['ApiToken'];


  Map<String, dynamic> toJson() => {
        'name': Nome,
        'email': Email,
        'senha': Senha,
        'admin': Admin,
      };
}