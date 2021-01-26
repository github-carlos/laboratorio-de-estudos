import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer_header.dart';
import 'package:loja_virtual/common/custom_drawer/drawer_tile.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [
              Color.fromARGB(255, 203, 236, 241),
              Colors.white,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          ListView(
            physics: BouncingScrollPhysics(),
            children: [
              CustomDrawerHeader(),
              Divider(),
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
              Consumer<UserManager>(
                builder: (_, userManager, __) {
                  print('enable ${userManager.adminEnabled}');
                  if (userManager.adminEnabled) {
                    return Column(
                      children: [
                        Divider(),
                        DrawerTile(icon: Icons.settings, title: "Usuários" , page: 4),
                        DrawerTile(icon: Icons.settings, title: "Pedidos" , page: 5)
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
