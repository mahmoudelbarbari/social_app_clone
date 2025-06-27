import 'package:flutter/material.dart';
import 'package:flutter_application_1/day4/models/post.dart';

class MyPostScreen extends StatefulWidget {
  final List<Posts> myPosts;
  final Function(Posts) onAddPost;

  const MyPostScreen({
    super.key,
    required this.myPosts,
    required this.onAddPost,
  });

  @override
  State<MyPostScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  void _handleAddPost() {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();
    if (title.isNotEmpty && desc.isNotEmpty) {
      final newPost = Posts(title: title, description: desc);
      widget.onAddPost(newPost);
      _titleController.clear();
      _descController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _descController,
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          ElevatedButton(onPressed: _handleAddPost, child: Text('Add Post')),
          SizedBox(height: 24),
          Expanded(
            child: widget.myPosts.isEmpty
                ? Center(child: Text('No posts yet.'))
                : ListView.builder(
                    itemCount: widget.myPosts.length,
                    itemBuilder: (context, index) {
                      final post = widget.myPosts[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(
                            post.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(post.description),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
