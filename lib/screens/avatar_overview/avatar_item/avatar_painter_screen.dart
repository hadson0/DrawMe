import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:drawme/components/avatar/avatar_painter/layer_image_grid.dart';
import 'package:drawme/components/avatar/avatar_painter/layer_tab_list.dart';
import 'package:drawme/components/avatar/avatar_painter/avatar_canvas.dart';

import 'package:drawme/models/canvas.dart';
import 'package:drawme/models/avatar.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

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
  final _controller = ScreenshotController();

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

  Future<String> saveAvatarImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = avatar.name + '$time';

    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result['filePath'];
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () async {},
                child: Text('Compartilhar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final avatarImage = await _controller
                      .captureFromWidget(AvatarCanvas(layers: _layers));

                  await saveAvatarImage(avatarImage);
                },
                child: Text('Salvar'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
