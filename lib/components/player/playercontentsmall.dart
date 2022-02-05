import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:marquee/marquee.dart';
import 'package:minimalmusic/services/appanimation.dart';
import 'package:minimalmusic/services/audioservice.dart';
import 'package:minimalmusic/widgets/betterlisttile.dart';
import 'package:provider/provider.dart';

class PlayerContentSmall extends StatefulWidget {
  const PlayerContentSmall({required this.audioService, Key? key})
      : super(key: key);
  final AudioService audioService;

  @override
  _PlayerContentSmallState createState() => _PlayerContentSmallState();
}

class _PlayerContentSmallState extends State<PlayerContentSmall>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 350,
    ),
  );

  ImageProvider getAlbumImage(AudioService audioService) {
    return audioService.audioFile == null
        ? const AssetImage('assets/images/albumplaceholder.png')
        : Image.memory(audioService.audioFile!.albumArt).image;
  }

  @override
  void initState() {
    super.initState();
    widget.audioService.player.onPlayerStateChanged.listen((state) {
      switch (state) {
        case PlayerState.PLAYING:
          _animationController.forward();
          break;
        case PlayerState.PAUSED:
          _animationController.reverse();
          break;
        case PlayerState.COMPLETED:
          _animationController.reverse();
          widget.audioService.playNext();
          break;
        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
    widget.audioService.player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appAnimation = Provider.of<AppAnimation>(context);

    var trackTitle = 'Please select a Track';
    var albumTitle = 'Please select a Track';
    ImageProvider albumImage = getAlbumImage(widget.audioService);

    if (widget.audioService.audioFile != null) {
      trackTitle = widget.audioService.audioFile!.trackName;
      albumTitle = widget.audioService.audioFile!.albumName;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: BetterListTile(
        height: 50,
        borderRadius: BorderRadius.circular(15),
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            image: DecorationImage(
              image: albumImage,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SizedBox(
            width: 150,
            height: 18,
            child: trackTitle.length > 15
                ? Marquee(
                    text: trackTitle,
                    style: const TextStyle(
                      fontFamily: 'SplineSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    blankSpace: 25,
                    velocity: 30,
                    fadingEdgeStartFraction: .1,
                    fadingEdgeEndFraction: .1,
                    pauseAfterRound: const Duration(milliseconds: 500),
                  )
                : Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      trackTitle,
                      style: const TextStyle(
                        fontFamily: 'SplineSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SizedBox(
            width: 100,
            height: 15,
            child: albumTitle.length > 15
                ? Marquee(
                    text: albumTitle,
                    style: const TextStyle(
                      fontFamily: 'SplineSans',
                      fontSize: 11,
                    ),
                    blankSpace: 25,
                    velocity: 30,
                    fadingEdgeStartFraction: .1,
                    fadingEdgeEndFraction: .1,
                    pauseAfterRound: const Duration(milliseconds: 500),
                  )
                : Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      albumTitle,
                      style: const TextStyle(
                        fontFamily: 'SplineSans',
                        fontSize: 11,
                      ),
                    ),
                  ),
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: TextButton(
                  onPressed: () => widget.audioService.playPrev(),
                  child: const Icon(Icons.skip_previous_rounded),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
                height: 30,
                child: TextButton(
                  onPressed: () {
                    switch (widget.audioService.player.state) {
                      case PlayerState.PLAYING:
                        widget.audioService.player.pause();
                        break;
                      case PlayerState.PAUSED:
                        widget.audioService.player.resume();
                        break;
                      case PlayerState.COMPLETED:
                        widget.audioService.player.resume();
                        break;
                      default:
                        break;
                    }
                  },
                  child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: _animationController,
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
                height: 30,
                child: TextButton(
                  onPressed: () => widget.audioService.playNext(),
                  child: const Icon(Icons.skip_next_rounded),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
                height: 30,
                child: TextButton(
                  onPressed: () {
                    appAnimation.hidePlayer();
                    widget.audioService.player.stop();
                  },
                  child: const Icon(Entypo.chevron_down),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
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
