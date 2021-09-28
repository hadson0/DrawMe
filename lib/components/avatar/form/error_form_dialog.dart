import 'package:flutter/material.dart';

class ErrorFormDialog extends StatelessWidget {
  const ErrorFormDialog({
    required this.message,
    Key? key,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ocorreu um Erro!'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
