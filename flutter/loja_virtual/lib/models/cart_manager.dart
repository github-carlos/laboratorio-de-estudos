import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/cart_product.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];
  UserData user;
  num productsPrice = 0.0;
  void updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();

    if (user != null) {
      _loadCartItems();
    }
  }

  void addToCart(Product product) {
    try {
      final e = items.firstWhere(
        (p) => p.stackable(product),
      );
      e.increment();
    } catch (err) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdate);
      items.add(
        cartProduct,
      );
      user.cartReference.add(
        cartProduct.toMap(),
      ).then((document) => cartProduct.id = document.id );
      _onItemUpdate();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartReference.get();

    items = cartSnap.docs.map((e) => CartProduct.fromDocument(e)..addListener(_onItemUpdate)).toList();
  }
  void _onItemUpdate() {
    productsPrice = 0;

    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];
      if(cartProduct.quantity == 0) {
        removeOfCart(cartProduct);
        i--;
        continue;
      }
      productsPrice += cartProduct.totalPrice;

      _updateCartProduct(cartProduct);
    }
    print(productsPrice);
  }

  void removeOfCart(CartProduct cartProduct) {
    items.removeWhere((element) => element.id == cartProduct.id);
    user.cartReference.doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdate);
    notifyListeners();
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if (cartProduct.id != null) {
      user.cartReference.doc(cartProduct.id).update(cartProduct.toMap());
    }
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) return false;
    }
    return true;
  }
}
