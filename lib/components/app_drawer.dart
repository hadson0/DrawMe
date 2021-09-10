import 'package:flutter/material.dart';

import 'package:drawme/utils/AppRoutes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 15,
            ),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Acesse a sua conta agora!',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'RobotoCondensed',
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Clique aqui',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'RobotoCondensed',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Tela Inicial'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person_pin_outlined),
            title: Text('Me Desenhe!'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.AVATAR_LIST);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.brush_outlined),
            title: Text('Criar o meu Avatar'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
