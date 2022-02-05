import 'package:flutter/cupertino.dart';

class TestChangeNotifier with ChangeNotifier {
  double age = 0;

  void setAge(double age) {
    this.age = age;
    notifyListeners();
  }
}
