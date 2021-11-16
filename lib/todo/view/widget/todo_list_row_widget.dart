import 'package:flutter/material.dart';
import 'package:todo_app/todo/model/todo_info.dart';

class TodoListRowWidget extends StatelessWidget {
  final TodoInfo todoInfo;
  final Function callback;

  TodoListRowWidget({@required this.todoInfo, @required this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todoInfo.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text("14 Nov 2021")
                ],
              ),
              InkWell(
                onTap: callback,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.done,
                    color: todoInfo.isCompleted
                        ? Colors.green
                        : IconTheme.of(context).color,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
