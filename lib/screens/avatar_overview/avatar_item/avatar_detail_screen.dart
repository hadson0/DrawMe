import 'dart:io';

import 'package:drawme/models/canvas.dart';
import 'package:drawme/screens/avatar_overview/avatar_item/avatar_painter_screen.dart';
import 'package:flutter/material.dart';

import 'package:drawme/components/avatar/avatar_detail/avatar_info.dart';

import 'package:drawme/models/avatar.dart';

class AvatarDetailScreen extends StatelessWidget {
  const AvatarDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Avatar avatar = ModalRoute.of(context)!.settings.arguments as Avatar;
    print(avatar.canvas.layers[LayerNames.BACKGROUND]);

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
              child: Image.file(
                File(avatar.avatarSample),
                fit: BoxFit.cover,
              ),
            ),
            AvatarInfo(avatar: avatar),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(AvatarPainterScreen.route(avatar: avatar));
              },
              child: Text(
                'Desenhar!',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
