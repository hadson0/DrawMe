import 'package:drawme/components/drawer/app_drawer.dart';
import 'package:drawme/models/tab_bar/tab_bar_items.dart';
import 'package:drawme/screens/avatar/overview/avatar_grid_screen.dart';
import 'package:drawme/screens/avatar/overview/favorite_avatar_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Text(
            'DrawMe!',
            style: Theme.of(context).textTheme.headline1,
          ),
          bottom: TabBar(
            padding: const EdgeInsets.all(5),
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Theme.of(context).primaryColor,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).indicatorColor,
            ),
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
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Theme.of(context).indicatorColor,
              ),
            ),
            child: Align(
              child: Text(item.title),
            ),
          ),
        ),
      )
      .toList();
}
