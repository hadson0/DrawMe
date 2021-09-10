import 'package:flutter/material.dart';

import 'package:drawme/components/app_drawer.dart';
import 'package:drawme/components/option_item.dart';

import 'package:drawme/utils/AppRoutes.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({Key? key}) : super(key: key);

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
              title: 'Me Desenhe!',
              color: Colors.amber.shade600,
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.AVATAR_LIST);
              },
            ),
            SizedBox(
              height: 35,
            ),
            OptionItem(
              onTap: () {},
              color: Colors.orange.shade600,
              title: 'Criar o meu Avatar',
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
