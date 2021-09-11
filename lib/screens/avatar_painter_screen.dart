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
  Map<int, String> layers = {
    0: 'lib/assets/images/Man/background.png',
    1: 'lib/assets/images/Man/body.png',
    2: 'lib/assets/images/Man/eyes.png',
    3: 'lib/assets/images/Man/nose.png',
    4: 'lib/assets/images/Man/mouth.png',
  };

  int _selectedLayer = 0;

  void _selectLayer(int layer) {
    setState(() {
      _selectedLayer = layer;
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
            layersMap: avatar.canvas.layers,
            selectedLayer: _selectedLayer,
          ),
          LayerImageGrid(
            onSelectLayerImage: _selectLayerImage,
            layerImageList: avatar.canvas.layers[_selectedLayer]!,
          ),
        ],
      ),
    );
  }
}
