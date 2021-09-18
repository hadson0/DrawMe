import 'package:flutter/material.dart';

import 'package:drawme/components/app_drawer.dart';
import 'package:drawme/components/option_item.dart';

import 'package:drawme/utils/AppRoutes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('DrawMe!'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 30),
          children: [
            OptionItem(
              height: screenSize.height * 0.35,
              width: screenSize.width * 0.8,
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.AVATAR_LIST);
              },
              title: 'Me Desenhe!',
              color: Colors.amber.shade600,
            ),
            const SizedBox(
              height: 35,
            ),
            OptionItem(
              height: screenSize.height * 0.35,
              width: screenSize.width * 0.8,
              onTap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.LAYER_SELECTION_FORM);
              },
              title: 'Criar o meu Avatar',
              color: Colors.orange.shade600,
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
