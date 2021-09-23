import 'package:drawme/components/avatar_form/image_list_picker.dart';
import 'package:drawme/components/custom_color_picker.dart';
import 'package:drawme/models/avatar/canvas.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectionFormScreen extends StatefulWidget {
  const ImageSelectionFormScreen({
    Key? key,
    this.layerIndex = 0,
    this.colorIndex = 0,
    required this.canvas,
    required this.onBackPressed,
    required this.onNextPressed,
  }) : super(key: key);

  final int layerIndex;
  final int colorIndex;
  final Canvas canvas;
  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;

  @override
  _ImageSelectionFormScreenState createState() =>
      _ImageSelectionFormScreenState();
}

class _ImageSelectionFormScreenState extends State<ImageSelectionFormScreen> {
  final ImagePicker picker = ImagePicker();

  late int selectedIndex;
  late int colorIndex;

  Color color = Colors.brown;
  bool optional = false;

  Canvas get canvas => widget.canvas;
  void onBackPressed() => widget.onBackPressed();
  void onNextPressed() => widget.onNextPressed();

  List<List<String>> get selectedLayer => canvas.layers[layerName]!;
  int get colorNumber =>
      widget.canvas.layers.values.elementAt(selectedIndex).length;
  LayerNames get layerName =>
      widget.canvas.layers.keys.elementAt(selectedIndex);

  String get layerNameToString {
    switch (widget.canvas.layers.keys.elementAt(selectedIndex)) {
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
          canvas.addLayerImage(layerName, colorIndex, image.path);
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
    if (optional) {
      canvas.addLayerImage(layerName, colorIndex, '');
    }

    if (colorIndex == colorNumber - 1) {
      if (colorNumber > 1) {
        canvas.addColor(layerName, color, colorIndex);
      }
      selectedIndex++;

      if (selectedIndex == canvas.layers.length) {
        onNextPressed();
      } else {
        colorIndex = 0;
        setState(() {
          if (colorIndex <= (canvas.colors[layerName]?.length ?? 0) - 1) {
            color = canvas.colors[layerName]?[colorIndex] ?? color;
          }
        });
      }
    } else {
      if (colorNumber > 1) {
        canvas.addColor(layerName, color, colorIndex);
      }
      colorIndex++;
      setState(() {
        if (colorIndex <= (canvas.colors[layerName]?.length ?? 0) - 1) {
          color = canvas.colors[layerName]?[colorIndex] ?? color;
        }
      });
    }

    optional = false;
  }

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.layerIndex;
    colorIndex = widget.colorIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Selecine as imagens:',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                fontSize: 25,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          layerNameToString,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                fontSize: 20,
              ),
        ),
        if (colorNumber > 1)
          Text(
            'cor ${colorIndex + 1}',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontSize: 16,
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
              value: optional,
              onChanged: (bool value) {
                setState(() => optional = value);
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
                onColorChanged: (_color) {
                  setState(() => color = _color);
                },
                color: color,
              ),
            ],
          ),
        const SizedBox(height: 20),
        ImageListPicker(
          selectedLayer: selectedLayer[colorIndex],
          itemCount: selectedLayer[colorIndex].isEmpty
              ? 0
              : selectedLayer[colorIndex].length,
          onSelectPressed: selectGaleryImage,
          onDeletePressed: (imageIndex) {
            setState(() {
              canvas.removeLayerImage(
                layerName,
                colorIndex,
                imageIndex,
              );
            });
          },
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (selectedIndex > 0)
              ElevatedButton(
                onPressed: () {
                  if (colorIndex == 0) {
                    if (selectedIndex == 0) {
                      onBackPressed();
                    } else {
                      selectedIndex--;
                      colorIndex = selectedLayer.length - 1;
                      setState(() {
                        if (canvas.colors[layerName]?.isNotEmpty ?? false) {
                          color =
                              canvas.colors[layerName]?[colorIndex] ?? color;
                        }
                      });
                    }
                  } else {
                    colorIndex--;
                    setState(() {
                      if (canvas.colors[layerName]?.isNotEmpty ?? false) {
                        color = canvas.colors[layerName]?[colorIndex] ?? color;
                      }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('VOLTAR'),
              ),
            ElevatedButton(
              onPressed: () {
                if (selectedLayer[colorIndex].isEmpty) {
                  showErrorDialog('Insira ao menos 1 imagem por camada!');
                } else {
                  submitLayer();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                (selectedIndex == canvas.layers.length &&
                        colorIndex == colorNumber - 1)
                    ? 'PRONTO'
                    : 'PRÓXIMO',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
