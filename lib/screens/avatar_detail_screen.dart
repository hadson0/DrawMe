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
      backgroundColor: Colors.grey.shade200,
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
            AvatarInfo(avatar),
          ],
        ),
      ),
    );
  }
}
