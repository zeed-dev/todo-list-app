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

  // Read Data from table
  readCategory() async {
    return _repository.readData('categories');
  }

  // Read Data from table by id
  readCategoryById(categoryId) async {
    return await _repository.readDataById('categories', categoryId);
  }

  // Update Data from table
  updateCategory(Category category) async {
    return await _repository.updateData('categories', category.categoryMap());
  }

  deleteCategory(categoryId) async {
    return await _repository.deleteData('categories', categoryId);
  }
}
