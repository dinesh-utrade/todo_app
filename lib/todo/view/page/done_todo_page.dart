import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo/model/todo_info.dart';
import 'package:todo_app/todo/provider/done_todo_page_provider.dart';
import 'package:todo_app/todo/view/widget/todo_list_row_widget.dart';

class DoneTodoPage extends StatefulWidget {
  @override
  _DoneTodoPageState createState() => _DoneTodoPageState();
}

class _DoneTodoPageState extends State<DoneTodoPage> {
  DoneTodoPageProvider _provider;

  List<TodoInfo> todoInfoList = [];

  @override
  void initState() {
    _provider = DoneTodoPageProvider();

    _provider.getAllDoneTodo().then((value) {
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
      body: ChangeNotifierProvider<DoneTodoPageProvider>(
        create: (ctx) => _provider,
        child: Builder(
          builder: (ctx) {
            return Container(
              child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    TodoInfo todoInfo = todoInfoList[index];
                    return Consumer<DoneTodoPageProvider>(
                      builder: (ctx, provider, child) {
                        return TodoListRowWidget(
                          todoInfo: todoInfo,
                          callback: () {
                            // markTodoComplete(todoInfo);
                          },
                        );
                      },
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width - 32,
                      color: Colors.black26,
                    );
                  },
                  itemCount: todoInfoList.length),
            );
          },
        ),
      ),
    );
  }
}
