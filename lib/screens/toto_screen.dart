import 'package:flutter/material.dart';
import 'package:flutter_todo_list/models/todos.dart';
import 'package:flutter_todo_list/service/category_service.dart';
import 'package:flutter_todo_list/service/todo_service.dart';
import 'package:intl/intl.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _todoTitleController = TextEditingController();
  var _todoDescriptionController = TextEditingController();
  var _todoDateController = TextEditingController();

  var _selectedValue;
  List<DropdownMenuItem> _categories = [];
  DateTime _dateTime = DateTime.now();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  _selectedTodoDate(BuildContext context) async {
    var _pickDate = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_pickDate != null) {
      _dateTime = _pickDate;
      _todoDateController.text = DateFormat('yyyy-MM-dd').format(_dateTime);
    }
  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  _loadCategories() async {
    var _categoryServic = CategoryService();
    var categories = await _categoryServic.readCategory();
    categories.forEach((category) {
      setState(() {
        _categories.add(
          DropdownMenuItem(
            child: Text(category['name']),
            value: category['name'],
          ),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("Create Todo"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _todoTitleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "Write Todo Title",
                ),
              ),
              TextField(
                controller: _todoDescriptionController,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Write Todo Description",
                ),
              ),
              TextField(
                controller: _todoDateController,
                decoration: InputDecoration(
                  labelText: "Date",
                  hintText: "Pick a Date",
                  prefixIcon: InkWell(
                    onTap: () {
                      _selectedTodoDate(context);
                    },
                    child: Icon(Icons.calendar_today),
                  ),
                ),
              ),
              DropdownButtonFormField(
                value: _selectedValue,
                items: _categories,
                hint: Text('Category'),
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                    print(_selectedValue);
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: MaterialButton(
                  elevation: 0,
                  color: Colors.blue,
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    var todoObject = Todo();

                    todoObject.title = _todoTitleController.text;
                    todoObject.description = _todoDescriptionController.text;
                    todoObject.todoDate = _todoDateController.text;
                    todoObject.isFinished = 0;
                    todoObject.category = _selectedValue.toString();

                    var _todoService = TodoService();
                    var result = await _todoService.saveTodo(todoObject);

                    if (result > 0) {
                      _showSuccessSnackBar("Todos added");
                      _todoTitleController.clear();
                      _todoDescriptionController.clear();
                      _todoDateController.clear();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
