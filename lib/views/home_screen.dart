import 'package:final_flutter/controller/book_provider.dart';
import 'package:final_flutter/views/book_item.dart';
import 'package:final_flutter/views/new_book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<BookProvider>(builder: (context, pr, x) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
           child: const Icon(Icons.add),
              onPressed: () async {
                // pr.convertListToString();
                dynamic x = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return NewBook();
                }));

              }),
          appBar: AppBar(
            title: const Text("Book Library"),
          ),
          body: pr.allBooks == null
              ? const SizedBox()
              : GridView.builder(
              itemCount: pr.allBooks!.length,
              itemBuilder: (context, index) {
                return BookItem(pr.allBooks![index]);
              }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // عدد الأعمدة في الجريد
             // نسبة عرض العنصر لارتفاعه
          ),));
    });
  }
}


