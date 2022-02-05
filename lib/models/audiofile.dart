import 'dart:typed_data';

class AudioFile {
  Uint8List albumArt;
  String trackName;
  List<String> trackArtistNames;
  String albumName;
  String albumArtistName;
  int trackNumber;
  int albumLength;
  int year;
  String genre;
  String authorName;
  String writerName;
  int discNumber;
  String mimeType;
  int trackDuration;
  int bitrate;
  String path;

  AudioFile({
    required this.albumArt,
    required this.trackName,
    required this.trackArtistNames,
    required this.albumName,
    required this.albumArtistName,
    required this.trackNumber,
    required this.albumLength,
    required this.year,
    required this.genre,
    required this.authorName,
    required this.writerName,
    required this.discNumber,
    required this.mimeType,
    required this.trackDuration,
    required this.bitrate,
    required this.path,
  });
}
