import 'package:flutter/widgets.dart';

class PageManager {
  final PageController pageController;
  PageManager({this.pageController});

  int page = 0;
  void setPage(int newPage) {
    if (page == newPage) return;
    page = newPage;
    pageController.jumpToPage(page);
  }
}