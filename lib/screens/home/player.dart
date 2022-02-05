import 'package:flutter/material.dart';
import 'package:minimalmusic/components/player/playerbackground.dart';
import 'package:minimalmusic/components/player/playercontent.dart';
import 'package:minimalmusic/components/player/playercontentsmall.dart';
import 'package:minimalmusic/services/appanimation.dart';
import 'package:minimalmusic/services/appstatus.dart';
import 'package:minimalmusic/services/audioservice.dart';
import 'package:provider/provider.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> with TickerProviderStateMixin {
  double screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width;
  double screenHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;

  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );

  late final _slideController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );

  // Player Expanding

  late final _playerOpacity = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.6,
        1,
        curve: Curves.fastOutSlowIn,
      ),
    ),
  )..addListener(() {
      setState(() {});
    });

  late final _playerSmallOpacity = Tween<double>(
    begin: 1,
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

  // Player Shifting
  late final _shiftToTop = Tween<double>(
    begin: 70,
    end: 0,
  ).animate(
    CurvedAnimation(
      parent: _slideController,
      curve: const Interval(
        0.6,
        1,
        curve: Curves.fastOutSlowIn,
      ),
    ),
  )..addListener(() {
      setState(() {});
    });

  @override
  void dispose() {
    _slideController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appAnimation = Provider.of<AppAnimation>(context);
    var audioService = Provider.of<AudioService>(context);

    appAnimation.isBigPlayer
        ? _animationController.forward()
        : _animationController.reverse();

    appAnimation.isPlayerOn
        ? _slideController.forward()
        : _slideController.reverse();

    return GestureDetector(
      onTap: appAnimation.isBigPlayer ? null : appAnimation.expandPlayer,
      child: Transform.translate(
        offset: Offset(0, _shiftToTop.value),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            const PlayerBackground(),
            Opacity(
              opacity: _playerOpacity.value,
              child: IgnorePointer(
                ignoring: !appAnimation.isBigPlayer,
                child: const PlayerContent(),
              ),
            ),
            Positioned(
              width: screenWidth,
              bottom: 10,
              child: Opacity(
                opacity: _playerSmallOpacity.value,
                child: IgnorePointer(
                  ignoring: appAnimation.isBigPlayer,
                  child: PlayerContentSmall(audioService: audioService),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
