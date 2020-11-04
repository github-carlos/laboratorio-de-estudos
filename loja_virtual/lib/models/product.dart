import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;
  String description;
  List<String> images;

  Product.fromDocument(DocumentSnapshot document) {
    id = document.data()['id'];
    name = document.data()['name'];
    description = document.data()['description'];
    images = List<String>.from(document.data()['images'] as List<dynamic>);
  }
  Product({this.name, this.description, this.images});
}