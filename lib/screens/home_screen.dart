import 'package:flutter/material.dart';

import 'package:drawme/components/app_drawer.dart';
import 'package:drawme/components/option_item.dart';

import 'package:drawme/utils/AppRoutes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DrawMe!'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OptionItem(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.AVATAR_LIST);
              },
              title: 'Me Desenhe!',
              color: Colors.amber.shade600,
            ),
            SizedBox(
              height: 35,
            ),
            OptionItem(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.LAYER_SELECTION_FORM);
              },
              title: 'Criar o meu Avatar',
              color: Colors.orange.shade600,
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
