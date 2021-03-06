import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:provider/provider.dart';

import 'components/section_list.dart';
import 'components/section_staggered.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 211, 118, 130),
              Color.fromARGB(255, 253, 181, 168)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                snap: true,
                floating: true,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                actions: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Loja do Carlos'),
                  centerTitle: true,
                ),
              ),
                Consumer<HomeManager>(
                  builder: (_, homeManager, __) {
                    final List<Widget> children = homeManager.sections.map<Widget>((section) {
                      switch(section.type) {
                        case 'List':
                          return SectionList(section);
                        case 'Staggered':
                          return SectionStaggered(section: section);
                        default:
                          return Container();
                      }
                    }).toList();
                    return SliverList(
                      delegate: SliverChildListDelegate(children),
                    );
                  },
                )
            ],
          ),
        ],
      ),
    );
  }
}
