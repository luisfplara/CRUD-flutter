// To parse this JSON data, do
//
//     final resposeLogin = resposeLoginFromJson(jsonString);

import 'dart:convert';

ResposeLogin resposeLoginFromJson(String str) => ResposeLogin.fromJson(json.decode(str));

String resposeLoginToJson(ResposeLogin data) => json.encode(data.toJson());

class ResposeLogin {
  ResposeLogin({
    required this.response,
  });

  Response response;

  factory ResposeLogin.fromJson(Map<String, dynamic> json) => ResposeLogin(
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
  };
}

class Response {
  Response({
    required this.status,
    required this.messages,
    required this.token,
    required this.tokenExpiration,
  });

  String status;
  List<Message> messages;
  String token;
  String tokenExpiration;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    status: json["status"],
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    token: json["token"],
    tokenExpiration: json["tokenExpiration"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
    "token": token,
    "tokenExpiration": tokenExpiration,
  };
}

class Message {
  Message({
    required this.message,
  });

  String message;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
