import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars64_statemanagement/services/products_firebase_services.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductsController extends ChangeNotifier {
  final _productsFirebaseServices = ProductsFirebaseServices();
  final List<Product> _list = [];

  Stream<QuerySnapshot> get list {
    return _productsFirebaseServices.getProducts();
  }

  void addProduct(String title, double price) {
    String id = UniqueKey().toString();
    int red = Random().nextInt(255);
    int green = Random().nextInt(255);
    int blue = Random().nextInt(255);
    Color color = Color.fromRGBO(red, green, blue, 1);

    _list.add(
      Product(
        id: id,
        title: title,
        price: price,
        color: color,
      ),
    );

    notifyListeners();
  }

  void editProduct(String id, String title) {
    _productsFirebaseServices.editProduct(id, title);
  }

  // void editProduct(
  //   String productId,
  //   String newTitle,
  //   double newPrice,
  // ) {
  //   int currentIndex = _list.indexWhere((product) {
  //     return product.id == productId;
  //   });

  //   if (currentIndex >= 0) {
  //     _list[currentIndex].title = newTitle;
  //     _list[currentIndex].price = newPrice;

  //     notifyListeners();
  //   }
  // }

  void deleteProduct(String productId) {
    _list.removeWhere((product) {
      return product.id == productId;
    });

    notifyListeners();
  }
}
