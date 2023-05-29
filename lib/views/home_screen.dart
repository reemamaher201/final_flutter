import 'package:final_flutter/controller/book_provider.dart';
import 'package:final_flutter/views/book_item.dart';
import 'package:final_flutter/views/new_book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import 'favorite_book.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, pr, x) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              dynamic newBook = await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return NewBook();
              }));
            },
          ),
          appBar: AppBar(
            title: const Text("Book Library"),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: BookSearchDelegate(pr.allBooks),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteBook(),
                    ),
                  );
                }
                ,
              ),
            ],
          ),
          body: pr.allBooks == null
              ? const SizedBox()
              : GridView.builder(
            itemCount: pr.allBooks!.length,
            itemBuilder: (context, index) {
              return BookItem(pr.allBooks![index]);
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
          ),
        );
      },
    );
  }
}

class BookSearchDelegate extends SearchDelegate<Book> {
  final List<Book>? books;

  BookSearchDelegate(this.books);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, Book());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = books!.where((book) => book.name!.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index].name!),
          onTap: () {
            close(context, results[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = books!.where((book) => book.name!.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index].name!),
          onTap: () {
            close(context, results[index]);
          },
        );
      },
    );
  }
}
