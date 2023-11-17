class Products {
  Response? _response;

  Response? get response => _response;

  Products({
      Response? response}){
    _response = response;
}

  Products.fromJson(dynamic json) {
    _response = json['response'] != null ? Response.fromJson(json["response"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_response != null) {
      map["response"] = _response?.toJson();
    }
    return map;
  }

}


class Response {
  String? _status;
  List<Messages>? _messages;
  List<Produtos>? _produtos;

  String? get status => _status;
  List<Messages>? get messages => _messages;
  List<Produtos>? get produtos => _produtos;

  Response({
      String? status, 
      List<Messages>? messages, 
      List<Produtos>? produtos}){
    _status = status;
    _messages = messages;
    _produtos = produtos;
}

  Response.fromJson(dynamic json) {
    _status = json["status"];
    if (json["messages"] != null) {
      _messages = [];
      json["messages"].forEach((v) {
        _messages?.add(Messages.fromJson(v));
      });
    }
    if (json["produtos"] != null) {
      _produtos = [];
      json["produtos"].forEach((v) {
        _produtos?.add(Produtos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    if (_messages != null) {
      map["messages"] = _messages?.map((v) => v.toJson()).toList();
    }
    if (_produtos != null) {
      map["produtos"] = _produtos?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Produtos {
  int? _codigo;
  String? _codigoBarras;
  String? _descricao;
  double? _preco;

  int? get codigo => _codigo;
  String? get codigoBarras => _codigoBarras;
  String? get descricao => _descricao;
  double? get preco => _preco;


  Produtos({
      int? codigo,
      String? codigoBarras,
      String? descricao,
      double? preco,
     }){
    _codigo = codigo;
    _codigoBarras = codigoBarras;
    _descricao = descricao;
    _preco = preco;

}

  Produtos.fromJson(dynamic json) {
    _codigo = json["Codigo"];
    _codigoBarras = json["CodigoBarras"];
    _descricao = json["Descricao"];
    _preco = json["Preco"];

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Codigo"] = _codigo;
    map["CodigoBarras"] = _codigoBarras;
    map["Descricao"] = _descricao;
    map["Preco"] = _preco;
    return map;
  }

}



class Messages {
  String? _message;

  String? get message => _message;

  Messages({
      String? message}){
    _message = message;
}

  Messages.fromJson(dynamic json) {
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _message;
    return map;
  }

}