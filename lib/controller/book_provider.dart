import 'dart:io';

import 'package:final_flutter/models/book_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/book.dart';
import '../views/new_book.dart';


class BookProvider extends ChangeNotifier {
  BookProvider() {
    getAllBooksFromDb();
  }

  List<Book>? allBooks;
  int id = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  File? imageFile;
  TextEditingController  descController = TextEditingController();
  TextEditingController  dateController = TextEditingController();

  List<Book> get favoriteBooks => allBooks!.where((book) => book.isFavorite!).toList();


  getAllBooksFromDb() async {
    allBooks = await BookHelper.bookHelper.getAllBooks();
    notifyListeners();
  }

  Future<void> selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
      notifyListeners();
    }
  }

  insertNewBook() async {
    Book book = Book(
      name: nameController.text,
      author: authorController.text,
      image: imageFile?.path,
      description: descController.text,
      date: dateController.text
    );
    int newId = await BookHelper.bookHelper.insertNewBook(book);
    book.id = newId;
    allBooks!.add(book);
    notifyListeners();
  }

  deleteBookFromDb(int id) async {
    await BookHelper.bookHelper.deleteBook(id);
    allBooks!.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  navigateToEditScreen(Book book, BuildContext context) {
    nameController.text = book.name ?? '';
    authorController.text = book.author ?? '';
    descController.text = book.description ?? '';
    dateController.text = book.date ?? '';
   // imageFile = book.image! as File?;
    id = book.id!;
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return NewBook(false);
    }));
  }

  updateBook() async {
    Book book = Book(
      id: id,
      name: nameController.text,
      author: authorController.text,
      image: imageFile?.path,
      description: descController.text,
      date: dateController.text

    );
    await BookHelper.bookHelper.updateBook(book);
    getAllBooksFromDb();
  }
  void toggleFavorite(Book book) {
    final updatedBook = allBooks!.firstWhere((b) => b.id == book.id);
    updatedBook.isFavorite = !updatedBook.isFavorite!;
    notifyListeners();
  }
}
