import 'dart:math';

import 'package:drawme/models/avatar.dart';

final dummyAvatars = [
  Avatar(
    id: Random().nextDouble().toString(),
    name: 'Homem',
    author: 'Pedrinho Artes',
    avatarSample: 'lib/assets/images/homem.jpg',
    tags: [
      'masculino',
      'sorrindo',
      'falsidade',
      'brasileiro',
      'desempregado',
      'prata'
    ],
    description: 'Avatar de um homem sorrindo',
  ),
  Avatar(
    id: Random().nextDouble().toString(),
    name: 'Mulher',
    author: 'Gabi Desenhos',
    avatarSample: 'lib/assets/images/mulher.jpg',
    tags: ['femenino', 'sorrindo'],
    description: 'Avatar de uma mulher sorrindo',
  ),
  Avatar(
    id: Random().nextDouble().toString(),
    name: 'Naruto',
    author: 'Dragon Ball Z',
    avatarSample: 'lib/assets/images/luffy.png',
    tags: ['PirataQueEstica', 'DesenhoChines'],
    description: 'Avatar, o ultimo mestre do ar',
  ),
];
