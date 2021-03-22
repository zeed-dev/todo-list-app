import 'package:flutter_todo_list/models/category.dart';
import 'package:flutter_todo_list/repositories/repository.dart';

class CategoryService {
  Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  // Create Data
  saveCategory(Category category) async {
    return await _repository.insertData('categories', category.categoryMap());
  }

  // Read Data
  readCategory() async {
    return _repository.readData('categories');
  }
}
