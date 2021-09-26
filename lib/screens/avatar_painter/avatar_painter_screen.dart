import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:drawme/components/avatar/avatar_painter/avatar_canvas.dart';
import 'package:drawme/components/avatar/avatar_painter/layer_image_grid.dart';
import 'package:drawme/components/avatar/avatar_painter/layer_tab_list.dart';
import 'package:drawme/components/custom/custom_color_block_picker.dart';
import 'package:drawme/models/avatar/avatar.dart';
import 'package:drawme/models/avatar/layers/layer_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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

  Avatar get avatar => widget.avatar;
  List<Color> get selectedColorList =>
      avatar.canvas.colors[_selectedLayer] ?? [];
  int get selectedColorIndex => selectedColorList.contains(_selectedColor)
      ? selectedColorList.indexOf(_selectedColor)
      : 0;

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

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
    final double screenWidht = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(avatar.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                AvatarCanvas(
                  size: screenWidht,
                  layers: _layers,
                ),
                if (selectedColorList.isNotEmpty)
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: FloatingActionButton(
                      onPressed: () => pickColor(context),
                      child: const Icon(Icons.brush),
                    ),
                  ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey.shade500,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 5,
                      right: 10,
                    ),
                    child: WillPopScope(
                      onWillPop: () async {
                        if (isDialOpen.value) {
                          isDialOpen.value = false;
                          return false;
                        } else {
                          return true;
                        }
                      },
                      child: SpeedDial(
                        animatedIcon: AnimatedIcons.menu_close,
                        backgroundColor: Colors.blue,
                        overlayColor: Colors.black,
                        overlayOpacity: 0.3,
                        openCloseDial: isDialOpen,
                        direction: SpeedDialDirection.Left,
                        children: [
                          SpeedDialChild(
                            child: const Icon(Icons.download),
                            label: 'Baixar',
                            onTap: () async {
                              final Uint8List avatarImage =
                                  await _controller.captureFromWidget(
                                AvatarCanvas(
                                  size: screenWidht,
                                  layers: _layers,
                                ),
                              );

                              saveAvatarImage(avatarImage).then((_) {
                                showToast('Salvo na galeria!');
                              });
                            },
                          ),
                          SpeedDialChild(
                            child: const Icon(Icons.share),
                            label: 'Compartilhar',
                            onTap: () async {
                              final Uint8List avatarImage =
                                  await _controller.captureFromWidget(
                                AvatarCanvas(
                                  size: screenWidht,
                                  layers: _layers,
                                ),
                              );

                              await shareAvatarImage(avatarImage);
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
