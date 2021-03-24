import 'package:flutter/material.dart';
import 'package:flutter_todo_list/helper/drawer_navigation.dart';
import 'package:flutter_todo_list/models/todos.dart';
import 'package:flutter_todo_list/screens/toto_screen.dart';
import 'package:flutter_todo_list/service/todo_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoService _todoService;

  List<Todo> _todoList = [];

  getAllTodos() async {
    _todoService = TodoService();
    _todoList = [];

    List todos = await _todoService.readData();
    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.todoDate = todo['todoDate'];
        model.category = todo['category'];
        model.isFinished = todo['isFinished'];
        _todoList.add(model);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List App"),
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(_todoList[index].title),
                subtitle: Text(_todoList[index].description),
                trailing: Text(_todoList[index].todoDate),
              ),
            ),
          );
        },
      ),
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
