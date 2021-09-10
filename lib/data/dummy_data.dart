import 'dart:math';

import 'package:drawme/models/avatar.dart';

final dummyAvatars = [
  Avatar(
    id: Random().nextDouble().toString(),
    name: 'Homem',
    author: 'Pedrinho Artes',
    imagePath: 'lib/assets/images/homem.jpg',
    tags: ['masculino', 'sorrindo'],
    description: 'Avatar de um homem sorridno',
  ),
  Avatar(
    id: Random().nextDouble().toString(),
    name: 'Mulher',
    author: 'Gabi Desenhos',
    imagePath: 'lib/assets/images/mulher.jpg',
    tags: ['femenino', 'sorrindo'],
    description: 'Avatar de uma mulher sorridno',
  ),
  Avatar(
    id: Random().nextDouble().toString(),
    name: 'Naruto',
    author: 'Dragon Ball Z',
    imagePath: 'lib/assets/images/luffy.png',
    tags: ['PirataQueEstica', 'DesenhoChines'],
    description: 'Avatar, o ultimo mestre do ar',
  ),
];
