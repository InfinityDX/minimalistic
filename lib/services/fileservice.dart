import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:minimalmusic/models/audiofile.dart';
import 'package:path/path.dart';

class FileService with ChangeNotifier {
  FileService() {
    Directory dir = Directory('/storage/emulated/0/Download');
    dir.watch(events: FileSystemEvent.all).listen((event) {
      notifyListeners();
    });
  }

  Future<List<AudioFile>> getFiles() async {
    Directory dir = Directory('/storage/emulated/0/Download');
    var fileList = dir.list(recursive: true).toList();
    List<AudioFile> audioFiles = [];

    //Default Album Image
    var imageByte = await rootBundle.load('assets/images/albumplaceholder.png');
    Uint8List defaultAlbumImage = imageByte.buffer.asUint8List();

    // Loop check if its an audio file
    for (var file in await fileList) {
      var fileExtension = extension(file.path);
      bool isM4A = fileExtension == '.m4a';
      bool isMP3 = fileExtension == '.mp3';

      if (isM4A || isMP3) {
        Metadata meta = await MetadataRetriever.fromFile(File(file.path));
        AudioFile audioFile = AudioFile(
          albumArt: meta.albumArt ?? defaultAlbumImage,
          trackName: meta.trackName ?? 'Track Name Unavailable',
          trackArtistNames: meta.trackArtistNames ?? ['Unavailable'],
          albumName: meta.albumName ?? 'Album Name Unavailable',
          albumArtistName:
              meta.albumArtistName ?? 'Album Artist Name Unavailable',
          trackNumber: meta.trackNumber ?? 0,
          albumLength: meta.albumLength ?? 0,
          year: meta.year ?? 0,
          genre: meta.genre ?? 'Genre Unavailable',
          authorName: meta.authorName ?? 'Author Unavailable',
          writerName: meta.writerName ?? 'Writer Unavailable',
          discNumber: meta.discNumber ?? 0,
          mimeType: meta.mimeType ?? 'Unavailable',
          trackDuration: meta.trackDuration ?? 0,
          bitrate: meta.bitrate ?? 0,
          path: file.path,
        );
        audioFiles.add(audioFile);
      }
    }
    audioFiles.sort((a, b) =>
        a.trackName.toLowerCase().compareTo(b.trackName.toLowerCase()));
    return audioFiles;
  }
}
