import 'package:auto_size_text/auto_size_text.dart';
import 'package:drawme/models/drawer/drawer_item.dart';
import 'package:drawme/models/drawer/drawer_items.dart';
import 'package:drawme/screens/avatar/form/avatar_form_screen.dart';
import 'package:drawme/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  void onSelectedItem({
    required DrawerItem item,
    required BuildContext context,
  }) {
    switch (item) {
      case DrawerItems.home:
        Navigator.of(context).pushReplacement(HomeScreen.route);
        break;
      case DrawerItems.createAvatar:
        Navigator.of(context).pop();
        Navigator.of(context).push(AvatarFormScreen.route);
        break;
      default:
        Navigator.of(context).pushReplacement(HomeScreen.route);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).colorScheme.primary,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              buildDrawerItems(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawerItems(BuildContext context) => Column(
        children: DrawerItems.all.map(
          (item) {
            return ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              leading: Icon(
                item.icon,
                color: Colors.white,
              ),
              title: AutoSizeText(
                item.title,
                group: AutoSizeGroup(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                maxLines: 1,
              ),
              onTap: () => onSelectedItem(
                item: item,
                context: context,
              ),
            );
          },
        ).toList(),
      );
}
