import 'package:flutter/cupertino.dart';
import 'package:todo_app/todo/model/todo_info.dart';
import 'package:todo_app/todo/service/todo_db_service.dart';

class DueTodoPageProvider extends ChangeNotifier {
  Future<List<TodoInfo>> getAllDueTodoInfo() async {
    return await TodoDbService.getInstance().getAllDueTodo();
  }

  Future markTodoComplete(TodoInfo todoInfo) async {
    bool isUpdated =
        await TodoDbService.getInstance().markTodoComplete(todoInfo.id);
    if (isUpdated) {
      todoInfo.isCompleted = true;
      notifyListeners();
    }
  }
}
