import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:drawme/components/avatar/painter/avatar_canvas.dart';
import 'package:drawme/components/avatar/painter/layer_image_grid.dart';
import 'package:drawme/components/avatar/painter/layer_tab_list.dart';
import 'package:drawme/components/avatar/painter/save_and_share.dart';
import 'package:drawme/components/custom/custom_color_block_picker.dart';
import 'package:drawme/models/avatar/avatar.dart';
import 'package:drawme/models/avatar/layers/layer_items.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class AvatarPainterScreen extends StatefulWidget {
  const AvatarPainterScreen({
    required this.avatar,
    Key? key,
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

  Color _selectedColor = Colors.brown;
  LayerNames _selectedLayer = LayerNames.background;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  Avatar get avatar => widget.avatar;
  List<Color> get selectedColorList =>
      avatar.canvas.colors[_selectedLayer] ?? [];
  int get selectedColorIndex => selectedColorList.contains(_selectedColor)
      ? selectedColorList.indexOf(_selectedColor)
      : 0;

  Future<String> saveAvatarImage(Uint8List bytes) async {
    final String time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final String name = avatar.name + time;
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result['filePath'] as String;
  }

  Future<void> shareAvatarImage(Uint8List bytes) async {
    final Directory directory = await getApplicationDocumentsDirectory();

    final File image = File('${directory.path}/avatar.png');
    image.writeAsBytesSync(bytes);

    const String message = 'Feito no app DrawMe';

    await Share.shareFiles(
      [image.path],
      text: message,
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 15,
    );
  }

  void randomLayerList() {
    avatar.canvas.layers
        .forEach((LayerNames layer, List<List<String>> imageList) {
      final int randomIndex = Random().nextInt(imageList.length);
      _layers[layer] = imageList[randomIndex]
          [Random().nextInt(imageList[randomIndex].length)];
    });
  }

  void pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomColorBlockPicker(
        onColorChanged: (color) {
          setState(() => _selectedColor = color);
        },
        colorList: selectedColorList,
        selectedColor: _selectedColor,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    randomLayerList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(avatar.name),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: AvatarCanvas(
                          size: constraints.maxWidth - 20,
                          layers: _layers,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Row(
                        children: [
                          if (selectedColorList.isNotEmpty)
                            FloatingActionButton(
                              onPressed: () => pickColor(context),
                              child: Icon(
                                Icons.brush,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          const SizedBox(
                            width: 10,
                          ),
                          SaveAndShare(
                            onSaved: () async {
                              final Uint8List avatarImage =
                                  await _controller.captureFromWidget(
                                AvatarCanvas(
                                  size: constraints.maxWidth,
                                  layers: _layers,
                                ),
                              );

                              saveAvatarImage(avatarImage).then((_) {
                                showToast('Salvo na galeria!');
                              });
                            },
                            onShared: () async {
                              final Uint8List avatarImage =
                                  await _controller.captureFromWidget(
                                AvatarCanvas(
                                  size: constraints.maxWidth,
                                  layers: _layers,
                                ),
                              );

                              await shareAvatarImage(avatarImage);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(145, 145, 145, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LayerTabList(
                        onRandomSelected: () {
                          setState(() => randomLayerList());
                        },
                        onSelectLayer: (LayerNames layerName) =>
                            setState(() => _selectedLayer = layerName),
                        layersMap: avatar.canvas.layers,
                        selectedLayer: _selectedLayer,
                      ),
                      LayerImageGrid(
                        onSelectLayerImage: (String imagePath) =>
                            setState(() => _layers[_selectedLayer] = imagePath),
                        layerImageList: avatar
                                .canvas
                                .layers[_selectedLayer]?[selectedColorIndex]
                                .reversed
                                .toList() ??
                            [],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
