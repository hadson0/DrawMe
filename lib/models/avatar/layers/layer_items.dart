import 'package:drawme/models/avatar/layers/layer_item.dart';

enum LayerNames {
  BACKGROUND,
  BODY,
  HEAD,
  EYES,
  EYEBROW,
  NOSE,
  MOUTH,
  CHEEKS,
  SPOTS,
  EARS,
  HAIR,
  MUSTACHE,
  BEARD,
  GLASSES,
  TSHIRT,
  COAT,
  PANTS,
  HAT,
  BOTH_HANDS,
  LEFT_HAND,
  RIGHT_HAND,
  ACCESSORY,
  BALLOON,
}

class LayerItems {
  static const background = LayerItem(
    title: 'Fundo',
    layerName: LayerNames.BACKGROUND,
  );
  static const body = LayerItem(
    title: 'Corpo',
    layerName: LayerNames.BODY,
  );
  static const head = LayerItem(
    title: 'Cabeça',
    layerName: LayerNames.HEAD,
  );
  static const eyes = LayerItem(
    title: 'Olhos',
    layerName: LayerNames.EYES,
  );
  static const eyebrow = LayerItem(
    title: 'Sobrancelhas',
    layerName: LayerNames.EYEBROW,
  );
  static const nose = LayerItem(
    title: 'Nariz',
    layerName: LayerNames.NOSE,
  );
  static const mouth = LayerItem(
    title: 'Boca',
    layerName: LayerNames.MOUTH,
  );
  static const cheeks = LayerItem(
    title: 'Bochechas',
    layerName: LayerNames.CHEEKS,
  );
  static const spots = LayerItem(
    title: 'Marcas',
    layerName: LayerNames.SPOTS,
  );
  static const ears = LayerItem(
    title: 'Orelhas',
    layerName: LayerNames.EARS,
  );
  static const hair = LayerItem(
    title: 'Cabelo',
    layerName: LayerNames.HAIR,
  );
  static const mustache = LayerItem(
    title: 'Bigode',
    layerName: LayerNames.MUSTACHE,
  );
  static const beard = LayerItem(
    title: 'Barba',
    layerName: LayerNames.BEARD,
  );
  static const glasses = LayerItem(
    title: 'Óculos',
    layerName: LayerNames.GLASSES,
  );
  static const tshirt = LayerItem(
    title: 'Camiseta',
    layerName: LayerNames.TSHIRT,
  );
  static const coat = LayerItem(
    title: 'Blusa',
    layerName: LayerNames.COAT,
  );
  static const pants = LayerItem(
    title: 'Calças',
    layerName: LayerNames.PANTS,
  );
  static const hat = LayerItem(
    title: 'Chapéu',
    layerName: LayerNames.HAT,
  );
  static const bothHands = LayerItem(
    title: 'As duas mãos',
    layerName: LayerNames.BOTH_HANDS,
  );
  static const leftHand = LayerItem(
    title: 'Mão esquerda',
    layerName: LayerNames.LEFT_HAND,
  );
  static const rightHand = LayerItem(
    title: 'Mão direita',
    layerName: LayerNames.RIGHT_HAND,
  );
  static const accessory = LayerItem(
    title: 'Acessório',
    layerName: LayerNames.ACCESSORY,
  );
  static const balloon = LayerItem(
    title: 'Balão',
    layerName: LayerNames.BALLOON,
  );

  static const List<LayerItem> all = [
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
    balloon,
  ];
}
