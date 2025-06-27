import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/day3/widgets/add_post_widget.dart';
import 'package:flutter_application_1/day4/fav_posts_screen.dart';
import 'package:flutter_application_1/day4/models/post.dart';
import 'package:flutter_application_1/day4/my_post_screen.dart';
import 'package:flutter_application_1/day4/posts_screen.dart';
import 'package:flutter_application_1/day4/widgets/drawer_widget.dart';

import 'widgets/post_search_delegate_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final List<Posts> _myPosts = [];
  late TabController _tabController;
  final List<String> tabNames = ['Posts', 'Favorite Posts', 'My Posts'];

  final List<Posts> _posts = [
    Posts(title: 'Flutter Basics', description: 'Learn the basics of Flutter.'),
    Posts(
      title: 'State Management',
      description: 'Understand state management in Flutter.',
    ),
    Posts(
      title: 'Networking',
      description: 'How to fetch data from the internet.',
    ),
    Posts(title: 'Animations', description: 'Add animations to your app.'),
    Posts(title: 'Persistence', description: 'Save data locally in your app.'),
  ];

  List<Posts> _filteredPosts = [];
  List<Posts> _filteredFavorites = [];

  String appBarTitle = 'Posts';

  void _addPost(Posts post) {
    setState(() {
      _posts.add(post);
      _filteredPosts = List.from(_posts);
      _myPosts.add(post);
    });
  }

  @override
  void initState() {
    super.initState();
    _filteredPosts = List.from(_posts);
    _filteredFavorites = _posts.where((post) => post.isFavorite).toList();
    _tabController = TabController(length: tabNames.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          appBarTitle = tabNames[_tabController.index];
          _filteredPosts = List.from(_posts);
          _filteredFavorites = _posts.where((post) => post.isFavorite).toList();
        });
      }
    });
  }

  void _startSearch() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("posts")
        .orderBy('createdAt', descending: true)
        .get();
    final firestorePosts = querySnapshot.docs.map((doc) {
      final data = doc.data();
      return Posts(
        title: data['userName'] ?? data['userEmail'] ?? 'Unknown',
        description: data['description'] ?? '',
        // Add other fields if needed
      );
    }).toList();
    final result = await showSearch<Posts>(
      context: context,
      delegate: PostSearchDelegate(firestorePosts),
    );
    if (result != null) {
      setState(() {
        _filteredPosts = _posts
            .where(
              (post) =>
                  post.title.toLowerCase().contains(result.title.toLowerCase()),
            )
            .toList();
      });
    }
  }

  void _startFavoriteSearch() async {
    final favorites = _posts.where((post) => post.isFavorite).toList();
    final result = await showSearch<Posts>(
      context: context,
      delegate: PostSearchDelegate(favorites),
    );
    if (result != null) {
      setState(() {
        _filteredFavorites = favorites
            .where(
              (post) =>
                  post.title.toLowerCase().contains(result.title.toLowerCase()),
            )
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabWidgets = [
      PostsScreen(),
      FavPostsScreen(
        favorites: _filteredFavorites,
        onFavoriteToggle: (post) {
          setState(() {
            post.isFavorite = !post.isFavorite;
            _filteredFavorites = _posts.where((p) => p.isFavorite).toList();
          });
        },
      ),
      MyPostScreen(myPosts: _myPosts, onAddPost: _addPost),
    ];

    return Scaffold(
      drawer: NavigationDrawerr(
        allPosts: _posts,
        favoritePosts: _posts.where((p) => p.isFavorite).toList(),
        goToPosts: () => _tabController.animateTo(0),
        goToFavorites: () => _tabController.animateTo(1),
        goToAddPost: () => _tabController.animateTo(2),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddPostWidget(
                onAddTask: () {
                  setState(() {});
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        // bottom: TabBar(
        //   controller: _tabController,
        //   tabs: tabNames.map((name) => Tab(text: name)).toList(),
        // ),
        actions: [
          if (_tabController.index == 0)
            IconButton(icon: Icon(Icons.search), onPressed: _startSearch),
          if (_tabController.index == 1)
            IconButton(
              icon: Icon(Icons.search),
              onPressed: _startFavoriteSearch,
            ),
        ],
      ),
      body: TabBarView(controller: _tabController, children: tabWidgets),
    );
  }
}
