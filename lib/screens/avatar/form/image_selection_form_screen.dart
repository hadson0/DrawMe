import 'package:drawme/components/avatar/form/error_form_dialog.dart';
import 'package:drawme/components/avatar/form/image_list_picker.dart';
import 'package:drawme/components/custom/custom_color_picker.dart';
import 'package:drawme/components/custom/custom_rounded_button.dart';
import 'package:drawme/models/avatar/canvas.dart';
import 'package:drawme/models/avatar/layers/layer_items.dart';
import 'package:flutter/material.dart';

class ImageSelectionFormScreen extends StatefulWidget {
  const ImageSelectionFormScreen({
    required this.canvas,
    required this.onBackPressed,
    required this.onNextPressed,
    Key? key,
  }) : super(key: key);

  final Canvas canvas;
  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;

  @override
  _ImageSelectionFormScreenState createState() =>
      _ImageSelectionFormScreenState();
}

class _ImageSelectionFormScreenState extends State<ImageSelectionFormScreen> {
  int selectedIndex = 0;
  int colorIndex = 0;
  Color color = Colors.brown;
  bool optional = false;

  Canvas get canvas => widget.canvas;
  void onBackPressed() => widget.onBackPressed();
  void onNextPressed() => widget.onNextPressed();

  int get colorNumber =>
      widget.canvas.layers.values.elementAt(selectedIndex).length;
  LayerNames get layerName =>
      widget.canvas.layers.keys.elementAt(selectedIndex);
  String get layerNameToString =>
      LayerItems.all.singleWhere((item) => item.layerName == layerName).title;
  List<List<String>> get selectedLayer => canvas.layers[layerName]!;

  void submitLayer() {
    Color nextColor = color;
    if (colorIndex <= (canvas.colors[layerName]?.length ?? 0) - 1) {
      nextColor = canvas.colors[layerName]?[colorIndex] ?? color;
    }

    if (optional) {
      canvas.addLayerImage(layerName, colorIndex, '');
      if(colorIndex == colorNumber - 1) {
        optional = false;
      }
    }

    if (colorNumber > 1) canvas.addColor(layerName, color, colorIndex);

    if (colorIndex == colorNumber - 1 &&
        selectedIndex == canvas.layers.length - 1) {
      onNextPressed();
    } else {
      if (colorIndex == colorNumber - 1) {
        selectedIndex++;
        colorIndex = 0;
      } else {
        colorIndex++;
      }
      setState(() => color = nextColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Selecine as imagens:',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontSize: 25,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            layerNameToString,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontSize: 20,
                ),
          ),
          if (colorNumber > 1)
            Text(
              'cor ${colorIndex + 1}',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontSize: 16,
                  ),
            ),
          if (layerName != LayerNames.background)
            Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    const Text(
                      'Esta camada é opcional?',
                      style: TextStyle(fontSize: 15),
                    ),
                    Switch(
                      value: optional,
                      onChanged: (bool value) =>
                          setState(() => optional = value),
                    ),
                  ],
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
                  onColorChanged: (_color) => setState(() => color = _color),
                  color: color,
                ),
              ],
            ),
          const SizedBox(height: 10),
          ImageListPicker(
            selectedLayer: selectedLayer[colorIndex],
            itemCount: selectedLayer[colorIndex].isEmpty
                ? 0
                : selectedLayer[colorIndex].length,
            onSelectPressed: (imagePath) => setState(
              () => canvas.addLayerImage(layerName, colorIndex, imagePath),
            ),
            onDeletePressed: (imageIndex) => setState(
              () => canvas.removeLayerImage(layerName, colorIndex, imageIndex),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (selectedIndex > 0)
                CustomRoundedButton(
                  onPressed: () {
                    Color oldColor = color;
                    if (canvas.colors[layerName]?.isNotEmpty ?? false) {
                      oldColor = canvas.colors[layerName]?[colorIndex] ?? color;
                    }

                    if (selectedIndex == 0 && colorIndex == 0) {
                      onBackPressed();
                    } else {
                      selectedIndex--;
                      if (colorIndex == 0) {
                        colorIndex = selectedLayer.length - 1;
                      }
                      setState(() => color = oldColor);
                    }
                  },
                  child: const Text('VOLTAR'),
                ),
              CustomRoundedButton(
                onPressed: () {
                  if (selectedLayer[colorIndex].isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext ctx) => const ErrorFormDialog(
                        message: 'Insira ao menos 1 imagem por camada!',
                      ),
                    );
                  } else {
                    submitLayer();
                  }
                },
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
      ),
    );
  }
}
