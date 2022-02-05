import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minimalmusic/services/appanimation.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class PlayerBackground extends StatefulWidget {
  const PlayerBackground({Key? key}) : super(key: key);
  @override
  _PlayerBackgroundState createState() => _PlayerBackgroundState();
}

class _PlayerBackgroundState extends State<PlayerBackground>
    with SingleTickerProviderStateMixin {
  double screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width;
  double screenHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;

  Color albumColors = Colors.white;
  ImageProvider? imageProvider;
  PaletteGenerator? paletteGenerator;

  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );

  late final _expandTop = Tween<double>(
    begin: 50,
    end: screenHeight,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ),
  )..addListener(() {
      setState(() {});
    });

  late final _expandCorner = Tween<double>(
    begin: 15,
    end: 0,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ),
  )..addListener(() {
      setState(() {});
    });

  late final _expandBottom = Tween<double>(
    begin: 10,
    end: 0,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ),
  )..addListener(() {
      setState(() {});
    });

  late final _expandSides = Tween<double>(
    begin: 9,
    end: 0,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ),
  )..addListener(() {
      setState(() {});
    });

  void updateStatusBarColor(AppAnimation appAnimation) {
    appAnimation.isBigPlayer
        ? SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: albumColors,
              statusBarIconBrightness: Brightness.dark,
            ),
          )
        : SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
          );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appAnimation = Provider.of<AppAnimation>(context);
    updateStatusBarColor(appAnimation);

    appAnimation.isBigPlayer
        ? _animationController.forward()
        : _animationController.reverse();
    return Positioned(
      bottom: _expandBottom.value,
      width: screenWidth - _expandSides.value * 2,
      child: Container(
        width: screenWidth,
        height: _expandTop.value,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_expandCorner.value),
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: const Offset(2, 2),
                blurRadius: 5,
              )
            ]),
      ),
    );
  }
}
