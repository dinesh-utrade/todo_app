import 'package:flutter/material.dart';
import 'package:todo_app/todo/model/todo_info.dart';
import 'package:todo_app/todo/service/todo_db_service.dart';

class DoneTodoPageProvider extends ChangeNotifier {
  Future<List<TodoInfo>> getAllDoneTodo() async {
    return await TodoDbService.getInstance().getAllDoneTodo();
  }
}
