import 'package:flutter/cupertino.dart';

class AppAnimation with ChangeNotifier {
  bool isTopBarShown = true;
  bool isBigPlayer = false;
  bool isPlayerOn = false;

  void hideTopBar() {
    isTopBarShown = false;
    notifyListeners();
  }

  void showTopBar() {
    isTopBarShown = true;
    notifyListeners();
  }

  void hidePlayer() {
    isPlayerOn = false;
    notifyListeners();
  }

  void showPlayer() {
    isPlayerOn = true;
    notifyListeners();
  }

  void shrinkPlayer() {
    isBigPlayer = false;
    notifyListeners();
  }

  void expandPlayer() {
    isBigPlayer = true;
    notifyListeners();
  }
}
