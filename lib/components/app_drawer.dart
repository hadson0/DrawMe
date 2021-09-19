import 'package:drawme/utils/AppRoutes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget> [
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
              children: <Widget> [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget> [
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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Tela Inicial'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person_pin_outlined),
            title: const Text('Me Desenhe!'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.AVATAR_LIST);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.brush_outlined),
            title: const Text('Criar o meu Avatar'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
