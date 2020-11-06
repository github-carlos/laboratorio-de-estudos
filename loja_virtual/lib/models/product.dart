import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:loja_virtual/models/item_size.dart';

class Product extends ChangeNotifier {
  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizes;

  Product.fromDocument(DocumentSnapshot document) {
    id = document.data()['id'];
    name = document.data()['name'];
    description = document.data()['description'];
    images = List<String>.from(document.data()['images'] as List<dynamic>);
    sizes = (document.data()['sizes'] as List<dynamic>)
        .map((e) => ItemSize.fromMap(e as Map<String, dynamic>))
        .toList();
  }
  Product({this.name, this.description, this.images});

  ItemSize _selectedSize;

  set selectedSize(ItemSize value) {
    _selectedSize = value;
    notifyListeners();
  }

  ItemSize get selectedSize => _selectedSize;
  int get totalStock {
    int stock = 0;
    for (final size in sizes) {
      stock += size.stock;
    }
    return stock;
  }

  ItemSize findSize(String size) {
    try {
      return sizes.firstWhere((element) => element.name == size);
    } catch(err) {
      return null;
    }
  }
}
