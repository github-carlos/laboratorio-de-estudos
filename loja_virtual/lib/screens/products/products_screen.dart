import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/screens/products/components/product_list_tile.dart';
import 'package:provider/provider.dart';

import 'components/search_dialog.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final search = await showDialog<String>(
                  context: context, builder: (_) => SearchDialog());
              if (search != null) {
                context.read<ProductManager>().search = search;
              }
            },
          )
        ],
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
        final filteredProducts = productManager.filteredProducts;
         return ListView.builder(
            padding: EdgeInsets.all(4),
            itemCount: filteredProducts.length,
            itemBuilder: (_, index) {
              return ProductListTile(
                  product: filteredProducts[index]);
            },
          );
        },
      ),
    );
  }
}
