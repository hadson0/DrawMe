import 'package:drawme/components/avatar_form/avatar_form_tag_bar.dart';
import 'package:flutter/material.dart';

class AvatarTextForm extends StatefulWidget {
  const AvatarTextForm({
    required this.formData,
    required this.onFormSaved,
    Key? key,
  }) : super(key: key);

  final Map<String, String> formData;
  final void Function(Map<String, String>) onFormSaved;

  @override
  AvatarTextFormState createState() => AvatarTextFormState();
}

class AvatarTextFormState extends State<AvatarTextForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _tagFocus = FocusNode();
  final FocusNode _authorFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final _tagController = TextEditingController();

  Map<String, String> get _formData => widget.formData;
  void Function(Map<String, String>) get _onFormSaved => widget.onFormSaved;

  String? _nameValidator(String? _name) {
    final String name = _name ?? '';

    if (name.trim().isEmpty) {
      return 'Nome é obrigatório!';
    } else if (name.trim().length < 5) {
      return 'Nome precisa de no mínimo 5 letras!';
    }

    return null;
  }

  String? _tagsValidator(String? _tags) {
    final String tags = _tags ?? '';
    final List<String> tagList = tags.split(', ');

    if (tagList.length < 3) {
      return 'Insira ao menos 3 tags diferentes!';
    }

    for (final String tag in tagList) {
      if (tag.trim().length < 3 && tag != '') {
        return 'As tags precisam de no mínimo 3 letras!';
      }
    }

    return null;
  }

  String? _descriptionValidator(String? _description) {
    final String description = _description ?? '';

    if (description.trim().isEmpty) {
      return 'A descrição é obrigatória!';
    } else if (description.trim().length < 10) {
      return 'A descrição precisa de no mínimo 10 letras!';
    }

    return null;
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
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Nome do Avatar',
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
            ),
            cursorColor: Theme.of(context).primaryColorLight,
            style: const TextStyle(color: Colors.white70),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_tagFocus),
            onSaved: (String? name) {
              _formData['name'] = name ?? '';
            },
            validator: _nameValidator,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _tagController,
            focusNode: _tagFocus,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Tags',
              hintText: 'Ex.: cartoon, colorido, feliz',
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
            ),
            cursorColor: Theme.of(context).primaryColorLight,
            style: const TextStyle(color: Colors.white70),
            onChanged: (_) => setState(() {}),
            onFieldSubmitted: (String tags) {
              FocusScope.of(context).requestFocus(_descriptionFocus);
            },
            onSaved: (String? tags) => _formData['tags'] = tags ?? '',
            validator: _tagsValidator,
          ),
          const SizedBox(height: 20),
          AvatarFormTagBar(tagList: _tagController.text.split(', ')),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Descrição',
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
            ),
            cursorColor: Theme.of(context).primaryColorLight,
            style: const TextStyle(color: Colors.white70),
            keyboardType: TextInputType.multiline,
            maxLines: 7,
            focusNode: _descriptionFocus,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_descriptionFocus),
            onSaved: (String? description) =>
                _formData['description'] = description ?? '',
            validator: _descriptionValidator,
          ),
        ],
      ),
    );
  }

  bool validateForm() {
    if (_formKey.currentState?.validate() ?? false) {
      return true;
    }
    return false;
  }

  void saveForm() {
    _formKey.currentState?.save();
    _onFormSaved(_formData);
  }
}
