import 'package:drawme/components/layer_image_grid.dart';
import 'package:drawme/components/layer_tab_list.dart';
import 'package:flutter/material.dart';

import 'package:drawme/components/avatar_canvas.dart';

import 'package:drawme/models/avatar.dart';

class AvatarPainterScreen extends StatefulWidget {
  const AvatarPainterScreen({Key? key}) : super(key: key);

  @override
  _AvatarPainterScreenState createState() => _AvatarPainterScreenState();
}

class _AvatarPainterScreenState extends State<AvatarPainterScreen> {
  Map<String, String> layers = {
    'background': 'lib/assets/images/Man/background.png',
    'body': 'lib/assets/images/Man/body.png',
    'eyes': 'lib/assets/images/Man/eyes.png',
    'nose': 'lib/assets/images/Man/nose.png',
    'mouth': 'lib/assets/images/Man/mouth.png',
  };

  String _selectedLayer = 'nose';

  void _selectLayer(String layerName) {
    setState(() {
      _selectedLayer = layerName;
    });
  }

  void _selectLayerImage(String imagePath) {
    setState(() {
      layers[_selectedLayer] = imagePath;
    });
  }

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
          LayerTabList(
            onSelectLayer: _selectLayer,
            layersMap: avatar.layers,
            selectedLayer: _selectedLayer,
          ),
          LayerImageGrid(
            onSelectLayerImage: _selectLayerImage,
            layerImageList: avatar.layers[_selectedLayer]!,
          ),
        ],
      ),
    );
  }
}
