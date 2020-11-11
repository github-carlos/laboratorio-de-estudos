import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/cart_product.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  CartTile({@required this.cartProduct});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(cartProduct.product.images.first),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    children: [
                      Text(
                        cartProduct.product.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Tamanho: ${cartProduct.size}',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                      Text(
                        'R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<CartProduct>(builder: (_, cart, __) {
                return Column(
                  children: [
                    CustomIconButton(
                      iconData: Icons.add,
                      color: Theme.of(context).primaryColor,
                      onTap: cartProduct.increment,
                    ),
                    Text(
                      '${cartProduct.quantity}',
                      style: TextStyle(fontSize: 20),
                    ),
                    CustomIconButton(
                      iconData: Icons.remove,
                      color:  cartProduct.quantity > 1 ? Theme.of(context).primaryColor : Colors.red,
                      onTap: cartProduct.decrement,
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
