import 'messages.dart';
import 'produtos.dart';

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