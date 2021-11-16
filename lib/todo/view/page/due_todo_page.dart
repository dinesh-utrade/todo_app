import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo/model/todo_info.dart';
import 'package:todo_app/todo/provider/due_todo_page_provider.dart';
import 'package:todo_app/todo/view/widget/todo_list_row_widget.dart';

class DueTodoPage extends StatefulWidget {
  @override
  _DueTodoPageState createState() => _DueTodoPageState();
}

class _DueTodoPageState extends State<DueTodoPage> {
  DueTodoPageProvider _provider;

  List<TodoInfo> todoInfoList = [];

  @override
  void initState() {
    _provider = DueTodoPageProvider();

    _provider.getAllDueTodoInfo().then((value) {
      todoInfoList = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: ChangeNotifierProvider<DueTodoPageProvider>(
        create: (ctx) => _provider,
        child: Builder(
          builder: (ctx) {
            return Container(
              child: Consumer<DueTodoPageProvider>(
                builder: (ctx, provider, child) {
                  return ListView.separated(
                      itemBuilder: (ctx, index) {
                        TodoInfo todoInfo = todoInfoList[index];
                        if (!todoInfo.isCompleted) {
                          return TodoListRowWidget(
                            todoInfo: todoInfo,
                            callback: () {
                              markTodoComplete(todoInfo);
                            },
                          );
                        }
                        return Container();
                      },
                      separatorBuilder: (ctx, index) {
                        return Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width - 32,
                          color: Colors.black26,
                        );
                      },
                      itemCount: todoInfoList.length);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future markTodoComplete(TodoInfo todoInfo) async {
    _provider.markTodoComplete(todoInfo);
  }
}
