import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  PriceCard({this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Resumo do pedido',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal'),
                Text('R\$${productsPrice.toStringAsFixed(2)}')
              ],
            ),
            Divider(),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: TextStyle(fontWeight: FontWeight.w600),),
                Text('R\$${productsPrice.toStringAsFixed(2)}', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),)
              ],
            ),
            SizedBox(height: 8,),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              disabledColor: Theme.of(context).primaryColor.withAlpha(100),
              onPressed: this.onPressed,
              child: Text(this.buttonText),
            )
          ],
        ),
      ),
    );
  }
}
