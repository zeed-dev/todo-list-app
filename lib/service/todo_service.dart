import 'package:flutter_todo_list/models/todos.dart';
import 'package:flutter_todo_list/repositories/repository.dart';

class TodoService {
  Repository _repository;

  TodoService() {
    _repository = Repository();
  }

  saveTodo(Todo todo) async {
    return await _repository.insertData("todos", todo.todoMap());
  }

  readData() async {
    return await _repository.readData("todos");
  }

  readTodoByCategory(category) async {
    return await _repository.readDataByColumName("todos", "category", category);
  }
}
