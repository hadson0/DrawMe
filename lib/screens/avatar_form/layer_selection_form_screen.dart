import 'package:drawme/components/avatar_form/error_form_dialog.dart';
import 'package:drawme/components/custom/custom_rounded_button.dart';
import 'package:drawme/components/custom/number_picker.dart';
import 'package:drawme/models/avatar/canvas.dart';
import 'package:drawme/models/avatar/layers/layer_items.dart';
import 'package:flutter/material.dart';

class LayerSelectionFormScreen extends StatefulWidget {
  const LayerSelectionFormScreen({
    required this.canvas,
    required this.onNextPressed,
    Key? key,
  }) : super(key: key);

  final Canvas canvas;
  final VoidCallback onNextPressed;

  @override
  _LayerSelectionFormScreenState createState() =>
      _LayerSelectionFormScreenState();
}

class _LayerSelectionFormScreenState extends State<LayerSelectionFormScreen> {
  Map<LayerNames, int> layers = {};

  Canvas get canvas => widget.canvas;
  void onNextPressed() => widget.onNextPressed();

  void submitLayers() {
    final bool isValid =
        layers.entries.where((layer) => layer.value > 0).length >= 2;

    if (isValid) {
      layers.forEach((LayerNames layerName, int colorNumber) {
        if (colorNumber > 0) {
          canvas.addLayer(layerName, colorNumber);
        }
      });
      widget.onNextPressed();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext ctx) => const ErrorFormDialog(
          message: 'Insira ao menos 2 camadas!',
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    layers.addEntries(
      LayerItems.all
          .map(
            (item) => MapEntry(item.layerName, 0),
          )
          .where(
            (item) => item.key != LayerNames.background,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
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
              'Insira o número de subcamadas (cores) ou 0 para desabilitar.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white54,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Camada'),
                    trailing: Text('nº de subcamandas'),
                  ),
                  const Divider(),
                  ...buildCheckBoxTiles(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomRoundedButton(
              onPressed: submitLayers,
              child: const Text('PRONTO'),
            ),
          ],
        ),
      ),
    );
  }

  List<ListTile> buildCheckBoxTiles() => LayerItems.all
      .map(
        (item) => ListTile(
          title: Text(item.title),
          trailing: NumberPicker(
            initialValue: 0,
            maxValue: 5,
            minValue: 0,
            onValue: (int value) => layers[item.layerName] = value,
          ),
        ),
      )
      .toList();
}
