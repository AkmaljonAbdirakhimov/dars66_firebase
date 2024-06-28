import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsFirebaseServices {
  final _productsCollection = FirebaseFirestore.instance.collection("products");

  Stream<QuerySnapshot> getProducts() async* {
    yield* _productsCollection.snapshots();
  }

  void editProduct(String id, String title) {
    //Todo UPDATE
    _productsCollection.doc(id).update({
      "title": title,
      "price": 12313,
    });

    //! DELETE
    // _productsCollection.doc(id).delete();

    //? ADD
    // _productsCollection.add({
    //   "title": title,
    //   "price": 9999,
    //   "color": Colors.red.value,
    // });
  }
}
