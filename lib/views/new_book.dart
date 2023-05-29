import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../controller/book_provider.dart';




class NewBook extends StatelessWidget {
  final bool isNewBook;
  NewBook([this.isNewBook = true]);

  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, provider, x) {
        return Scaffold(
          appBar: AppBar(
            title: Text(isNewBook ? "New Book Screen" : "Update Book"),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: provider.selectImage,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: provider.imageFile != null
                            ? ClipOval(
                          child: Image.file(
                            provider.imageFile!,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Icon(
                          Icons.add_photo_alternate,
                          size: 60,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: provider.nameController,
                      decoration: InputDecoration(
                        labelText: "Enter the Book name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: provider.authorController,
                      decoration: InputDecoration(
                        labelText: "Enter the author name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: provider.dateController,
                      decoration: InputDecoration(
                        labelText: "Enter the date",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: provider.descController,
                      decoration: InputDecoration(
                        labelText: "Enter the description",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (isNewBook) {
                          provider.insertNewBook();
                        } else {
                          provider.updateBook();
                        }
                      },
                      child: Text(isNewBook ? "Insert New Book" : "Update Book"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop("hello");
                      },
                      child: const Text("Back to previous page"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
