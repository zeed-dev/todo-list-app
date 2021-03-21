import 'package:flutter/material.dart';
import 'package:flutter_todo_list/models/category.dart';
import 'package:flutter_todo_list/screens/home_screen.dart';
import 'package:flutter_todo_list/service/category_service.dart';

class CatgoriesScreen extends StatefulWidget {
  @override
  _CatgoriesScreenState createState() => _CatgoriesScreenState();
}

class _CatgoriesScreenState extends State<CatgoriesScreen> {
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();

  @override
  Widget build(BuildContext context) {
    _showFormDialog(BuildContext context) {
      return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            actions: [
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
                color: Colors.red,
              ),
              MaterialButton(
                onPressed: () {
                  _category.name = _categoryNameController.text;
                  _category.description = _categoryDescriptionController.text;

                  _categoryService.saveCategory(_category);
                },
                child: Text("Save"),
                color: Colors.blue,
              ),
            ],
            title: Text("Categories Form"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _categoryNameController,
                    decoration: InputDecoration(
                      hintText: "Write a category",
                      labelText: "Category",
                    ),
                  ),
                  TextField(
                    controller: _categoryDescriptionController,
                    decoration: InputDecoration(
                      hintText: "Write a description",
                      labelText: "Description",
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: MaterialButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen())),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          elevation: 0,
        ),
        title: Text("Categories"),
      ),
      body: Center(
        child: Text("Categories Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
