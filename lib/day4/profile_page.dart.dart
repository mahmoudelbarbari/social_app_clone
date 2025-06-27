import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String userDescription = 'Flutter enthusiast and app developer.';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? 'No Name';
      userEmail = prefs.getString('email') ?? 'No Email';
      userJob = prefs.getString('job') ?? '';
      userAddress = prefs.getString('address') ?? '';
      userPhone = prefs.getString('phone') ?? '';
      userGender = prefs.getString('gender') ?? '';
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
          Center(
            child: Text(
              userName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              userEmail,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
          SizedBox(height: 16),
          Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Job'),
              subtitle: Text(userJob),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text('Address'),
              subtitle: Text(userAddress),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
              subtitle: Text(userPhone),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Gender'),
              subtitle: Text(userGender),
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
            children: [
              _buildStatCard('Posts', widget.allPosts.length, Icons.article),
              _buildStatCard(
                'Favorites',
                widget.favoritePosts.length,
                Icons.favorite,
              ),
            ],
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
