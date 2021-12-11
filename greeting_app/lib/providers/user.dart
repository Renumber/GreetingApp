import 'dart:core';

import 'package:flutter/material.dart';

class User with ChangeNotifier {
  int selectedIndex = 0;
  String category = "";

  User();

  void changeSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void changeIndexCategory(String category) {
    this.category = category;
    selectedIndex = 1;
    notifyListeners();
  }
}
