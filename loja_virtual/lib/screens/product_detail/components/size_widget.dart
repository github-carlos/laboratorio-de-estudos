import 'package:flutter/material.dart';
import 'package:loja_virtual/models/item_size.dart';

class SizeWidget extends StatelessWidget {
  final ItemSize size;
  SizeWidget(this.size);
  @override
  Widget build(BuildContext context) {
    final borderColor = !size.hasStock ? Colors.red.withAlpha(60) : Colors.grey;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: borderColor,
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              size.name,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('R\$ ${size.price.toStringAsFixed(2)}', style: TextStyle(color: borderColor),),
          )
        ],
      ),
    );
  }
}
