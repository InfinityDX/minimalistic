import 'package:flutter/material.dart';
import 'package:minimalmusic/components/player/playerbuttons.dart';
import 'package:minimalmusic/components/player/playerslider.dart';
import 'package:minimalmusic/services/audioservice.dart';
import 'package:provider/provider.dart';

class PlayerMusicNav extends StatelessWidget {
  PlayerMusicNav({Key? key}) : super(key: key);
  final double screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width;

  @override
  Widget build(BuildContext context) {
    var audioService = Provider.of<AudioService>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          PlayerSlider(audioPlayer: audioService.player),
          const SizedBox(height: 20),
          PlayerButtons(audioService: audioService),
        ],
      ),
    );
  }
}
