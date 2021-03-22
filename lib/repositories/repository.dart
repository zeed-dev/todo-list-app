import 'package:flutter_todo_list/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  DatabaseConnection _databaseConnection;

  Repository() {
    // initialize database connection
    _databaseConnection = DatabaseConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDataBase();
    return _database;
  }

  // Insert Data Into Table
  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  // Read Data
  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }
}
