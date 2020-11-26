import 'package:flutter/material.dart';
import 'package:loja_virtual/models/section.dart';
import 'package:loja_virtual/screens/home/components/item_tile.dart';
import 'package:loja_virtual/screens/home/components/section_header.dart';

class SectionList extends StatelessWidget {

  final Section section;
  SectionList(this.section);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return ItemTile(section.items[index]);
              },
              itemCount: section.items.length,
              separatorBuilder: (_, __) => SizedBox(width: 12,),
            ),
          )
        ]
      ),
    );
  }
}
