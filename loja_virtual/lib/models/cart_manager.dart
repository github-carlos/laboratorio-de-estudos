import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/cart_product.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';

class CartManager {
  List<CartProduct> items = [];
  UserData user;
  void updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();

    if (user != null) {
      _loadCartItems();
    }
  }
  void addToCart(Product product) {
    items.add(CartProduct.fromProduct(product),);
  }

  Future<void>_loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartReference.get();

    items = cartSnap.docs.map((e) => CartProduct.fromDocument(e)).toList();
  }
}