import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:drawme/components/avatar_form/avatar_form_tag_bar.dart';
import 'package:drawme/models/avatar/avatar.dart';
import 'package:drawme/models/avatar/avatar_list.dart';
import 'package:drawme/models/avatar/canvas.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AvatarInfoFormScreen extends StatefulWidget {
  const AvatarInfoFormScreen({
    Key? key,
    required this.canvas,
    required this.onBackPressed,
    required this.onNextPressed,
  }) : super(key: key);

  final Canvas canvas;
  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;

  @override
  _AvatarInfoFormScreenState createState() => _AvatarInfoFormScreenState();
}

class _AvatarInfoFormScreenState extends State<AvatarInfoFormScreen> {
  final ImagePicker _picker = ImagePicker();
  final Map<String, Object> _formData = <String, Object>{};
  final List<String> _tagList = [];
  final FocusNode _tagFocus = FocusNode();
  final FocusNode _authorFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? image;

  Canvas get canvas => widget.canvas;
  void onBackPressed() => widget.onBackPressed();
  void onNextPressed() => widget.onNextPressed();

  Future<void> selectGaleryImage() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (selectedImage!.path.isNotEmpty) {
      setState(() => image = selectedImage);
    }
  }

  void submitForm() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid || image == null) {
      return;
    }

    _formKey.currentState?.save();

    final Avatar avatar = Avatar(
      id: Random().nextDouble().toString(),
      name: _formData['name']! as String,
      tags: _tagList,
      author: 'Hadson',
      avatarSample: image!.path,
      description: _formData['description']! as String,
    );
    avatar.canvas = canvas;

    Provider.of<AvatarList>(context, listen: false).addAvatar(avatar);
    _formKey.currentState?.save();

    onNextPressed();
  }

  @override
  void dispose() {
    _tagFocus.dispose();
    _authorFocus.dispose();
    _descriptionFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: <Widget>[
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Nome do Avatar'),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_tagFocus),
            onSaved: (String? name) => _formData['name'] = name ?? '',
            validator: (String? _name) {
              final String name = _name ?? '';

              if (name.trim().isEmpty) {
                return 'Nome é obrigatório!';
              } else if (name.trim().length < 5) {
                return 'Nome precisa de no mínimo 5 letras!';
              }

              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Tags',
              hintText: 'Ex.: cartoon, colorido, feliz',
            ),
            textInputAction: TextInputAction.next,
            focusNode: _tagFocus,
            onFieldSubmitted: (String tags) {
              for (final String tag in tags.split(', ')) {
                if (!_tagList.contains(tag) && tag != '') {
                  setState(() => _tagList.add(tag));
                }
              }
              FocusScope.of(context).requestFocus(_descriptionFocus);
            },
            onSaved: (String? _tags) {
              final String tags = _tags ?? '';
              for (final String tag in tags.split(', ')) {
                if (!_tagList.contains(tag) && tag != '') {
                  setState(() => _tagList.add(tag));
                }
              }
            },
            validator: (String? _tags) {
              final String tags = _tags ?? '';
              if (tags.split(', ').length < 3) {
                return 'Insira ao menos 3 tags diferentes!';
              }

              for (final String tag in tags.split(', ')) {
                if (tag.trim().length < 3) {
                  return 'As tags precisam de no mínimo 3 letras!';
                }
              }

              return null;
            },
          ),
          const SizedBox(height: 20),
          AvatarFormTagBar(
            tagList: _tagList,
            onDeleteTapped: (String oldTag) => setState(
              () => _tagList.removeWhere((String tag) => tag == oldTag),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Descrição'),
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            focusNode: _descriptionFocus,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_descriptionFocus),
            onSaved: (String? description) =>
                _formData['description'] = description ?? '',
            validator: (String? _description) {
              final String description = _description ?? '';

              if (description.trim().isEmpty) {
                return 'A descrição é obrigatória!';
              } else if (description.trim().length < 10) {
                return 'A descrição precisa de no mínimo 10 letras!';
              }

              return null;
            },
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
              ElevatedButton(
                onPressed: onBackPressed,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('VOLTAR'),
              ),
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('CONCLUIR'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
