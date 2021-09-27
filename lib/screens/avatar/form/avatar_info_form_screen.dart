import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:drawme/components/avatar/form/avatar_text_form.dart';
import 'package:drawme/components/custom/custom_rounded_button.dart';
import 'package:drawme/models/avatar/avatar.dart';
import 'package:drawme/models/avatar/avatar_list.dart';
import 'package:drawme/models/avatar/canvas.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AvatarInfoFormScreen extends StatefulWidget {
  const AvatarInfoFormScreen({
    required this.canvas,
    required this.onBackPressed,
    required this.onNextPressed,
    Key? key,
  }) : super(key: key);

  final Canvas canvas;
  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;

  @override
  _AvatarInfoFormScreenState createState() => _AvatarInfoFormScreenState();
}

class _AvatarInfoFormScreenState extends State<AvatarInfoFormScreen> {
  final ImagePicker picker = ImagePicker();
  Map<String, String> formData = <String, String>{};
  final List<String> tagList = [];

  final GlobalKey<AvatarTextFormState> formKey =
      GlobalKey<AvatarTextFormState>();

  XFile? image;

  Canvas get canvas => widget.canvas;
  void onBackPressed() => widget.onBackPressed();
  void onNextPressed() => widget.onNextPressed();

  Future<void> selectGaleryImage() async {
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage!.path.isNotEmpty) {
      setState(() => image = selectedImage);
    }
  }

  void submitForm() {
    final bool isValid = formKey.currentState?.validateForm() ?? false;
    if (!isValid || image == null) {
      return;
    }

    formKey.currentState?.saveForm();

    final List<String> _tagsSplit = formData['tags']!.split(', ');

    for (final String tag in _tagsSplit) {
      if (!tagList.contains(tag) && tag != '') {
        setState(() => tagList.add(tag));
      }
    }

    final Avatar avatar = Avatar(
      id: Random().nextDouble().toString(),
      name: formData['name']!,
      tags: tagList,
      author: 'Hadson',
      avatarSample: image!.path,
      description: formData['description']!,
    );
    avatar.canvas = canvas;

    Provider.of<AvatarList>(context, listen: false).addAvatar(avatar);
    onNextPressed();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Column(
          children: [
            AvatarTextForm(
              key: formKey,
              formData: formData,
              onFormSaved: (_formData) => setState(() => formData = _formData),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Expanded(
                  child: AutoSizeText(
                    'Selecione um modelo para o avatar',
                    maxLines: 2,
                  ),
                ),
                GestureDetector(
                  onTap: selectGaleryImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: image == null
                        ? Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text('Selecionar\n Imagem'),
                            ),
                          )
                        : SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.file(
                              File(image!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomRoundedButton(
                  onPressed: onBackPressed,
                  child: const Text('VOLTAR'),
                ),
                CustomRoundedButton(
                  onPressed: submitForm,
                  child: const Text('CONCLUIR'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
