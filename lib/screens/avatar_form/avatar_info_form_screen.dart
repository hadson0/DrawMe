import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:drawme/components/avatar_form/avatar_form_tag_bar.dart';
import 'package:drawme/components/avatar_form/cancel_form_dialog.dart';
import 'package:drawme/models/avatar/avatar.dart';
import 'package:drawme/models/avatar/avatar_list.dart';
import 'package:drawme/models/avatar/canvas.dart';
import 'package:drawme/utils/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AvatarInfoFormScreen extends StatefulWidget {
  const AvatarInfoFormScreen(
    this.canvas, {
    Key? key,
  }) : super(key: key);

  final Canvas canvas;

  static Route<Route<MaterialPageRoute>> route({
    required Canvas canvas,
  }) {
    return MaterialPageRoute(
      builder: (BuildContext context) => AvatarInfoFormScreen(canvas),
    );
  }

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

  XFile? _image;

  Canvas get canvas => widget.canvas;

  Future<void> selectGaleryImage() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (selectedImage!.path.isNotEmpty) {
      setState(() => _image = selectedImage);
    }
  }

  void submitForm() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid || _image == null) {
      return;
    }

    _formKey.currentState?.save();

    final Avatar avatar = Avatar(
      id: Random().nextDouble().toString(),
      name: _formData['name']! as String,
      tags: _tagList,
      author: 'Hadson',
      avatarSample: _image!.path,
      description: _formData['description']! as String,
    );
    avatar.canvas = canvas;

    Provider.of<AvatarList>(context, listen: false).addAvatar(avatar);
    _formKey.currentState?.save();

    Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
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
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Criar Avatar'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: <Widget>[
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Nome do Avatar'),
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
                    onSaved: (String? _tags) {
                      final String tags = _tags ?? '';
                      for (final String tag in tags.split(', ')) {
                        if (!_tagList.contains(tag) && tag != '') {
                          setState(() => _tagList.add(tag));
                        }
                      }
                    },
                    onFieldSubmitted: (String tags) {
                      for (final String tag in tags.split(', ')) {
                        if (!_tagList.contains(tag) && tag != '') {
                          setState(() => _tagList.add(tag));
                        }
                      }
                      FocusScope.of(context).requestFocus(_descriptionFocus);
                    },
                    validator: (_) {
                      if (_tagList.length < 3) {
                        return 'Insira ao menos 3 tags!';
                      }

                      for (final String tag in _tagList) {
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
                          child: _image == null
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
                                    File(_image!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: submitForm,
            child: const Icon(Icons.save),
          ),
        ),
      ),
    );
  }
}
