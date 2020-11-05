import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/item_size.dart';

class Product {
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
}
