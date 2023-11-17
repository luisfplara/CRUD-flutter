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