import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:drawme/components/avatar_form/cancel_form_dialog.dart';
import 'package:drawme/components/avatar_form/image_display_grid.dart';

import 'package:drawme/models/canvas.dart';

import 'package:drawme/screens/avatar_form/avatar_info_form_screen.dart';

class ImageSelectionFormScreen extends StatefulWidget {
  final List<LayerNames> layerList;

  const ImageSelectionFormScreen({
    Key? key,
    required this.layerList,
  }) : super(key: key);

  static Route<MaterialPageRoute> route(List<LayerNames> selectedLayers) {
    return MaterialPageRoute(
      builder: (context) => ImageSelectionFormScreen(
        layerList: selectedLayers,
      ),
    );
  }

  @override
  _ImageSelectionFormScreenState createState() =>
      _ImageSelectionFormScreenState();
}

class _ImageSelectionFormScreenState extends State<ImageSelectionFormScreen> {
  final ImagePicker _picker = ImagePicker();

  final List<List<XFile>> _imageList = [[]];

  int _selectedIndex = 0;
  bool _optional = false;

  List<XFile> get selectedLayer => _imageList[_selectedIndex];
  List<LayerNames> get layerList => widget.layerList;

  Future<void> _selectGaleryImage() async {
    final List<XFile>? selectedImage =
        await _picker.pickMultiImage(maxHeight: 600, maxWidth: 600);
    if (selectedImage!.isNotEmpty) {
      for (final image in selectedImage) {
        setState(() {
          selectedLayer.add(image);
        });
      }
    }
  }

  void _addOptinal() {
    final XFile _empty = XFile('');
    selectedLayer.add(_empty);
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um Erro!'),
        content: Text(msg),
        actions: [
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        final bool? shouldPop = await _showDialog();
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(layerList[_selectedIndex].toString()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Camada opcional'),
                  Switch(
                    value: _optional,
                    onChanged: (value) {
                      setState(() {
                        _optional = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selectGaleryImage,
                child: const Text('Selecionar'),
              ),
              const SizedBox(height: 20),
              ImageDisplayGrid(
                height: screenHeight * 0.5,
                selectedLayer: selectedLayer,
                itemCount: _imageList.isEmpty ? 0 : selectedLayer.length,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (selectedLayer.isEmpty) {
                _showErrorDialog('Insira ao menos 1 imagem por camada!');
              } else {
                if (_optional) {
                  _addOptinal();
                }

                if (_selectedIndex >= layerList.length - 1) {
                  final Map<LayerNames, List<XFile>> _layerMap = {};

                  for (int i = 0; i < layerList.length; i++) {
                    _layerMap[layerList[i]] = _imageList[i];
                  }

                  Navigator.of(context).pushReplacement(
                    AvatarInfoFormScreen.route(layerMap: _layerMap),
                  );
                } else {
                  if (selectedLayer.isNotEmpty) {
                    _imageList.add([]);

                    _selectedIndex++;
                  }
                }
              }
            });
          },
          child: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ),
    );
  }
}
