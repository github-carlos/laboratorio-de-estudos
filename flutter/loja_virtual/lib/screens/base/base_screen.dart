import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/page_manager.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/screens/home/home_screen.dart';
import 'package:loja_virtual/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController: _pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              ProductsScreen(),
              Scaffold(
                appBar: AppBar(
                  title: Text('Home3'),
                ),
                drawer: CustomDrawer(),
              ),
              Scaffold(
                appBar: AppBar(
                  title: Text('Home4'),
                ),
                drawer: CustomDrawer(),
              ),
              if (userManager.adminEnabled) ...[
                Scaffold(
                  drawer: CustomDrawer(),
                  appBar: AppBar(
                    title: Text('Usuários'),
                  ),
                ),
                Scaffold(
                  drawer: CustomDrawer(),
                  appBar: AppBar(
                    title: Text('Pedidos'),
                  ),
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
