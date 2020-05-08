class Usuario {
  //int usuarioId;
  String nome;
  String email;
  String senha;
  bool admin;

//String enderecoId;
//DateTime dateUltimoAcesso;
//int grupoId;
//bool excluido;

  Usuario(this.nome, this.email, this.senha, this.admin);

  Usuario.fromJson(Map<String, dynamic> json)
      : nome = json['name'],
        email = json['email'],
        senha = json['senha'],
        admin = json['admin'];

  Map<String, dynamic> toJson() => {
        'name': nome,
        'email': email,
        'senha': senha,
        'admin': admin,
      };
}