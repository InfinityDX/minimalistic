import 'package:flutter/material.dart';
import 'package:minimalmusic/screens/home/home.dart';
import 'package:minimalmusic/screens/welcome/welcome.dart';
import 'package:minimalmusic/services/appstatus.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appStatus = Provider.of<AppStatus>(context);

    return appStatus.seenOnBoardScreen ? const Home() : const Welcome();
  }
}
