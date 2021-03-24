import 'package:flutter/material.dart';
import 'package:flutter_todo_list/models/todos.dart';
import 'package:flutter_todo_list/service/todo_service.dart';

class TodoByCategory extends StatefulWidget {
  final String category;
  TodoByCategory({
    this.category,
  });
  @override
  _TodoByCategoryState createState() => _TodoByCategoryState();
}

class _TodoByCategoryState extends State<TodoByCategory> {
  List<Todo> _todoList;
  TodoService _todoService = TodoService();

  getTodoByCategories() async {
    _todoList = [];
    List todos = await _todoService.readTodoByCategory(widget.category);
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
    getTodoByCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo By Category"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
          ),
        ],
      ),
    );
  }
}
