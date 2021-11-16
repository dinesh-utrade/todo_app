import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/todo/view/page/create_todo_page.dart';
import 'package:todo_app/todo/view/page/done_todo_page.dart';
import 'package:todo_app/todo/view/page/due_todo_page.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentPage = 0;

  GlobalKey bottomNavigationKey = GlobalKey();

  List<Widget> listWidget = [
    DueTodoPage(),
    DoneTodoPage(),
    CreateTodoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listWidget[currentPage],
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(
            iconData: Icons.home,
            title: "Due Tasks",
          ),
          TabData(
            iconData: Icons.done,
            title: "Done Tasks",
          ),
          TabData(
            iconData: Icons.add,
            title: "Create",
          ),
          //  TabData(iconData: Icons.shopping_cart, title: "Basket")
        ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }
}
