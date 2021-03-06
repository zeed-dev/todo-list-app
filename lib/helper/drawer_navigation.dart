import 'package:flutter/material.dart';
import 'package:flutter_todo_list/screens/categories_screen.dart';
import 'package:flutter_todo_list/screens/home_screen.dart';
import 'package:flutter_todo_list/screens/todo_by_category.dart';
import 'package:flutter_todo_list/service/category_service.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _categoryList = [];

  CategoryService _categoryService = CategoryService();

  getAllcategory() async {
    _categoryList = [];
    List categories = await _categoryService.readCategory();
    categories.forEach((category) {
      setState(() {
        _categoryList.add(InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TodoByCategory(
                          category: category['name'],
                        )));
          },
          child: ListTile(
            title: Text(category['name']),
          ),
        ));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAllcategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://media-exp1.licdn.com/dms/image/C5603AQHPrDgwtrr2iA/profile-displayphoto-shrink_400_400/0/1614417397763?e=1622073600&v=beta&t=s3JXdKar034v_E3r1pz2Y_I0MdOQiBVWvXxAgA4kp5I'),
              ),
              accountName: Text("Muhammad Ziad"),
              accountEmail: Text("Zyx@gmail.com"),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text("Categories"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CatgoriesScreen())),
            ),
            Divider(),
            Column(
              children: _categoryList,
            )
          ],
        ),
      ),
    );
  }
}
