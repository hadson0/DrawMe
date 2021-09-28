import 'package:flutter/material.dart';

class CustomTabBar extends Container implements PreferredSizeWidget {
  CustomTabBar({
    required this.tabBar,
  });

  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(50),
      ),
      child: tabBar,
    );
  }
}
