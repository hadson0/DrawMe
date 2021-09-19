import 'package:drawme/components/avatar_form/cancel_form_dialog.dart';
import 'package:drawme/models/canvas.dart';
import 'package:drawme/screens/avatar_form/image_selection_form_screen.dart';
import 'package:flutter/material.dart';

class LayerSelectionFormScreen extends StatefulWidget {
  const LayerSelectionFormScreen({Key? key}) : super(key: key);

  @override
  _LayerSelectionFormScreenState createState() =>
      _LayerSelectionFormScreenState();
}

class _LayerSelectionFormScreenState extends State<LayerSelectionFormScreen> {
  final Map<LayerNames, bool> _layers = {
    LayerNames.BACKGROUND: true,
    LayerNames.BODY: true,
    LayerNames.EYES: true,
    LayerNames.MOUTH: true,
    LayerNames.NOSE: true,
  };

  final List<LayerNames> _selectedLayers = [];

  CheckboxListTile _buildCheckBoxTile({
    required String label,
    required LayerNames layerNames,
  }) {
    return CheckboxListTile(
      title: Text(label),
      value: _layers[layerNames],
      onChanged: (bool? value) {
        setState(() {
          _layers[layerNames] = value ?? false;
        });
      },
    );
  }

  Future<bool?> _showDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CancelFormDialog(context);
      },
    );
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
          title: const Text('Selecionar Camadas'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                child: const Text('Selecione quais camadas irá utilizar:'),
              ),
              SizedBox(
                height: 300,
                width: double.infinity,
                child: ListView(
                  children: <Widget>[
                    _buildCheckBoxTile(
                      label: 'Corpo',
                      layerNames: LayerNames.BODY,
                    ),
                    _buildCheckBoxTile(
                      label: 'Olhos',
                      layerNames: LayerNames.EYES,
                    ),
                    _buildCheckBoxTile(
                      label: 'Boca',
                      layerNames: LayerNames.MOUTH,
                    ),
                    _buildCheckBoxTile(
                      label: 'Nariz',
                      layerNames: LayerNames.NOSE,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _layers.forEach((LayerNames layer, bool isSelected) {
              if (isSelected) {
                _selectedLayers.add(layer);
              }
            });

            Navigator.of(context).pushReplacement(
              ImageSelectionFormScreen.route(_selectedLayers),
            );
          },
          child: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ),
    );
  }
}
