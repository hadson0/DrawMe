import 'package:drawme/components/number_picker.dart';
import 'package:drawme/models/avatar/canvas.dart';
import 'package:flutter/material.dart';

class LayerSelectionFormScreen extends StatefulWidget {
  const LayerSelectionFormScreen({
    Key? key,
    required this.canvas,
    required this.onNextPressed,
  }) : super(key: key);

  final Canvas canvas;
  final VoidCallback onNextPressed;

  @override
  _LayerSelectionFormScreenState createState() =>
      _LayerSelectionFormScreenState();
}

class _LayerSelectionFormScreenState extends State<LayerSelectionFormScreen> {
  final Map<LayerNames, int> layers = {
    LayerNames.BACKGROUND: 1,
    LayerNames.BODY: 1,
    LayerNames.EYES: 1,
    LayerNames.MOUTH: 1,
    LayerNames.NOSE: 1,
  };

  Canvas get canvas => widget.canvas;
  void onNextPressed() => widget.onNextPressed();

  void submitLayers() {
    layers.forEach((LayerNames layerName, int colorNumber) {
      if (colorNumber > 0) {
        canvas.addLayer(layerName, colorNumber);
      }
    });

    widget.onNextPressed();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
            'Selecione as camadas',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontSize: 25,
                ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Insira o número de subcamadas (cores) ou 0 para desabilitar a camada.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                buildCheckBoxTile(
                  label: 'Corpo',
                  layerName: LayerNames.BODY,
                ),
                buildCheckBoxTile(
                  label: 'Olhos',
                  layerName: LayerNames.EYES,
                ),
                buildCheckBoxTile(
                  label: 'Boca',
                  layerName: LayerNames.MOUTH,
                ),
                buildCheckBoxTile(
                  label: 'Nariz',
                  layerName: LayerNames.NOSE,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: submitLayers,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: const Text('PRONTO'),
          ),
        ],
      ),
    );
  }

  ListTile buildCheckBoxTile({
    required String label,
    required LayerNames layerName,
  }) {
    return ListTile(
      title: Text(label),
      trailing: NumberPicker(
        initialValue: 1,
        maxValue: 5,
        minValue: 0,
        onValue: (int value) {
          layers[layerName] = value;
        },
      ),
    );
  }
}
