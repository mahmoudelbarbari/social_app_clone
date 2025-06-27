import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No posts found.'));
        }
        final posts = snapshot.data!.docs;
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            final data = post.data() as Map<String, dynamic>;
            final username = data['userName'] ?? data['userEmail'] ?? 'Unknown';
            final description = data['description'] ?? '';
            final base64Image = data['image'] ?? '';
            final imageWidget = base64Image.isNotEmpty
                ? Image.memory(
                    base64Decode(base64Image),
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : SizedBox.shrink();

            final commentCount = data['commentCount'] ?? 0;
            final likes = data['likes'] ?? 0;
            final List likedBy = data['likedBy'] ?? [];
            final isLiked =
                currentUser != null && likedBy.contains(currentUser.uid);

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(description),
                  ),
                  if (base64Image.isNotEmpty) imageWidget,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : null,
                          ),
                          onPressed: () async {
                            final postRef = FirebaseFirestore.instance
                                .collection('posts')
                                .doc(post.id);
                            if (isLiked) {
                              // Unlike
                              await postRef.update({
                                'likes': FieldValue.increment(-1),
                                'likedBy': FieldValue.arrayRemove([
                                  currentUser.uid,
                                ]),
                              });
                            } else {
                              // Like
                              await postRef.update({
                                'likes': FieldValue.increment(1),
                                'likedBy': FieldValue.arrayUnion([
                                  currentUser!.uid,
                                ]),
                              });
                            }
                          },
                        ),
                        Text('$likes'),
                        SizedBox(width: 20),
                        Icon(Icons.comment, size: 20),
                        SizedBox(width: 4),
                        Text('$commentCount Comments'),
                        Spacer(),
                        TextButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                final TextEditingController _commentController =
                                    TextEditingController();
                                return AlertDialog(
                                  title: Text('Add Comment'),
                                  content: TextField(
                                    controller: _commentController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your comment',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final commentText = _commentController
                                            .text
                                            .trim();
                                        if (commentText.isNotEmpty) {
                                          final user =
                                              FirebaseAuth.instance.currentUser;
                                          if (user != null) {
                                            await FirebaseFirestore.instance
                                                .collection('posts')
                                                .doc(post.id)
                                                .collection('comments')
                                                .add({
                                                  'text': commentText,
                                                  'userEmail': user.email ?? '',
                                                  'userName':
                                                      user.displayName ?? '',
                                                  'userId': user.uid,
                                                  'createdAt':
                                                      FieldValue.serverTimestamp(),
                                                });
                                            await FirebaseFirestore.instance
                                                .collection('posts')
                                                .doc(post.id)
                                                .update({
                                                  'commentCount':
                                                      FieldValue.increment(1),
                                                });
                                          }
                                        }
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Add'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.add_comment),
                          label: Text('Add Comment'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
