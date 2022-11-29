class MatchRoomModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Options>? options;
  Room? room;

  MatchRoomModel({this.status, this.errNum, this.msg, this.options, this.room});

  MatchRoomModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    errNum = json["errNum"];
    msg = json["msg"];
    options = json["Options"] == null
        ? null
        : (json["Options"] as List).map((e) => Options.fromJson(e)).toList();
    room = json["room"] == null ? null : Room.fromJson(json["room"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["errNum"] = errNum;
    _data["msg"] = msg;
    if (options != null) {
      _data["Options"] = options?.map((e) => e.toJson()).toList();
    }
    if (room != null) {
      _data["room"] = room?.toJson();
    }
    return _data;
  }
}

class Room {
  dynamic id;
  String? text;
  dynamic type;
  dynamic lId;
  dynamic stute;
  String? createdAt;
  String? updatedAt;

  Room(
      {this.id,
      this.text,
      this.type,
      this.lId,
      this.stute,
      this.createdAt,
      this.updatedAt});

  Room.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    text = json["text"];
    type = json["type"];
    lId = json["l_id"];
    stute = json["stute"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["text"] = text;
    _data["type"] = type;
    _data["l_id"] = lId;
    _data["stute"] = stute;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}

class Options {
  String? code;
  dynamic id;
  String? name;

  Options({this.code, this.id, this.name});

  Options.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    id = json["id"];
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
