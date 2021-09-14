import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';

import 'package:drawme/components/avatar_form/avatar_form_tag_bar.dart';

import 'package:drawme/models/avatar.dart';
import 'package:drawme/models/avatar_list.dart';
import 'package:drawme/models/canvas.dart';

import 'package:drawme/utils/AppRoutes.dart';

class AvatarInfoFormScreen extends StatefulWidget {
  final Map<LayerNames, List<XFile>> layerMap;

  const AvatarInfoFormScreen({
    Key? key,
    required this.layerMap,
  }) : super(key: key);

  static Route<Route<MaterialPageRoute>> route({
    required Map<LayerNames, List<XFile>> layerMap,
  }) {
    return MaterialPageRoute(
      builder: (context) => AvatarInfoFormScreen(
        layerMap: layerMap,
      ),
    );
  }

  @override
  _AvatarInfoFormScreenState createState() => _AvatarInfoFormScreenState();
}

class _AvatarInfoFormScreenState extends State<AvatarInfoFormScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  final _formData = Map<String, Object>();
  List<String> _tagList = [];

  final _tagFocus = FocusNode();
  final _authorFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  Map<LayerNames, List<XFile>> get layerMap => widget.layerMap;

  void _selectGaleryImage() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage!.path.isNotEmpty) {
      setState(() {
        _image = selectedImage;
      });
    }
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid || _image == null) {
      print(!isValid);
      print(_image == null);
      return;
    }

    _formKey.currentState?.save();

    final avatar = Avatar(
      id: Random().nextDouble().toString(),
      name: _formData['name'] as String,
      tags: _tagList,
      author: 'Hadson',
      avatarSample: _image!.path,
      description: _formData['description'] as String,
    );

    layerMap.forEach((layerName, imageList) {
      avatar.canvas.addLayer(layerName);

      imageList.forEach((image) {
        avatar.canvas.addLayerImage(layerName, image.path);
      });
    });

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações'),
        actions: [
          TextButton( /* TODO: Alert Dialog */
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
            child: Text(  
              'CANCELAR',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome do Avatar'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_tagFocus);
                },
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (_name) {
                  final name = _name ?? '';

                  if (name.trim().isEmpty) {
                    return 'Nome é obrigatório!';
                  } else if (name.trim().length < 5) {
                    return 'Nome precisa de no mínimo 5 letras!';
                  }

                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tags'),
                textInputAction: TextInputAction.next,
                focusNode: _tagFocus,
                onFieldSubmitted: (tags) {
                  setState(() {
                    for (var tag in tags.split(', ')) {
                      _tagList.add(tag);
                    }
                  });
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                validator: (_) {
                  if (_tagList.length < 3) {
                    return 'Insira ao menos 3 tags!';
                  }

                  for (var tag in _tagList) {
                    if (tag.trim().length < 3)
                      return 'As tags precisam de no mínimo 3 letras!';
                  }

                  return null;
                },
              ),
              SizedBox(height: 20),
              AvatarFormTagBar(
                tagList: _tagList,
                onDeleteTapped: (deletedTag) {
                  setState(() {
                    _tagList.removeWhere((tag) => tag == deletedTag);
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                focusNode: _descriptionFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (description) =>
                    _formData['description'] = description ?? '',
                validator: (_description) {
                  final description = _description ?? '';

                  if (description.trim().isEmpty) {
                    return 'A descrição é obrigatória!';
                  } else if (description.trim().length < 10) {
                    return 'A descrição precisa de no mínimo 10 letras!';
                  }

                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    child: Text(
                      'Selecione uma imagem que servirá de modelo para o avatar',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: _selectGaleryImage,
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
                              child: Center(
                                child: Text('Selecionar\n Imagem'),
                              ),
                            )
                          : Container(
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
        onPressed: _submitForm,
        child: Icon(Icons.save),
      ),
    );
  }
}
