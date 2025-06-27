// FavoritePostsScreen Widget
import 'package:flutter/material.dart';
import 'package:flutter_application_1/day4/models/post.dart';

class FavPostsScreen extends StatelessWidget {
  final List<Posts> favorites;
  final Function(Posts) onFavoriteToggle;

  const FavPostsScreen({
    super.key,
    required this.favorites,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return Center(child: Text('No favorite posts.'));
    }
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final post = favorites[index];
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
