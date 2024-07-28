import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Product extends Equatable {
  final int id;
  final String productName;
  final String img;
  final double price;
  final String description;
  final int stock;
  const Product({
    required this.id,
    required this.productName,
    required this.price,
    required this.img,
    required this.description,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['productName'],
      img: json['img'],
      price: json['price'],
      description: json['description'],
      stock: json['stock'],
    );
  }

  @override
  List<Object?> get props => [];
}

final productListProvider = FutureProvider<List<Product>>((ref) async {
  final randomValue = Random().nextInt(2);

  return await Future.delayed(const Duration(seconds: 3), () {
    if (randomValue == 2) throw Exception();
    return productMockList;
  });
});

final productMockList = <Product>[
  const Product(
      id: 01,
      productName: 'Panadol',
      price: 3.75,
      img: 'assets/images/panadol.png',
      description:
          'Panadol has Paracetamol as active ingredient and is available in drops 100 mg/ml, syrup 120 mg/5 ml and caplet 500 mg.',
      stock: 12),
  const Product(
      id: 02,
      productName: 'Aloe Via Aloe Vera',
      price: 7.40,
      img: 'assets/images/aloe_vera.png',
      description: 'Gofen has the active ingredient Ibuprofen 400mg.'
          ' Ibuprofen is a non-steroidal anti-inflammatory drug (NSAID),'
          ' a class of propionic acid derivatives. Ibuprofen, '
          'like other non-steroidal anti-inflammatory drugs, has analgesic, '
          'antipyretic and anti-inflammatory effects.',
      stock: 21),
  const Product(
      id: 03,
      productName: 'Gofen',
      price: 7.40,
      img: 'assets/images/gofen.png',
      description: 'Gofen has the active ingredient Ibuprofen 400mg.'
          ' Ibuprofen is a non-steroidal anti-inflammatory drug (NSAID),'
          ' a class of propionic acid derivatives. Ibuprofen, '
          'like other non-steroidal anti-inflammatory drugs, has analgesic, '
          'antipyretic and anti-inflammatory effects.',
      stock: 40),
  const Product(
      id: 04,
      productName: 'Avilin Gastro',
      price: 11.30,
      img: 'assets/images/avilin_gastro.png',
      description: 'Each ml contains Pheniramine maleate 22.75 mg.'
          ' It is used for quick relief from allergic manifestations. '
          'For quick relief from allergic manifestations.',
      stock: 19),
  const Product(
      id: 05,
      productName: 'Sundown Natural Fish Oil',
      price: 10.42,
      img: 'assets/images/fish_oil_sundown_natural.png',
      description: 'Taking Sundown Fish Oil Softgels may'
          ' support healthy circulation; helps '
          'maintain healthy triglyceride levels'
          ' already within a normal range (2); '
          'and may reduce the risk of coronary heart disease',
      stock: 10),
  const Product(
      id: 06,
      productName: 'Blackmore\'s Vitamin C',
      price: 12.20,
      img: 'assets/images/blackmores_vit_c.png',
      description:
          'Bronson Basics Vitamin C provides 500 MG of C as Ascorbic Acid'
          ' per vegetarian tablet to support a healthy'
          ' immune system and promote antioxidant protection.*'
          ' We strive to support your good health and '
          'well-being through high quality supplements at the best value.',
      stock: 4),
  const Product(
      id: 07,
      productName: 'Effaralgan®',
      price: 2.13,
      img: 'assets/images/efferalgan.png',
      description:
          'Efferalgan® is a medicine based on paracetamol and the reference product for effervescence in France',
      stock: 20),
  const Product(
      id: 08,
      productName: 'Forever Aloe Vera',
      price: 9.99,
      img: 'assets/images/forever_aloe_ver_gel.png',
      description:
          'Our aloe vera gel is sourced from the inner leaf of the aloe'
          ' plant. Processed to retain maximum purity, '
          'with 99.7% of the gel-derived directly from the inner leaf',
      stock: 16),
  const Product(
      id: 09,
      productName: 'Nexium',
      price: 22.44,
      img: 'assets/images/nexiium.png',
      description: ' each mini capsule, esomeprazole 20 mg,'
          ' acid reducer; each delayed-release mini'
          ' capsule corresponds to 22 mg esomeprazole '
          'magnesium dihydrate; compare to the active '
          'ingredient in Nexium 24 HR Clear Minis',
      stock: 25),
  const Product(
      id: 10,
      productName: 'Prilosec',
      price: 22.44,
      img: 'assets/images/prilosec.png',
      description: 'This medication helps heal acid damage'
          ' to the stomach and esophagus, helps prevent'
          ' ulcers, and may help prevent cancer '
          'of the esophagus. Omeprazole belongs '
          'to a class of drugs known as proton pump inhibitors',
      stock: 32),
];
