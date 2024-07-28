import 'package:equatable/equatable.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:pharmacy_app/data/model/product/product.dart';

class CartItem extends Equatable {
  final int id;
  final String productName;
  final String img;
  final double price;
  final String description;
  final int quantity;
  const CartItem({
    required this.id,
    required this.productName,
    required this.price,
    required this.img,
    required this.description,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productName: json['productName'],
      img: json['img'],
      price: json['price'],
      description: json['description'],
      quantity: json['stock'],
    );
  }

  factory CartItem.fromProduct(Product product, int quantity) {
    return CartItem(
        id: product.id,
        productName: product.productName,
        price: product.price,
        img: product.img,
        description: product.description,
        quantity: quantity);
  }

  @override
  List<Object?> get props => [];

  CartItem copyWith({int? quantity}) {
    return CartItem(
        id: id,
        productName: productName,
        price: price,
        img: img,
        description: description,
        quantity: quantity ?? this.quantity);
  }
}
