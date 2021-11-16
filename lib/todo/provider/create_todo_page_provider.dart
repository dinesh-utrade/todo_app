import 'package:flutter/cupertino.dart';
import 'package:todo_app/todo/model/todo_info.dart';
import 'package:todo_app/todo/service/todo_db_service.dart';

class CreateTodoPageProvider extends ChangeNotifier {
  bool isAdding = false;

  Future<bool> createTodo(TodoInfo todoInfo) async {
    isAdding = true;
    notifyListeners();
    bool status = await TodoDbService.getInstance().createTodo(todoInfo);
    isAdding = false;
    notifyListeners();
    return status;
  }
}
