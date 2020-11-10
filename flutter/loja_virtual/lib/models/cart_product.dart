import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/item_size.dart';
import 'package:loja_virtual/models/product.dart';

class CartProduct {
  CartProduct.fromProduct(this.product) {
    productId = product.id;
    quantity = 1;
    size = product.selectedSize.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    productId = document.data()['pid'] as String;
    quantity = document.data()['quantity'] as int;
    size = document.data()['size'] as String;

    firestore.doc('products/$productId').get().then((doc) => product = Product.fromDocument(doc));

  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String productId;
  int quantity;
  String size;

  Product product;

  ItemSize get itemSize {
    if (product == null) {
      return null;
    }
    return product.findSize(size);
  }

  num get unitPrice {
    if (product == null) {
      return 0;
    }
    return itemSize?.price ?? 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'pid': this.productId,
      'quantity': this.quantity,
      'size': this.size
    };
  }
  bool stackable(Product newProduct) {
   return productId == newProduct.id && size == newProduct.selectedSize.name;
  }
}