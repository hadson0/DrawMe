import 'dart:math';

import 'package:drawme/components/layer_image_grid.dart';
import 'package:drawme/components/layer_tab_list.dart';
import 'package:drawme/models/canvas.dart';
import 'package:flutter/material.dart';

import 'package:drawme/components/avatar_canvas.dart';

import 'package:drawme/models/avatar.dart';

class AvatarPainterScreen extends StatefulWidget {
  final Avatar avatar;

  const AvatarPainterScreen({
    Key? key,
    required this.avatar,
  }) : super(key: key);

  static Route<Route<MaterialPageRoute>> route({
    required Avatar avatar,
  }) {
    return MaterialPageRoute(
      builder: (context) => AvatarPainterScreen(
        avatar: avatar,
      ),
    );
  }

  @override
  _AvatarPainterScreenState createState() => _AvatarPainterScreenState();
}

class _AvatarPainterScreenState extends State<AvatarPainterScreen> {
  Map<LayerNames, String> _layers = {};

  LayerNames _selectedLayer = LayerNames.BACKGROUND;

  Avatar get avatar => widget.avatar;

  void _selectLayer(LayerNames layer) {
    setState(() {
      _selectedLayer = layer;
    });
  }

  void _selectLayerImage(String imagePath) {
    setState(() {
      _layers[_selectedLayer] = imagePath;
    });
  }

  @override
  void initState() {
    super.initState();

    avatar.canvas.layers.forEach((layer, imageList) {
      _layers[layer] = imageList[Random().nextInt(imageList.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(avatar.name),
      ),
      body: Column(
        children: [
          AvatarCanvas(layers: _layers),
          LayerTabList(
            onSelectLayer: _selectLayer,
            layersMap: avatar.canvas.layers,
            selectedLayer: _selectedLayer,
          ),
          LayerImageGrid(
            onSelectLayerImage: _selectLayerImage,
            layerImageList: avatar.canvas.layers[_selectedLayer] ?? [],
          ),
        ],
      ),
    );
  }
}
