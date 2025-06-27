import 'package:flutter/material.dart';
import 'package:flutter_application_1/day4/models/post.dart';

class PostsScreen extends StatelessWidget {
  final List<Posts> posts;
  final Function(Posts) onFavoriteToggle;

  const PostsScreen({
    super.key,
    required this.posts,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: ListTile(
            title: Text(
              post.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(post.description),
            trailing: IconButton(
              icon: Icon(
                post.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: post.isFavorite ? Colors.red : null,
              ),
              onPressed: () => onFavoriteToggle(post),
            ),
          ),
        );
      },
    );
  }
}
