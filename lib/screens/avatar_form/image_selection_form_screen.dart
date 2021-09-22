import 'package:drawme/components/avatar_form/cancel_form_dialog.dart';
import 'package:drawme/components/avatar_form/image_list_picker.dart';
import 'package:drawme/components/custom_color_picker.dart';
import 'package:drawme/models/avatar/canvas.dart';
import 'package:drawme/screens/avatar_form/avatar_info_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectionFormScreen extends StatefulWidget {
  const ImageSelectionFormScreen(
    this.canvas, {
    Key? key,
  }) : super(key: key);

  final Canvas canvas;

  static Route<MaterialPageRoute> route(Canvas canvas) {
    return MaterialPageRoute(
      builder: (BuildContext context) => ImageSelectionFormScreen(canvas),
    );
  }

  @override
  _ImageSelectionFormScreenState createState() =>
      _ImageSelectionFormScreenState();
}

class _ImageSelectionFormScreenState extends State<ImageSelectionFormScreen> {
  final ImagePicker picker = ImagePicker();

  int _selectedIndex = 0;
  int _colorIndex = 0;
  Color _color = Colors.brown;
  bool _optional = false;

  Canvas get canvas => widget.canvas;
  List<String> get selectedLayer => canvas.layers[layerName]![_colorIndex];
  int get colorNumber =>
      widget.canvas.layers.values.elementAt(_selectedIndex).length;
  LayerNames get layerName =>
      widget.canvas.layers.keys.elementAt(_selectedIndex);

  String get layerNameToString {
    switch (widget.canvas.layers.keys.elementAt(_selectedIndex)) {
      case LayerNames.BACKGROUND:
        return 'Fundo';
      case LayerNames.BODY:
        return 'Corpo';
      case LayerNames.EYES:
        return 'Olhos';
      case LayerNames.MOUTH:
        return 'Boca';
      case LayerNames.NOSE:
        return 'Nariz';
      default:
        return '';
    }
  }

  Future<void> selectGaleryImage() async {
    final List<XFile>? selectedImage =
        await picker.pickMultiImage(maxHeight: 600, maxWidth: 600);
    if ((selectedImage?.length ?? 0) > 0) {
      for (final XFile image in selectedImage!) {
        setState(() {
          canvas.addLayerImage(layerName, _colorIndex, image.path);
        });
      }
    }
  }

  void showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('Ocorreu um Erro!'),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void submitLayer() {
    if (_optional) {
      canvas.addLayerImage(layerName, _colorIndex, '');
    }

    if (_colorIndex == colorNumber - 1) {
      if (colorNumber > 1) {
        canvas.addColor(layerName, _color);
      }
      _selectedIndex++;

      if (_selectedIndex == canvas.layers.length) {
        Navigator.of(context).pushReplacement(
          AvatarInfoFormScreen.route(canvas: canvas),
        );
        return;
      } else {
        setState(() => _colorIndex = 0);
      }
    } else {
      if (colorNumber > 1) {
        canvas.addColor(layerName, _color);
      }
      setState(() => _colorIndex++);
    }

    _optional = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool? shouldPop = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return const CancelFormDialog();
          },
        );
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Criar Avatar'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                layerNameToString,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontSize: 25,
                    ),
              ),
              if (colorNumber > 1)
                Text(
                  'cor ${_colorIndex + 1}',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontSize: 18,
                      ),
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Text(
                    'Esta camada é opcional?',
                    style: TextStyle(fontSize: 15),
                  ),
                  Switch(
                    value: _optional,
                    onChanged: (bool value) {
                      setState(() => _optional = value);
                    },
                  ),
                ],
              ),
              if (colorNumber > 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Selecione a cor da camada:',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    CustomColorPicker(
                      onColorChanged: (color) {
                        setState(() => _color = color);
                      },
                      color: _color,
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              ImageListPicker(
                selectedLayer: selectedLayer,
                itemCount: selectedLayer.isEmpty ? 0 : selectedLayer.length,
                onSelectPressed: selectGaleryImage,
                onDeletePressed: (imageIndex) {
                  setState(() {
                    canvas.removeLayerImage(
                      layerName,
                      _colorIndex,
                      imageIndex,
                    );
                  });
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedLayer.isEmpty) {
              showErrorDialog('Insira ao menos 1 imagem por camada!');
            } else {
              submitLayer();
            }
          },
          child: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ),
    );
  }
}
