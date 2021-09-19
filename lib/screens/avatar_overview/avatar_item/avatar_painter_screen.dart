import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:drawme/components/avatar/avatar_painter/avatar_canvas.dart';
import 'package:drawme/components/avatar/avatar_painter/layer_image_grid.dart';
import 'package:drawme/components/avatar/avatar_painter/layer_tab_list.dart';
import 'package:drawme/models/avatar.dart';
import 'package:drawme/models/canvas.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class AvatarPainterScreen extends StatefulWidget {
  const AvatarPainterScreen({
    Key? key,
    required this.avatar,
  }) : super(key: key);

  final Avatar avatar;

  static Route<Route<MaterialPageRoute>> route({
    required Avatar avatar,
  }) {
    return MaterialPageRoute(
      builder: (BuildContext context) => AvatarPainterScreen(
        avatar: avatar,
      ),
    );
  }

  @override
  _AvatarPainterScreenState createState() => _AvatarPainterScreenState();
}

class _AvatarPainterScreenState extends State<AvatarPainterScreen> {
  final _controller = ScreenshotController();

  final Map<LayerNames, String> _layers = {};

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

  Future<String> _saveAvatarImage(Uint8List bytes) async {
    final String time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final String name = avatar.name + time;

    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result['filePath'] as String;
  }

  Future<void> _shareAvatarImage(Uint8List bytes) async {
    final Directory directory = await getApplicationDocumentsDirectory();

    final File image = File('${directory.path}/avatar.png');
    image.writeAsBytesSync(bytes);

    const String message = 'Feito no app DrawMe';

    await Share.shareFiles(
      [image.path],
      text: message,
    );
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 15,
    );
  }

  void _randomLayerList() {
    avatar.canvas.layers
        .forEach((LayerNames layer, List<List<String>> imageList) {
      final int randomIndex = Random().nextInt(imageList.length);
      _layers[layer] = imageList[randomIndex]
          [Random().nextInt(imageList[randomIndex].length)];
    });
  }

  @override
  void initState() {
    super.initState();

    _randomLayerList();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidht = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(avatar.name),
      ),
      body: ListView(
        children: <Widget> [
          AvatarCanvas(
            size: screenWidht,
            layers: _layers,
          ),
          Card(
            elevation: 8,
            color: Colors.grey.shade400,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                LayerTabList(
                  onRandomSelected: () {
                    setState(() {
                      _randomLayerList();
                    });
                  },
                  onSelectLayer: _selectLayer,
                  layersMap: avatar.canvas.layers,
                  selectedLayer: _selectedLayer,
                ),
                LayerImageGrid(
                  onSelectLayerImage: _selectLayerImage,
                  layerImageList: avatar.canvas.layers[_selectedLayer]?[0] ?? [],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget> [
                    ElevatedButton(
                      onPressed: () async {
                        final Uint8List avatarImage = await _controller.captureFromWidget(
                          AvatarCanvas(
                            size: screenWidht,
                            layers: _layers,
                          ),
                        );

                        await _shareAvatarImage(avatarImage);
                      },
                      child: Row(
                        children: const <Widget> [
                          Icon(Icons.share),
                          Text(' Compartilhar'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final Uint8List avatarImage = await _controller.captureFromWidget(
                          AvatarCanvas(
                            size: screenWidht,
                            layers: _layers,
                          ),
                        );

                        await _saveAvatarImage(avatarImage).then((_) {
                          _showToast('Salvo na galeria!');
                        });
                      },
                      child: const Text('Salvar'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
