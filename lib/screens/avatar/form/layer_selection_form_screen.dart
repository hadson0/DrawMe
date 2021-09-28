import 'package:auto_size_text/auto_size_text.dart';
import 'package:drawme/components/avatar/form/error_form_dialog.dart';
import 'package:drawme/components/custom/custom_rounded_button.dart';
import 'package:drawme/components/custom/number_picker.dart';
import 'package:drawme/models/avatar/canvas.dart';
import 'package:drawme/models/avatar/layers/layer_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
      LayerItems.all.map(
        (item) => (item.layerName == LayerNames.background)
            ? MapEntry(item.layerName, 1)
            : MapEntry(item.layerName, 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Column(
        children: <Widget>[
          AutoSizeText(
            'Selecione as camadas',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontSize: 25,
                ),
            maxLines: 1,
          ),
          const SizedBox(height: 20),
          const Text(
            'Insira o número de subcamadas (cores) ou 0 para desabilitar.',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Camada',
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                        Text(
                          'nº de subcamandas',
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView(
                      children: buildCheckBoxTiles(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomRoundedButton(
            onPressed: submitLayers,
            child: Text(
              'PRONTO',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  List<ListTile> buildCheckBoxTiles() => LayerItems.all
      .where((item) => item.layerName != LayerNames.background)
      .map(
        (item) => ListTile(
          title: Text(
            item.title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          trailing: NumberPicker(
            initialValue: layers[item.layerName] ?? 0,
            maxValue: 5,
            minValue: 0,
            onValue: (int value) => layers[item.layerName] = value,
          ),
        ),
      )
      .toList();
}
