import 'package:flutter/material.dart';
import 'package:loja_virtual/common/price_card.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

import 'components/cart_tile.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Carrinho',
        ),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {
          return ListView(
            children: [
              Column(
                children: cartManager.items
                    .map(
                      (e) => CartTile(cartProduct: e),
                    )
                    .toList(),
              ),
              PriceCard(buttonText: "Continuar para Entrega", onPressed: cartManager.isCartValid ? () {} : null,),
            ],
          );
        },
      ),
    );
  }
}
