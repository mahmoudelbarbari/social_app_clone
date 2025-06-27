import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/day4/models/post.dart';

class ProfilePage extends StatefulWidget {
  final List<Posts> allPosts;
  final List<Posts> favoritePosts;
  final VoidCallback goToPosts;
  final VoidCallback goToFavorites;
  final VoidCallback goToAddPost;

  const ProfilePage({
    super.key,
    required this.allPosts,
    required this.favoritePosts,
    required this.goToPosts,
    required this.goToFavorites,
    required this.goToAddPost,
  });

  @override
  State<ProfilePage> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfilePage> {
  String userName = '';
  String userEmail = '';
  String userJob = '';
  String userAddress = '';
  String userPhone = '';
  String userGender = '';
  int userLikes = 0;
  String userDescription = 'Flutter enthusiast and app developer.';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    int totalLikes = 0;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('userId', isEqualTo: currentUser!.uid)
        .get();
    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      final List likedBy = data['likedBy'] ?? [];
      totalLikes += likedBy.length;
    }
    setState(() {
      userName = currentUser.displayName ?? 'No Name';
      userEmail = currentUser.email ?? "No Email";
      userLikes = totalLikes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'posts') {
                Navigator.pop(context);
                widget.goToPosts();
              }
              if (value == 'favorites') {
                Navigator.pop(context);
                widget.goToFavorites();
              }
              if (value == 'add') {
                Navigator.pop(context);
                widget.goToAddPost();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'posts', child: Text('Go to Posts')),
              PopupMenuItem(
                value: 'favorites',
                child: Text('Go to Favorite Posts'),
              ),
              PopupMenuItem(value: 'add', child: Text('Add New Post')),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage('assets/images/dd.png'),
              child: Icon(Icons.person, size: 48),
            ),
          ),
          SizedBox(height: 16),
          Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Name'),
              subtitle: Text(userName),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text(userEmail),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(userDescription, style: TextStyle(fontSize: 16)),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [_buildStatCard('Likes', userLikes, Icons.favorite)],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, int count, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          children: [
            Icon(icon, color: Colors.deepPurple),
            SizedBox(height: 8),
            Text(
              '$count',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(label, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
