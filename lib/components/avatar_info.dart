import 'package:flutter/material.dart';

import 'package:drawme/models/avatar.dart';

class AvatarInfo extends StatelessWidget {
  final Avatar avatar;

  const AvatarInfo(
    this.avatar, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Row(
            children: [
              Icon(
                Icons.tag_rounded,
                color: Colors.blue.shade900,
              ),
              SizedBox(width: 6),
              Row(
                children: avatar.tags.map((avt) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 3,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        avt,
                        style: TextStyle(color: Colors.blue.shade900),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Container(
          width: 300,
          height: 250,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                'Descrição:',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 6,
              ),
              SingleChildScrollView(child: Text(avatar.description)),
            ],
          ),
        ),
      ],
    );
  }
}
