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
  var _editCategoryNameController = TextEditingController();
  var _editCategoryDescriptionController = TextEditingController();

  var category;

  var _category = Category();
  var _categoryService = CategoryService();

  List<Category> _categoryList = [];

  getAllCategory() async {
    _categoryList = [];
    var categories = await _categoryService.readCategory();
    categories.forEach((cat) {
      setState(() {
        var categoryModel = Category();
        categoryModel.id = cat['id'];
        categoryModel.name = cat['name'];
        categoryModel.description = cat['description'];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      _editCategoryNameController.text = category[0]['name'] ?? 'No Name';
      _editCategoryDescriptionController.text =
          category[0]['description'] ?? 'No Desc';
    });
    _editFormDialog(context);
  }

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
              onPressed: () async {
                _category.name = _categoryNameController.text;
                _category.description = _categoryDescriptionController.text;
                var result = await _categoryService.saveCategory(_category);

                if (result > 0) {
                  Navigator.pop(context);
                  getAllCategory();
                }
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

  _editFormDialog(BuildContext context) {
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
              onPressed: () async {
                _category.id = category[0]['id'];
                _category.name = _editCategoryNameController.text;
                _category.description = _editCategoryDescriptionController.text;

                var result = await _categoryService.updateCategory(_category);
                if (result > 0) {
                  Navigator.pop(context);
                  getAllCategory();
                  _showSuccessSnackBar("Category Updated");
                }
              },
              child: Text("Update"),
              color: Colors.blue,
            ),
          ],
          title: Text("Categories Form"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _editCategoryNameController,
                  decoration: InputDecoration(
                    hintText: "Write a category",
                    labelText: "Category",
                  ),
                ),
                TextField(
                  controller: _editCategoryDescriptionController,
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

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          actions: [
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
              color: Colors.green,
            ),
            MaterialButton(
              onPressed: () async {
                var result = await _categoryService.deleteCategory(categoryId);
                if (result > 0) {
                  Navigator.pop(context);
                  getAllCategory();
                  _showSuccessSnackBar("Category Deleted");
                }
              },
              child: Text("Delete"),
              color: Colors.red,
            ),
          ],
          title: Text("Are you sure you want to delete this?"),
        );
      },
    );
  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  @override
  void initState() {
    super.initState();
    getAllCategory();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
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
      body: ListView.builder(
        itemCount: _categoryList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              top: 8,
              left: 16,
              right: 16,
            ),
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editCategory(context, _categoryList[index].id);
                  },
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_categoryList[index].name),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        _deleteFormDialog(context, _categoryList[index].id);
                      },
                    ),
                  ],
                ),
                subtitle: Text(_categoryList[index].description),
              ),
            ),
          );
        },
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
