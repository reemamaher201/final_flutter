import 'dart:developer';
import 'package:sqflite/sqflite.dart';

import 'book.dart';

class BookHelper {
  BookHelper._();
  static BookHelper bookHelper = BookHelper._();
  late Database database;
  initDb() async {
    String dirPath = await getDatabasesPath();
    String dbPath = "$dirPath/Library.db";
    database = await openDatabase(dbPath, version: 1, onCreate: (db, v) {
      db.execute(
          'CREATE TABLE books (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, author Text ,image Text, description Text , date Text ,isFavorite int)');
    });
  }

  Future<int> insertNewBook(Book book) async {
    try {
      int rowId = await database.insert('books', book.toMap());
      return rowId;
    } on Exception catch (e) {
      return 0;
    }
  }
  Future<List<Book>> getAllBooks() async {
    List<Map<String, dynamic>> results = await database.query('books');

    List<Book> books = results.map((e) => Book.fromMap(e)).toList();
    return books;
  }



  deleteBook(int id) async {
    database.delete("books", where: "id=$id");
  }

  updateBook(Book newBook) async {
    log(newBook.toMap().toString());
    log(newBook.id.toString());
    database.update("books", newBook.toMap(),
        where: "id=?", whereArgs: [newBook.id]);
  }
}