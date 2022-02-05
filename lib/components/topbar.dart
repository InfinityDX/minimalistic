import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minimalmusic/services/appanimation.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin {
  double screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 750),
  );

  late final Animation<double> _widthAnimation = Tween<double>(
    begin: screenWidth,
    end: 50,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        .5,
        1,
        curve: Curves.fastOutSlowIn,
      ),
    ),
  )..addListener(() {
      setState(() {});
    });

  late final Animation<double> _opacityAnimation = Tween<double>(
    begin: 1,
    end: 0,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0,
        .45,
        curve: Curves.fastOutSlowIn,
      ),
    ),
  )..addListener(() {
      setState(() {});
    });

  late final Animation<double> _borderRadiusAnimation = Tween<double>(
    begin: 15,
    end: 40,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        .5,
        1,
        curve: Curves.fastOutSlowIn,
      ),
    ),
  )..addListener(() {
      setState(() {});
    });

  late final Animation<double> _paddingAnimation = Tween<double>(
    begin: 20,
    end: 5,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        .5,
        1,
        curve: Curves.fastOutSlowIn,
      ),
    ),
  )..addListener(() {
      setState(() {});
    });

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appAnimation = Provider.of<AppAnimation>(context);
    var screenWidth = MediaQuery.of(context).size.width;

    if (appAnimation.isTopBarShown) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(9, 10, 9, 0),
      child: Container(
        constraints: BoxConstraints(minWidth: 0, maxWidth: screenWidth),
        height: 50,
        width: _widthAnimation.value,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              offset: const Offset(2.5, 2.5),
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.circular(_borderRadiusAnimation.value),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _paddingAnimation.value),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: const Text(
                    'Minimal Music',
                    softWrap: false,
                    style: TextStyle(
                      fontFamily: 'SplineSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: TextButton(
                    onPressed: () {},
                    child: const Icon(Icons.search),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
