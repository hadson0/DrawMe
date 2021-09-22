import 'package:drawme/components/avatar_form/cancel_form_dialog.dart';
import 'package:drawme/components/number_picker.dart';
import 'package:drawme/models/avatar/canvas.dart';
import 'package:drawme/screens/avatar_form/image_selection_form_screen.dart';
import 'package:flutter/material.dart';

class LayerSelectionFormScreen extends StatefulWidget {
  const LayerSelectionFormScreen({Key? key}) : super(key: key);

  @override
  _LayerSelectionFormScreenState createState() =>
      _LayerSelectionFormScreenState();
}

class _LayerSelectionFormScreenState extends State<LayerSelectionFormScreen> {
  final Map<LayerNames, int> _layers = {
    LayerNames.BACKGROUND: 1,
    LayerNames.BODY: 1,
    LayerNames.EYES: 1,
    LayerNames.MOUTH: 1,
    LayerNames.NOSE: 1,
  };

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
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
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
                    ],
                  ),
                ),
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
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final Canvas canvas = Canvas();
            _layers.forEach((LayerNames layerName, int colorNumber) {
              if (colorNumber > 0) {
                canvas.addLayer(layerName, colorNumber);
              }
            });

            Navigator.of(context).pushReplacement(
              ImageSelectionFormScreen.route(canvas),
            );
          },
          child: const Icon(Icons.arrow_forward_ios_rounded),
        ),
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
          _layers[layerName] = value;
        },
      ),
    );
  }

}
