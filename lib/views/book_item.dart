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
              content: const Text("هل ترغب في حذف الكتاب أم تعديله؟",textAlign: TextAlign.right,),
              actions: [
                TextButton(
                  child: const Text("حذف"),
                  onPressed: () async {
                    await Provider.of<BookProvider>(context, listen: false)
                        .deleteBookFromDb(book.id!);
                    Navigator.of(context).pop(); // إغلاق مربع الحوار
                  },
                ),

                TextButton(
                  child: const Text("تعديل"),
                  onPressed: () {
                    // اتخذ إجراء التعديل هنا
                    Provider.of<BookProvider>(context, listen: false)
                        .navigateToEditScreen(book, context);

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
              bottom: 8,
              right: 8,
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
