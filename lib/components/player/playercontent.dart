import 'package:flutter/material.dart';
import 'package:minimalmusic/components/player/playeralbum.dart';
import 'package:minimalmusic/components/player/playermusicnav.dart';
import 'package:minimalmusic/components/player/playernav.dart';

class PlayerContent extends StatefulWidget {
  const PlayerContent({Key? key}) : super(key: key);

  @override
  _PlayerContentState createState() => _PlayerContentState();
}

class _PlayerContentState extends State<PlayerContent> {
  double screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width;
  double screenHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 10,
          width: screenWidth,
          child: const PlayerNav(),
        ),
        Positioned(
          top: 50,
          width: screenWidth,
          child: const PlayerAlbum(),
        ),
        Positioned(
          bottom: 50,
          width: screenWidth,
          child: PlayerMusicNav(),
        ),
      ],
    );
  }
}
