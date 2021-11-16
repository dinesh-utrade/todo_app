import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo/model/todo_info.dart';
import 'package:todo_app/todo/provider/create_todo_page_provider.dart';

class CreateTodoPage extends StatefulWidget {
  @override
  _CreateTodoPageState createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  TextEditingController _titleController;
  TextEditingController _detailController;
  CreateTodoPageProvider provider;

  @override
  void initState() {
    _titleController = TextEditingController();
    _detailController = TextEditingController();
    provider = CreateTodoPageProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateTodoPageProvider>(
      create: (context) => provider,
      child: Builder(
        builder: (ctx) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(hintText: "Title"),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _detailController,
                    maxLines: 8,
                    decoration: InputDecoration(hintText: "Detail"),
                  ),
                  SizedBox(height: 32),
                  Consumer<CreateTodoPageProvider>(
                    builder: (ctx, provider, widget) {
                      return ElevatedButton(
                          onPressed: provider.isAdding
                              ? null
                              : () {
                                  createTodo(provider);
                                },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            child: Text("Add"),
                          ));
                    },
                  )
                ],
              )),
            ),
          );
        },
      ),
    );
  }

  Future createTodo(CreateTodoPageProvider provider) async {
    String title = _titleController.text;
    String detail = _detailController.text;
    int date = DateTime.now().millisecondsSinceEpoch;
    bool status = await provider
        .createTodo(TodoInfo(title: title, detail: detail, date: date));
    if (status) {
      _titleController.text = "";
      _detailController.text = "";
    } else {
      //
    }
  }
}
