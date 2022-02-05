import 'package:flutter/material.dart';
import 'package:minimalmusic/models/audiofile.dart';
import 'package:minimalmusic/screens/home/contents/trackslist.dart';
import 'package:minimalmusic/services/fileservice.dart';
import 'package:provider/provider.dart';

class Tracks extends StatefulWidget {
  const Tracks({Key? key}) : super(key: key);

  @override
  State<Tracks> createState() => _TracksState();
}

class _TracksState extends State<Tracks> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    var fileService = Provider.of<FileService>(context);
    return FutureBuilder<List<AudioFile>>(
      future: fileService.getFiles(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          if (data.isEmpty) {
            return const Center(
              child: Text('No Music Found :('),
            );
          }
          return TracksList(audioFiles: data);
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error Loading Data'));
        } else {
          return const Center(child: Text('Loading Data'));
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
