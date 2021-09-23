import 'package:drawme/models/tab_bar/tab_bar_item.dart';

class TabBarItems {
  static const recent = TabBarItem(
    title: 'RECENTES',
  );
  /* static const popular = TabBarItem(
    title: 'Populares',
  ); */
  static const favorite = TabBarItem(
    title: 'FAVORITOS',
  );

  static final List<TabBarItem> all = [
    recent,
    /* popular, */
    favorite,
  ];
}
