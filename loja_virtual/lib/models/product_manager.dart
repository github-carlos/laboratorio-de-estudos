import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:loja_virtual/models/product.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Product> _allProducts = [];

  String _search = '';

  String get search {
    return _search;
  }

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];

    if (search.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(
        allProducts.where((product) =>
            product.name.toLowerCase().contains(search.toLowerCase())),
      );
    }
    return filteredProducts;
  }

  List<Product> get allProducts {
    return _allProducts;
  }

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts =
        await firestore.collection('products').get();
    _allProducts =
        snapProducts.docs.map((d) => Product.fromDocument(d)).toList();
    notifyListeners();
  }
}
