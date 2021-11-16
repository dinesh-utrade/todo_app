import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/todo/model/todo_info.dart';

class TodoDbService {
  static TodoDbService _instance;

  TodoDbService._internal() {
    init();
  }

  static TodoDbService getInstance() {
    if (_instance == null) {
      _instance = TodoDbService._internal();
    }
    return _instance;
  }

  final String tableName = "TodoTable";
  Database database;

  init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo_db.db');

    database =
        await openDatabase(path, version: 3, onCreate: (db, version) async {
      await db.execute(
          "create table $tableName (id integer primary key autoincrement,title text,detail text,date integer,isCompleted integer)");
      print("Table created !");
    });
  }

  Future<bool> createTodo(TodoInfo todoInfo) async {
    try {
      if (database != null) {
        database.insert(tableName, todoInfo.toMap());
        print("TodoDbService createTodo added successfully");
        return true;
      }
    } catch (e) {
      print("TodoDbService createTodo $e");
    }
    return false;
  }

  Future<List<TodoInfo>> getAllDueTodo() async {
    if (database == null) return [];

    List<Map<String, dynamic>> mapList =
        await database.rawQuery("Select * from $tableName where isCompleted=0");

    if (mapList == null) {
      return [];
    }

    List<TodoInfo> todoList = [];
    mapList.forEach((map) {
      todoList.add(TodoInfo.fromMap(map));
    });

    return todoList;
  }

  Future<List<TodoInfo>> getAllDoneTodo() async {
    if (database == null) return [];

    List<Map<String, dynamic>> mapList =
        await database.rawQuery("Select * from $tableName where isCompleted=1");

    if (mapList == null) {
      return [];
    }

    List<TodoInfo> todoList = [];
    mapList.forEach((map) {
      todoList.add(TodoInfo.fromMap(map));
    });

    return todoList;
  }

  Future<bool> markTodoComplete(int id) async {
    try {
      database
          .rawUpdate("update $tableName set isCompleted=1 where id = ?", [id]);
      print("TodoDbService markTodoDone updated");
      return true;
    } catch (e) {
      print("TodoDbService markTodoDone err:$e");
    }
    return false;
  }
}
