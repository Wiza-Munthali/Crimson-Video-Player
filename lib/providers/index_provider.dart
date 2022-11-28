import 'package:flutter/material.dart';

class IndexProvider with ChangeNotifier {
  int _index = 0;
  ScrollController _scrollController = ScrollController();

  int get index => _index;

  ScrollController get scrollController => _scrollController;

  void setIndex(value) {
    _index = value;
    notifyListeners();
  }
}
