import 'package:flutter/material.dart';

import 'package:drawme/components/avatar_info.dart';

import 'package:drawme/models/avatar.dart';

class AvatarDetailScreen extends StatelessWidget {
  const AvatarDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Avatar avatar = ModalRoute.of(context)!.settings.arguments as Avatar;

    return Scaffold(
      appBar: AppBar(
        title: Text(avatar.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.asset(
                avatar.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    avatar.name,
                    style: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    avatar.author,
                    style: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      color: Colors.blue,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            AvatarInfo(avatar),
          ],
        ),
      ),
    );
  }
}
