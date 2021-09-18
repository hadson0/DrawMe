import 'package:flutter/material.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:drawme/components/app_drawer.dart';

import 'package:drawme/screens/avatar_overview/avatar_grid_screen.dart';
import 'package:drawme/screens/avatar_overview/favorite_avatar_screen.dart';

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

  Widget _buildBottomNavigationBar() {
    final inactiveColor = Colors.grey;
    return BottomNavyBar(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      containerHeight: 70,
      backgroundColor: Colors.black,
      itemCornerRadius: 16,
      selectedIndex: _selectedScreenIndex,
      onItemSelected: (index) => setState(() => _selectedScreenIndex = index),
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.apps),
          title: Text('Avatares'),
          textAlign: TextAlign.center,
          activeColor: Colors.amber,
          inactiveColor: inactiveColor,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.favorite),
          title: Text('Favoritos'),
          textAlign: TextAlign.center,
          activeColor: Colors.red,
          inactiveColor: inactiveColor,
        ),
        /* BottomNavyBarItem(
          icon: Icon(Icons.person),
          title: Text('Perfil'),
          textAlign: TextAlign.center,
          activeColor: Colors.blue,
          inactiveColor: inactiveColor,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.settings),
          title: Text('Configurações'),
          textAlign: TextAlign.center,
          activeColor: Colors.orange,
          inactiveColor: inactiveColor,
        ), */
      ],
    );
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
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
