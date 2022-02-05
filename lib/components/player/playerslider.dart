import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayerSlider extends StatefulWidget {
  const PlayerSlider({required this.audioPlayer, Key? key}) : super(key: key);
  final AudioPlayer audioPlayer;
  @override
  _PlayerSliderState createState() => _PlayerSliderState();
}

class _PlayerSliderState extends State<PlayerSlider>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 200,
    ),
  );

  late final _trackHeightAnimation = Tween<double>(
    begin: 2,
    end: 20,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ),
  )..addListener(() {
      setState(() {});
    });

  late final _thumSizeAnimation = Tween<double>(
    begin: 10,
    end: 0,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ),
  )..addListener(() {
      setState(() {});
    });

  var _duration = const Duration();
  var _position = const Duration();
  bool isSeeking = false;

  @override
  void initState() {
    super.initState();

    widget.audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    widget.audioPlayer.onAudioPositionChanged.listen((p) {
      if (!isSeeking) {
        setState(() {
          _position = p;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double val = 0;

  @override
  Widget build(BuildContext context) {
    Color sliderColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;

    return Theme(
      data: ThemeData(
        sliderTheme: SliderThemeData(
          inactiveTrackColor: Colors.grey,
          activeTrackColor: sliderColor,
          thumbColor: sliderColor,
          thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: _thumSizeAnimation.value,
          ),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
          trackHeight: _trackHeightAnimation.value,
        ),
      ),
      child: Column(
        children: [
          Slider(
            value: _position.inMilliseconds.toDouble(),
            onChangeStart: (value) {
              _animationController.forward();
              setState(() {
                isSeeking = true;
              });
            },
            onChanged: (val) {
              setState(() {
                _position = Duration(milliseconds: val.toInt());
              });
            },
            onChangeEnd: (val) {
              _animationController.reverse();
              setState(() {
                widget.audioPlayer.seek(_position);
                isSeeking = false;
              });
            },
            max: _duration.inMilliseconds.toDouble(),
            min: 0,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${_position.inMinutes}:' +
                  '${_position.inSeconds % 60}'.padLeft(2, '0')),
              Text('${_duration.inMinutes}:' +
                  '${_duration.inSeconds % 60}'.padLeft(2, '0')),
            ],
          ),
        ],
      ),
    );
  }
}
