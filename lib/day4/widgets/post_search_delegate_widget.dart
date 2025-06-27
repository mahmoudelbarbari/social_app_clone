import 'package:flutter/material.dart';

import '../models/post.dart';

class PostSearchDelegate extends SearchDelegate<Posts> {
  final List<Posts> posts;

  PostSearchDelegate(this.posts);

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(icon: Icon(Icons.clear), onPressed: () => query = ''),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () =>
        close(context, Posts(title: '', description: '', isFavorite: false)),
  );

  @override
  Widget buildResults(BuildContext context) {
    final results = posts
        .where((post) => post.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final post = results[index];
        return Card(
          child: ListTile(
            title: Text(post.title),
            subtitle: Text(post.description),
            trailing: Icon(
              post.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: post.isFavorite ? Colors.red : null,
            ),
            onTap: () => close(context, post),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = posts
        .where((post) => post.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final post = suggestions[index];
        return ListTile(
          title: Text(post.title),
          onTap: () {
            query = post.title;
            showResults(context);
          },
        );
      },
    );
  }
}
