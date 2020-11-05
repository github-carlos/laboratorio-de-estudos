import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/screens/product_detail/components/size_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({this.product});
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images:
                    product.images.map((image) => NetworkImage(image)).toList(),
                dotSize: 4,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                dotSpacing: 15,
                autoplay: false,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'A partir de',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ),
                    Text(
                      'R\$ 19.99',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        'Descrição',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(product.description, style: TextStyle(fontSize: 16)),
                    Text(
                      'Tamanhos',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                        children: product.sizes.map((e) {
                      return SizeWidget(e); 
                    }).toList()),
                  ],
                ))
          ],
        ));
  }
}
