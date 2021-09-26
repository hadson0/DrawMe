import 'package:drawme/components/avatar_form/image_display_grid.dart';
import 'package:drawme/components/custom/custom_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageListPicker extends StatefulWidget {
  const ImageListPicker({
    required this.onSelectPressed,
    required this.onDeletePressed,
    required this.selectedLayer,
    required this.itemCount,
    Key? key,
  }) : super(key: key);

  final List<String> selectedLayer;
  final int itemCount;
  final Function(String) onSelectPressed;
  final Function(int) onDeletePressed;

  @override
  _ImageListPickerState createState() => _ImageListPickerState();
}

class _ImageListPickerState extends State<ImageListPicker> {
  final ImagePicker imagePicker = ImagePicker();

  List<String> get selectedLayer => widget.selectedLayer;
  int get itemCount => widget.itemCount;
  Function(String) get onSelectPressed => widget.onSelectPressed;
  Function(int) get onDeletePressed => widget.onDeletePressed;

  Future<void> selectGaleryImage() async {
    final List<XFile>? selectedImage =
        await imagePicker.pickMultiImage(maxHeight: 600, maxWidth: 600);
    if ((selectedImage?.length ?? 0) > 0) {
      for (final XFile image in selectedImage!) {
        onSelectPressed(image.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CustomRoundedButton(
            onPressed: selectGaleryImage,
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
