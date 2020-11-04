import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:loja_virtual/models/product.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Product> _allProducts = [];
  List<Product> get allProducts {
    return _allProducts;
  }

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts =
        await firestore.collection('products').get();
    _allProducts = snapProducts.docs.map((d) => Product.fromDocument(d)).toList();
    notifyListeners();
  }
}
