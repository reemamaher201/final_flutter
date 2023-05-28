import 'dart:io';

import 'package:flutter/material.dart';
import '../models/book.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;

  const BookDetailsPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الكتاب'),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(
              File(book.image!),
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 16),
            Text(
              book.name!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              book.author!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            // يمكنك إضافة المزيد من تفاصيل الكتاب هنا
          ],
        ),
      ),
    );
  }
}
