import 'package:flutter/material.dart';

import 'package:drawme/components/app_drawer.dart';

import 'package:drawme/screens/avatar_grid_screen.dart';
import 'package:drawme/screens/favorite_avatar_screen.dart';

class TabsAvatarScreen extends StatefulWidget {
  const TabsAvatarScreen({Key? key}) : super(key: key);

  @override
  _TabsAvatarScreenState createState() => _TabsAvatarScreenState();
}

class _TabsAvatarScreenState extends State<TabsAvatarScreen> {
  int _selectedScreenIndex = 0;
  final List<String> _titles = [
    'Lista de Avatares',
    'Favoritos',
  ];

  List<Widget> _screens = [];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _screens = [
      AvatarGridScreen(),
      FavoriteAvatarScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedScreenIndex]),
      ),
      drawer: AppDrawer(),
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedScreenIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Avatares',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
