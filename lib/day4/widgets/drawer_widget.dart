import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/day4/auth/login_page.dart';
import 'package:flutter_application_1/day4/models/post.dart';
import 'package:flutter_application_1/day4/profile_page.dart.dart';

class NavigationDrawerr extends StatefulWidget {
  final List<Posts> allPosts;
  final List<Posts> favoritePosts;
  final VoidCallback goToPosts;
  final VoidCallback goToFavorites;
  final VoidCallback goToAddPost;
  const NavigationDrawerr({
    super.key,
    required this.allPosts,
    required this.favoritePosts,
    required this.goToPosts,
    required this.goToFavorites,
    required this.goToAddPost,
  });

  @override
  State<NavigationDrawerr> createState() => _NavigationDrawerrState();
}

class _NavigationDrawerrState extends State<NavigationDrawerr> {
  String? username;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      username = user!.displayName ?? 'Anonymous user';
      userEmail = user.email ?? 'Anonymous user';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SingleChildScrollView(
            child: Column(children: <Widget>[buildMenuItems(context)]),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) => Wrap(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: CircleAvatar(
            radius: 50,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: ClipOval(child: Image.asset("assets/images/dd.png")),
            ),
          ),
        ),
      ),
      const SizedBox(height: 11),
      Align(
        alignment: const Alignment(0, 0),
        child: Text(
          username ?? "",
          style: const TextStyle(
            wordSpacing: 2,
            fontWeight: FontWeight.w700,
            height: 1,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ),
      Align(
        alignment: const Alignment(0, 0),
        child: Text(
          userEmail ?? "",
          style: const TextStyle(
            wordSpacing: 5,
            height: 2,
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ),
      ListTile(
        title: const Text('Profile'),
        leading: const Icon(Icons.manage_accounts),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProfilePage(
                allPosts: widget.allPosts,
                favoritePosts: widget.favoritePosts,
                goToPosts: widget.goToPosts,
                goToFavorites: widget.goToFavorites,
                goToAddPost: widget.goToAddPost,
              ),
            ),
          );
        },
      ),

      const Divider(thickness: 1, indent: 20, endIndent: 20),
      ListTile(
        leading: const Icon(Icons.logout_outlined),
        title: const Text('Log out', style: TextStyle(fontSize: 14)),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Logout"),
                content: const Text("Are you sure you want to logout?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    child: const Text("Confirm"),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    ],
  );
}
