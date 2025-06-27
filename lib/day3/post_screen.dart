import 'package:flutter/material.dart';
import 'package:flutter_application_1/day3/models/post.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final List<Post> posts = [
    Post(1, "Space", "https://i.ibb.co/Fb55dzRZ/7.jpg"),
    Post(2, "Ice", "https://i.ibb.co/60HnvFcS/1.jpg"),
    Post(3, "Calme", "https://i.ibb.co/mrr7HkhT/3.jpg"),
    Post(4, "Space", "https://i.ibb.co/fd8v0nDQ/6.jpg"),
    Post(5, "Space", "https://i.ibb.co/mrr7HkhT/3.jpg"),
  ];
  @override
  Widget build(BuildContext context) {
    return posts.isEmpty
        ? Center(
            child: Text(
              "No posts available :(",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.all(12),
            itemCount: posts.length,
            separatorBuilder: (context, index) => SizedBox(height: 16),
            itemBuilder: (context, index) {
              final post = posts[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.network(
                        post.photo ?? '',
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Text(
                        post.title ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
