import 'package:flutter/material.dart';

import 'package:drawme/components/avatar_canvas.dart';

import 'package:drawme/models/avatar.dart';

class AvatarPainterScreen extends StatefulWidget {
  const AvatarPainterScreen({Key? key}) : super(key: key);

  @override
  _AvatarPainterScreenState createState() => _AvatarPainterScreenState();
}

class _AvatarPainterScreenState extends State<AvatarPainterScreen> {
  List<String> layers = [
    'lib/assets/images/Man/background.png',
    'lib/assets/images/Man/body.png',
    'lib/assets/images/Man/eyes.png',
    'lib/assets/images/Man/nose.png',
    'lib/assets/images/Man/mouth.png',
  ];
  @override
  Widget build(BuildContext context) {
    final avatar = ModalRoute.of(context)?.settings.arguments as Avatar;

    return Scaffold(
      appBar: AppBar(
        title: Text(avatar.name),
      ),
      body: Column(
        children: [
          AvatarCanvas(layers),
        ],
      ),
    );
  }
}

/* 
    avatar.addLayerImage('background', 'lib/assets/images/Man/background.png');
    avatar.addLayerImage('body', 'lib/assets/images/Man/body.png');
    avatar.addLayerImage('eyes', 'lib/assets/images/Man/eyes.png');
    avatar.addLayerImage('eyes', 'lib/assets/images/Man/eyes2.png');
    avatar.addLayerImage('nose', 'lib/assets/images/Man/nose.png');
    avatar.addLayerImage('nose', 'lib/assets/images/Man/nose2.png');
    avatar.addLayerImage('mouth', 'lib/assets/images/Man/mouth.png');
    avatar.addLayerImage('mouth', 'lib/assets/images/Man/mouth2.png');
 */
