import 'package:flutter/cupertino.dart';

class TodoInfo {
  int id;
  String title;
  String detail;
  int date;
  bool isCompleted;

  TodoInfo(
      {@required this.title,
      @required this.detail,
      this.id,
      this.date,
      this.isCompleted = false});

  TodoInfo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    detail = map['detail'];
    date = map['date'];
    isCompleted = map['isCompleted'] == 1 ? true : false;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['id'] = id;
    map['title'] = title;
    map['detail'] = detail;
    map['date'] = date;
    map['isCompleted'] = isCompleted;
    return map;
  }
}
