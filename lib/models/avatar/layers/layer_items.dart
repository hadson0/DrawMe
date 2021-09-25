import 'package:drawme/models/avatar/layers/layer_item.dart';

enum LayerNames {
  background,
  body,
  head,
  eyes,
  eyebrow,
  nose,
  mouth,
  cheeks,
  spots,
  ears,
  hair,
  mustache,
  beard,
  glasses,
  tshirt,
  coat,
  pants,
  hat,
  bothHands,
  leftHand,
  rightHand,
  accessory,
  baloon,
}

class LayerItems {
  static const background = LayerItem(
    title: 'Fundo',
    layerName: LayerNames.background,
  );
  static const body = LayerItem(
    title: 'Corpo',
    layerName: LayerNames.body,
  );
  static const head = LayerItem(
    title: 'Cabeça',
    layerName: LayerNames.head,
  );
  static const eyes = LayerItem(
    title: 'Olhos',
    layerName: LayerNames.eyes,
  );
  static const eyebrow = LayerItem(
    title: 'Sobrancelhas',
    layerName: LayerNames.eyebrow,
  );
  static const cheeks = LayerItem(
    title: 'Bochechas',
    layerName: LayerNames.cheeks,
  );
  static const mouth = LayerItem(
    title: 'Boca',
    layerName: LayerNames.mouth,
  );
  static const nose = LayerItem(
    title: 'Nariz',
    layerName: LayerNames.nose,
  );
  static const spots = LayerItem(
    title: 'Marcas',
    layerName: LayerNames.spots,
  );
  static const ears = LayerItem(
    title: 'Orelhas',
    layerName: LayerNames.ears,
  );
  static const hair = LayerItem(
    title: 'Cabelo',
    layerName: LayerNames.hair,
  );
  static const mustache = LayerItem(
    title: 'Bigode',
    layerName: LayerNames.mustache,
  );
  static const beard = LayerItem(
    title: 'Barba',
    layerName: LayerNames.beard,
  );
  static const glasses = LayerItem(
    title: 'Óculos',
    layerName: LayerNames.glasses,
  );
  static const tshirt = LayerItem(
    title: 'Camiseta',
    layerName: LayerNames.tshirt,
  );
  static const coat = LayerItem(
    title: 'Blusa',
    layerName: LayerNames.coat,
  );
  static const pants = LayerItem(
    title: 'Calças',
    layerName: LayerNames.pants,
  );
  static const hat = LayerItem(
    title: 'Chapéu',
    layerName: LayerNames.hat,
  );
  static const bothHands = LayerItem(
    title: 'As duas mãos',
    layerName: LayerNames.bothHands,
  );
  static const leftHand = LayerItem(
    title: 'Mão esquerda',
    layerName: LayerNames.leftHand,
  );
  static const rightHand = LayerItem(
    title: 'Mão direita',
    layerName: LayerNames.rightHand,
  );
  static const accessory = LayerItem(
    title: 'Acessório',
    layerName: LayerNames.accessory,
  );
  static const balloon = LayerItem(
    title: 'Balão',
    layerName: LayerNames.baloon,
  );

  static const List<LayerItem> all = [
    background,
    body,
    head,
    eyes,
    eyebrow,
    cheeks,
    mouth,
    nose,
    spots,
    ears,
    hair,
    mustache,
    beard,
    glasses,
    tshirt,
    coat,
    pants,
    hat,
    bothHands,
    leftHand,
    rightHand,
    accessory,
    balloon,
  ];
}
