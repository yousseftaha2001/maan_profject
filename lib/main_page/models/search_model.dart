
class SearchModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Options>? options;

  SearchModel({this.status, this.errNum, this.msg, this.options});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    errNum = json["errNum"];
    msg = json["msg"];
    options = json["Options"] == null ? null : (json["Options"] as List).map((e) => Options.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["errNum"] = errNum;
    _data["msg"] = msg;
    if(options != null) {
      _data["Options"] = options?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Options {
  String? code;
  String? id;
  String? name;

  Options({this.code, this.id, this.name});

  Options.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    id = json["id"].toString();
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    _data["id"] = id;
    _data["name"] = name;
    return _data;
  }
}