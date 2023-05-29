import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/book_provider.dart';
import '../models/book.dart';
import 'book_detailes.dart';

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem(this.book, {Key? key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsPage(book: book),
          ),
        );
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("ماذا تريد أن تفعل ",textAlign: TextAlign.right,),
              content: const Text("هل ترغب في حذف الكتاب ",textAlign: TextAlign.right,),
              actions: [
                TextButton(
                  child: const Text("حذف"),
                  onPressed: () async {
                    await  Provider.of<BookProvider>(context, listen: false)
                        .deleteBookFromDb(book.id!);
                    Navigator.of(context).pop(); // إغلاق مربع الحوار
                  },
                ),


              ],
            );
          },
        );
      },
      child: Card(
        child: Stack(
          children: [
            _buildImage(),
            Positioned(
              top: 2,
              right: 8,
              child: IconButton(icon: const Icon(Icons.edit,color: Colors.purpleAccent,
              ), onPressed: () {
                Provider.of<BookProvider>(context, listen: false)
                    .navigateToEditScreen(book, context);
              },
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  book.name!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ),
            ),
            Positioned(
              bottom: 2,
              right: 8,
              child: IconButton(icon: Icon(
                book.isFavorite! ? Icons.favorite : Icons.favorite_border,
                color: book.isFavorite! ? Colors.red : null,
              ), onPressed: () {
                Provider.of<BookProvider>(context, listen: false).toggleFavorite(book);
              },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (book.image != null) {
      return Image.file(
        File(book.image!),
        fit: BoxFit.cover,
        height: 150,
      );
    } else {
      return Image.asset(
        'assets/images/book.jpg',
        fit: BoxFit.cover,
        height: 150,
      );
    }
  }
}
