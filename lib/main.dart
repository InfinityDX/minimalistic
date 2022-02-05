import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minimalmusic/screens/wrapper.dart';
import 'package:minimalmusic/services/appanimation.dart';
import 'package:minimalmusic/services/appstatus.dart';
import 'package:minimalmusic/services/audioservice.dart';
import 'package:minimalmusic/services/fileservice.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        splashColor: Colors.grey,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        shadowColor: Colors.grey[300],
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        )),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.grey[400],
          labelColor: Colors.black,
          indicator: const BoxDecoration(),
        ),
        textTheme: const TextTheme(
          headline5: TextStyle(
            fontSize: 22,
            fontFamily: 'SplineSans',
          ),
          headline6: TextStyle(
            fontSize: 14,
            fontFamily: 'SplineSans',
          ),
        ),
      ),
      darkTheme: ThemeData(
        splashColor: Colors.grey,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[850],
        shadowColor: Colors.grey[900],
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        )),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.grey[800],
          labelColor: Colors.white,
          indicator: const BoxDecoration(),
        ),
        textTheme: const TextTheme(
          headline5: TextStyle(
            fontSize: 22,
            fontFamily: 'SplineSans',
          ),
          headline6: TextStyle(
            fontSize: 14,
            fontFamily: 'SplineSans',
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppStatus()),
          ChangeNotifierProvider(create: (context) => AppAnimation()),
          ChangeNotifierProvider(create: (context) => FileService()),
          ChangeNotifierProvider(create: (context) => AudioService()),
        ],
        child: const Wrapper(),
      ),
    );
  }
}
