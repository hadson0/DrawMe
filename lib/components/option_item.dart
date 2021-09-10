import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {
  final String title;
  final Color color;
  final Function() onTap;

  OptionItem({
    Key? key,
    required this.title,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 280,
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.all(5),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 30,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [
            color,
            color.withOpacity(0.4),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
      ),
    );
  }
}
