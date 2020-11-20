import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/section.dart';

class HomeManager {
  HomeManager() {
    _loadSections();
  }

  List<Section> sections = [];

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> _loadSections() async {
    firebaseFirestore.collection('home').snapshots().listen((snapshot) {
      sections.clear();
      for (final DocumentSnapshot document in snapshot.docs) {
        sections.add(Section.fromDocument(document));
      }
      print(sections);
    });
  }
}
