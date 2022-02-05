import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:minimalmusic/services/audioservice.dart';

class PlayerButtons extends StatefulWidget {
  const PlayerButtons({required this.audioService, Key? key}) : super(key: key);
  final AudioService audioService;

  @override
  State<PlayerButtons> createState() => _PlayerButtonsState();
}

class _PlayerButtonsState extends State<PlayerButtons>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  bool isPlaying = false;
  bool isShuffled = false;
  int loops = 0;

  void _handleOnLoops() {
    setState(() {
      loops = loops >= 2 ? 0 : loops += 1;
    });
  }

  Widget _shuffledIcons() {
    return isShuffled
        ? const Icon(Icons.shuffle_on_rounded)
        : const Icon(Icons.shuffle_outlined);
  }

  Widget _loopIcons() {
    if (loops == 0) return const Icon(Icons.loop);
    if (loops == 1) return const Icon(Icons.looks_one);
    if (loops == 2) return const Icon(Icons.looks_two);
    return const Icon(Icons.remove_red_eye);
  }

  void _handleOnSuffled() {
    setState(() {
      isShuffled = !isShuffled;
    });
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
          break;
        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Shuffle
        SizedBox(
          height: 40,
          width: 40,
          child: TextButton(
            onPressed: _handleOnSuffled,
            child: _shuffledIcons(),
          ),
        ),

        // Previous
        SizedBox(
          height: 40,
          width: 40,
          child: TextButton(
            onPressed: () => widget.audioService.playPrev(),
            child: const Icon(Icons.skip_previous_rounded),
          ),
        ),

        // Play | Pause
        SizedBox(
          height: 60,
          width: 60,
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
              size: 48,
              progress: _animationController,
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ),

        // Next
        SizedBox(
          height: 40,
          width: 40,
          child: TextButton(
            onPressed: () => widget.audioService.playNext(),
            child: const Icon(Icons.skip_next_rounded),
          ),
        ),

        // Loop
        SizedBox(
          height: 40,
          width: 40,
          child: TextButton(
            onPressed: _handleOnLoops,
            child: _loopIcons(),
          ),
        ),
      ],
    );
  }
}
