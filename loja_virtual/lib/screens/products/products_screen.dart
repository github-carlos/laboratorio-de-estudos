import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/screens/products/components/product_list_tile.dart';
import 'package:provider/provider.dart';

import 'components/search_dialog.dart';

class ProductsScreen extends StatelessWidget {
  Future<void> openShowDialog(context, productManager) async {
    final search = await showDialog<String>(
        context: context, builder: (_) => SearchDialog(initialText: productManager.search,));
    if (search != null) {
      productManager.search = search;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ProductManager>(builder: (_, productManager, __) {
          if (productManager.search.isEmpty) {
            return Text('Produtos');
          } else {
            return LayoutBuilder(builder: (_, constraints) {
              return GestureDetector(
                onTap: () {
                  openShowDialog(context, productManager);
                },
                child: Container(
                  width: constraints.biggest.width,
                  child: Text(
                    productManager.search,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            });
          }
        }),
        actions: [
          Consumer<ProductManager>(
            builder: (_, productManager, __) {
              return productManager.search.isEmpty
                  ? IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () => openShowDialog(context, productManager),
                    )
                  : IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        productManager.search = '';
                      },
                    );
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
              return ProductListTile(product: filteredProducts[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.shopping_cart),
        onPressed: () => Navigator.pushNamed(context, '/cart'),
      ),
    );
  }
}
