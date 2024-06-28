import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product extends ChangeNotifier {
  final String id;
  String title;
  num price;
  Color color;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.color,
  });

  factory Product.fromMap(QueryDocumentSnapshot map) {
    return Product(
      id: map.id,
      title: map['title'],
      price: map['price'],
      color: Color(map['color']),
    );
  }
}
