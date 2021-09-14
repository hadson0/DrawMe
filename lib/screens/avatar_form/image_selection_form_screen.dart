import 'dart:io';

import 'package:drawme/models/canvas.dart';
import 'package:drawme/screens/avatar_form/avatar_info_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
            ));
  }

  @override
  _ImageSelectionFormScreenState createState() =>
      _ImageSelectionFormScreenState();
}

class _ImageSelectionFormScreenState extends State<ImageSelectionFormScreen> {
  final ImagePicker _picker = ImagePicker();

  List<List<XFile>> _imageList = [[]];

  int _selectedIndex = 0;

  List<XFile> get selectedLayer => _imageList[_selectedIndex];
  List<LayerNames> get layerList => widget.layerList;

  void _selectGaleryImage() async {
    final List<XFile>? selectedImage =
        await _picker.pickMultiImage(maxHeight: 600, maxWidth: 600);
    if (selectedImage!.isNotEmpty) {
      selectedImage.forEach((image) {
        setState(() {
          selectedLayer.add(image);
        });
      });
    }
  }

  /* TODO: Empty layer option */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(layerList[_selectedIndex].toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selecione as imagens da camada ${layerList[_selectedIndex]}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectGaleryImage,
              child: Text('Selecionar'),
            ),
            SizedBox(height: 20),
            Container(
              height: 500,
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: GridView.builder(
                itemCount: _imageList.length == 0 ? 0 : selectedLayer.length,
                itemBuilder: (ctx, i) {
                  return buildGridItem(selectedLayer[i], onDeletePressed: () {
                    setState(() {
                      selectedLayer.removeAt(i);
                    });
                  });
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            /* TODO: Alert dialog to empty image list */
            if (_selectedIndex >= layerList.length - 1) {
              Map<LayerNames, List<XFile>> _layerMap = {};

              for (int i = 0; i < layerList.length; i++) {
                _layerMap[layerList[i]] = _imageList[i];
              }

              Navigator.of(context).pushReplacement(
                  AvatarInfoFormScreen.route(layerMap: _layerMap));
            } else {
              if (selectedLayer.isNotEmpty) {
                _imageList.add([]);
                _selectedIndex++;
              }
            }
          });
        },
        child: Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }

  ClipRRect buildGridItem(
    XFile image, {
    required VoidCallback onDeletePressed,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            File(image.path),
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 2,
            right: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromRGBO(255, 255, 244, 0.5),
              ),
              child: IconButton(
                onPressed: onDeletePressed,
                icon: Icon(
                  Icons.delete,
                  color: Colors.red.shade700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
