import 'package:drawme/components/drawer/app_drawer.dart';
import 'package:drawme/models/tab_bar/tab_bar_items.dart';
import 'package:drawme/screens/avatar_overview/avatar_grid_screen.dart';
import 'package:drawme/screens/avatar_overview/favorite_avatar_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabsAvatarScreen extends StatefulWidget {
  const TabsAvatarScreen({
    Key? key,
  }) : super(key: key);

  @override
  _TabsAvatarScreenState createState() => _TabsAvatarScreenState();
}

class _TabsAvatarScreenState extends State<TabsAvatarScreen> {
  int selectedScreenIndex = 0;

  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    screens = [
      const AvatarGridScreen(),
      const FavoriteAvatarScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text(
            'DrawMe!',
            style: GoogleFonts.pacifico(
              fontSize: 25,
            ),
          ),
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            labelColor: Colors.cyan,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: buildtabBar(),
          ),
        ),
        /* drawer: const AppDrawer(), */
        body: TabBarView(children: screens),
      ),
    );
  }

  List<Widget> buildtabBar() => TabBarItems.all
      .map(
        (item) => Tab(
          child: Align(
            child: Text(item.title),
          ),
        ),
      )
      .toList();
}
