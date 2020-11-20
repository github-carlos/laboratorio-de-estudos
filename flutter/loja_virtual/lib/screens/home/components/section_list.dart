import 'package:flutter/material.dart';
import 'package:loja_virtual/models/section.dart';
import 'package:loja_virtual/screens/home/components/section_header.dart';

class SectionList extends StatelessWidget {

  final Section section;
  SectionList(this.section);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return AspectRatio(aspectRatio: 1,child: Image.network(section.items[index].image, fit: BoxFit.cover,),);
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
