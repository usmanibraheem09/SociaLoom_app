import 'package:flutter/material.dart';
import 'package:social_media_app/pages/add_post.dart';
import 'package:social_media_app/pages/post_page.dart';
import 'package:social_media_app/pages/search.dart';
import 'package:social_media_app/pages/settings_page.dart';
import 'package:social_media_app/pages/user_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  final List<Widget> _pages = [
    PostPage(),
    Search(),
    AddPost(),
    SettingsPage(),
    UserProfile(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.home,
          color: Theme.of(context).colorScheme.primary,
          ),
          ),
          BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.search,
          color: Theme.of(context).colorScheme.primary,
          ),
          ),
          BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.add_box_outlined,
          color: Theme.of(context).colorScheme.primary,
          ),
          ),
          BottomNavigationBarItem(
            label: '',
          icon: Icon(Icons.settings,
          color: Theme.of(context).colorScheme.primary,
          ),
          ),
          BottomNavigationBarItem(
            label: '',
          icon: Icon(Icons.person,
          color: Theme.of(context).colorScheme.primary,
          ),
          ),
      ]
      ),
    );
  }
}