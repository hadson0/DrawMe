import 'package:drawme/components/avatar_form/cancel_form_dialog.dart';
import 'package:drawme/components/avatar_form/image_display_grid.dart';
import 'package:drawme/components/custom_color_picker.dart';
import 'package:drawme/models/canvas.dart';
import 'package:drawme/screens/avatar_form/avatar_info_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectionFormScreen extends StatefulWidget {
  const ImageSelectionFormScreen({
    Key? key,
    required this.canvas,
  }) : super(key: key);

  final Canvas canvas;

  static Route<MaterialPageRoute> route(Canvas canvas) {
    return MaterialPageRoute(
      builder: (BuildContext context) => ImageSelectionFormScreen(
        canvas: canvas,
      ),
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

  Future<void> _selectGaleryImage() async {
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

  void _pickColor(BuildContext context) => showDialog(
        context: context,
        builder: (context) => CustomColorPicker(
          onColorChanged: (color) {
            setState(() => _color = color);
          },
          color: _color,
        ),
      );

  void _showErrorDialog(String msg) {
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

  Future<bool?> _showDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return CancelFormDialog(context);
      },
    );
  }

  void _submitLayer() {
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
        final bool? shouldPop = await _showDialog();
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Selecionar imagens $layerNameToString'),
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
                    GestureDetector(
                      onTap: () => _pickColor(context),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          shape: BoxShape.circle,
                          color: _color,
                        ),
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selectGaleryImage,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'SELECIONAR IMAGENS',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ImageDisplayGrid(
                  onDeletePressed: (imageIndex) {
                    setState(
                      () => canvas.removeLayerImage(
                        layerName,
                        _colorIndex,
                        imageIndex,
                      ),
                    );
                  },
                  selectedLayer: canvas.layers[layerName]![_colorIndex],
                  itemCount: canvas.layers[layerName]![_colorIndex].isEmpty
                      ? 0
                      : canvas.layers[layerName]![_colorIndex].length,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (canvas.layers[layerName]![_colorIndex].isEmpty) {
              _showErrorDialog('Insira ao menos 1 imagem por camada!');
            } else {
              _submitLayer();
            }
          },
          child: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ),
    );
  }
}
