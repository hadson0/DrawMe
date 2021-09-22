import 'package:drawme/components/avatar_form/image_display_grid.dart';
import 'package:flutter/material.dart';

class ImageListPicker extends StatefulWidget {
  const ImageListPicker({
    Key? key,
    required this.onSelectPressed,
    required this.onDeletePressed,
    required this.selectedLayer,
    required this.itemCount,
  }) : super(key: key);

  final List<String> selectedLayer;
  final int itemCount;
  final Function() onSelectPressed;
  final Function(int) onDeletePressed;

  @override
  _ImageListPickerState createState() => _ImageListPickerState();
}

class _ImageListPickerState extends State<ImageListPicker> {
  List<String> get selectedLayer => widget.selectedLayer;
  int get itemCount => widget.itemCount;
  Function() get onSelectPressed => widget.onSelectPressed;
  Function(int) get onDeletePressed => widget.onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: onSelectPressed,
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
              onDeletePressed: (imageIndex) => onDeletePressed(imageIndex),
              selectedLayer: selectedLayer,
              itemCount: itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
