import 'package:flutter/material.dart';
import 'package:to_do_app/ui/home/add_todo_bottomsheet.dart';
import 'package:to_do_app/ui/home/settings_tab.dart';
import 'package:to_do_app/ui/home/todo_list_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: tabs[currentIndex],
        appBar: AppBar(
          elevation: 0,
          title: Text('JO ToDo App'),
        ),
        floatingActionButton: FloatingActionButton(
          shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 3)),
          elevation: 0,
          child: Icon(Icons.add),
          onPressed: () {
            showAddToDoSheet();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              currentIndex = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(label: '', icon: Icon(Icons.list)),
              BottomNavigationBarItem(label: '', icon: Icon(Icons.settings))
            ],
          ),
          clipBehavior: Clip.antiAlias,
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
        ));
  }

  List<Widget> tabs = [TodoListTab(), SettindsTab()];

  void showAddToDoSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return AddToDOBottomSheet();
        });
  }
}
