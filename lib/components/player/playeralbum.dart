import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:minimalmusic/services/audioservice.dart';
import 'package:provider/provider.dart';

class PlayerAlbum extends StatefulWidget {
  const PlayerAlbum({Key? key}) : super(key: key);

  @override
  State<PlayerAlbum> createState() => _PlayerAlbumState();
}

class _PlayerAlbumState extends State<PlayerAlbum> {
  double screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width;

  ImageProvider getAlbumImage(AudioService audioService) {
    return audioService.audioFile == null
        ? const AssetImage('assets/images/albumplaceholder.png')
        : Image.memory(audioService.audioFile!.albumArt).image;
  }

  @override
  Widget build(BuildContext context) {
    var audioService = Provider.of<AudioService>(context);

    var trackTitle = 'Please select a Track';
    var albumTitle = 'Please select a Track';
    if (audioService.audioFile != null) {
      trackTitle = audioService.audioFile!.trackName;
      albumTitle = audioService.audioFile!.albumName;
    }

    ImageProvider albumImage = getAlbumImage(audioService);

    return Column(
      children: [
        Container(
          width: screenWidth - 60,
          height: screenWidth - 60,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(image: albumImage),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: screenWidth - 120,
          height: 32,
          child: trackTitle.length > 15
              ? Marquee(
                  text: trackTitle,
                  style: Theme.of(context).textTheme.headline5,
                  blankSpace: 50,
                  velocity: 30,
                  fadingEdgeStartFraction: .1,
                  fadingEdgeEndFraction: .1,
                  pauseAfterRound: const Duration(milliseconds: 500),
                )
              : Align(
                  alignment: Alignment.center,
                  child: Text(
                    trackTitle,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
        ),
        SizedBox(
          width: screenWidth - 200,
          height: 20,
          child: albumTitle.length > 20
              ? Marquee(
                  text: albumTitle,
                  style: Theme.of(context).textTheme.headline6,
                  blankSpace: 50,
                  velocity: 30,
                  fadingEdgeStartFraction: .1,
                  fadingEdgeEndFraction: .1,
                  pauseAfterRound: const Duration(milliseconds: 500),
                )
              : Align(
                  alignment: Alignment.center,
                  child: Text(
                    albumTitle,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
        ),
      ],
    );
  }
}
