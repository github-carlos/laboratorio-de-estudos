import 'package:flutter/material.dart';
import 'package:loja_virtual/models/section.dart';

class SectionHeader extends StatelessWidget {

  final Section section;
  SectionHeader(this.section);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(section.name, style: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white
      ),),
    );
  }
}
