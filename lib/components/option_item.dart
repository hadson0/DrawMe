import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {
  const OptionItem({
    Key? key,
    required this.height,
    required this.width,
    required this.title,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  final double height;
  final double width;
  final String title;
  final Color color;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: <Color> [
              color,
              color.withOpacity(0.4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
