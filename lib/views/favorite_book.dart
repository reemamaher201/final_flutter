import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/book_provider.dart';

class FavoriteBook extends StatelessWidget {
  const FavoriteBook({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final favoriteBooks = bookProvider.favoriteBooks;

    if (favoriteBooks.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("المفضلة"),
        ),
        body: const Center(
          child: Text("لا توجد كتب مفضلة"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("المفضلة"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: favoriteBooks.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.file(
                File(favoriteBooks[index].image!),
                fit: BoxFit.cover,
                width: 80,
                height: double.infinity,
              ),
              title: Text(favoriteBooks[index].name!),
              trailing: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {
                  bookProvider.toggleFavorite(favoriteBooks[index]);
                },
              ),
              onTap: () {
                // افعل أي شيء تحتاجه عند النقر على العنصر
              },
            ),
          );
        },
      ),
    );
  }
}
