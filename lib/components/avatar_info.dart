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
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                avatar.name,
                style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Text(
                avatar.author,
                style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 35,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
          ),
          child: Row(
            children: [
              Icon(
                Icons.tag_rounded,
                color: Colors.blue.shade900,
              ),
              SizedBox(width: 6),
              SingleChildScrollView(
                child: Row(
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
              ),
            ],
          ),
        ),
        Container(
          height: 250,
          width: double.infinity,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
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
