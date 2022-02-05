import 'package:flutter/material.dart';

import 'package:minimalmusic/models/audiofile.dart';
import 'package:minimalmusic/services/appanimation.dart';
import 'package:minimalmusic/services/audioservice.dart';
import 'package:minimalmusic/widgets/betterlisttile.dart';
import 'package:provider/provider.dart';

class TracksList extends StatelessWidget {
  final List<AudioFile> audioFiles;
  const TracksList({
    Key? key,
    required this.audioFiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var audioService = Provider.of<AudioService>(context);
    var appAnimation = Provider.of<AppAnimation>(context);

    return ListView.separated(
      itemCount: audioFiles.length + 2,
      separatorBuilder: (context, index) {
        if (index == 0) return const SizedBox(height: 0);
        return const SizedBox(height: 10);
      },
      itemBuilder: (context, index) {
        if (index == 0) {
          return const SizedBox(height: 75);
        }
        if (index == audioFiles.length + 1) {
          return const SizedBox(height: 65);
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BetterListTile(
            onTap: () {
              audioService.setFile(audioFiles, index - 1);
              audioService.play();
              appAnimation.showPlayer();
            },
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: const Offset(2, 2),
                blurRadius: 5,
              )
            ],
            borderRadius: BorderRadius.circular(15),
            leading: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                image: DecorationImage(
                  image: Image.memory(audioFiles[index - 1].albumArt).image,
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                audioFiles[index - 1].trackName,
                style: const TextStyle(
                  fontFamily: 'SplineSans',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                audioFiles[index - 1].albumName,
                style: const TextStyle(
                  fontFamily: 'SplineSans',
                  fontSize: 11,
                ),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                width: 30,
                height: 30,
                child: TextButton(
                  onPressed: () {},
                  child: const Icon(Icons.more_vert),
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
            ),
          ),
        );
      },
    );
  }
}
