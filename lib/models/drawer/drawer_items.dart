import 'package:drawme/models/drawer/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerItems {
  static const home = DrawerItem(
    title: 'Início',
    icon: FontAwesomeIcons.home,
  );
  static const createAvatar = DrawerItem(
    title: 'Criar Avatar',
    icon: FontAwesomeIcons.paintBrush,
  );
  static const profile = DrawerItem(
    title: 'Perfil',
    icon: FontAwesomeIcons.userAlt,
  );
  static const settings = DrawerItem(
    title: 'Configurações',
    icon: Icons.settings,
  );
  static const logout = DrawerItem(
    title: 'Sair',
    icon: Icons.logout,
  );

  static final List<DrawerItem> all = [
    home,
    createAvatar,
    profile,
    settings,
    logout,
  ];
}
