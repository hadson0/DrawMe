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
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text(
        'Ocorreu um Erro!',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white70,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            'OK',
            style: TextStyle(
              color: Theme.of(context).indicatorColor,
            ),
          ),
        ),
      ],
    );
  }
}
