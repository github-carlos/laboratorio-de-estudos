import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/models/section_item.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  final SectionItem sectionItem;

  ItemTile(this.sectionItem);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (sectionItem.product != null) {
          final product  = context.read<ProductManager>().findProductById(sectionItem.product);
          if (product != null) {
            Navigator.of(context).pushNamed('/product', arguments: product);
          }
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: sectionItem.image,
          fit: BoxFit.cover,
        )
      ),
    );
  }
}
