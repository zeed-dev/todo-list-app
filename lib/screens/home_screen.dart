import 'package:flutter/material.dart';
import 'package:flutter_todo_list/helper/drawer_navigation.dart';
import 'package:flutter_todo_list/screens/toto_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List App"),
      ),
      drawer: DrawerNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => TodoScreen())),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
