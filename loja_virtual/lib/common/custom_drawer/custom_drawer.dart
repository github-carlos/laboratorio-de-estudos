import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          DrawerTile(
            icon: Icons.home,
            title: 'Inicio',
            page: 0,
          ),
          DrawerTile(
            icon: Icons.list,
            title: 'Produtos',
            page: 1,
          ),
          DrawerTile(
            icon: Icons.playlist_add_check,
            title: 'Meus Pedidos',
            page: 2,
          ),
          DrawerTile(
            icon: Icons.location_on,
            title: 'Lojas',
            page: 3,
          ),
        ],
      ),
    );
  }
}
