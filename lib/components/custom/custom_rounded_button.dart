import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton({
    required this.onPressed,
    required this.child,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,      
      child: child,
    );
  }
}
