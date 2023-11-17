// To parse this JSON data, do
//
//     final requestLogin = requestLoginFromJson(jsonString);

import 'dart:convert';

RequestLogin requestLoginFromJson(String str) => RequestLogin.fromJson(json.decode(str));

String requestLoginToJson(RequestLogin data) => json.encode(data.toJson());

class RequestLogin {
  RequestLogin({
    required this.usuario,
    required this.senha,
  });

  String usuario;
  String senha;

  factory RequestLogin.fromJson(Map<String, dynamic> json) => RequestLogin(
    usuario: json["usuario"],
    senha: json["senha"],
  );

  Map<String, dynamic> toJson() => {
    "usuario": usuario,
    "senha": senha,
  };
}
