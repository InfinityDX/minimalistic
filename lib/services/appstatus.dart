import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStatus with ChangeNotifier {
  bool seenOnBoardScreen = false;

  AppStatus() {
    sharedPreferencesInit();
  }

  void removeOnBoardScreen() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('seenOnBoardScreen', true);
    seenOnBoardScreen = true;
    notifyListeners();
  }

  void sharedPreferencesInit() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      seenOnBoardScreen = prefs.getBool('seenOnBoardScreen') ?? false;
      notifyListeners();
    } catch (e) {
      SharedPreferences.setMockInitialValues({'seenOnBoardScreen': false});
    }
  }
}
