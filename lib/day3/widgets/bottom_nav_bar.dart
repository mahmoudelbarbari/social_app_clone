import 'package:flutter/material.dart';
import 'package:flutter_application_1/day3/models/task.dart';
import 'package:flutter_application_1/day3/post_screen.dart';
import 'package:flutter_application_1/day3/profile_screen.dart';
import 'package:flutter_application_1/day3/task_screen.dart';
import 'package:flutter_application_1/day3/widgets/add_post_widget.dart';

class BottomNavBar extends StatefulWidget {
  final String name;
  final String email;
  const BottomNavBar({super.key, required this.name, required this.email});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  late List<Widget> _screens;
  final List<String> _titles = ['Task', 'Post', 'Profile'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _screens = [
      TaskScreen(),
      PostScreen(),
      ProfileScreen(name: widget.name, email: widget.email),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddPostWidget(
                onAddTask: (task) {
                  setState(() {
                    tasks.add(task);
                  });
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Task',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Post',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
            backgroundColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
