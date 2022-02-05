import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

import 'package:minimalmusic/models/audiofile.dart';

class AudioService with ChangeNotifier {
  List<AudioFile> audioFiles = [];
  int currentAudioIndex = 0;
  AudioFile? audioFile;
  AudioPlayer player = AudioPlayer();

  void setFile(List<AudioFile> audioFiles, int index) {
    currentAudioIndex = index;
    this.audioFiles = audioFiles;
    audioFile = audioFiles[index];
  }

  void playNext() {
    currentAudioIndex =
        currentAudioIndex >= audioFiles.length - 1 ? 0 : currentAudioIndex + 1;
    audioFile = audioFiles[currentAudioIndex];
    player.play(audioFile == null ? '' : audioFile!.path, isLocal: true);
    notifyListeners();
  }

  void playPrev() {
    currentAudioIndex =
        currentAudioIndex <= 0 ? audioFiles.length - 1 : currentAudioIndex - 1;
    audioFile = audioFiles[currentAudioIndex];
    player.play(audioFile == null ? '' : audioFile!.path, isLocal: true);
    notifyListeners();
  }

  void play() {
    player.play(audioFile == null ? '' : audioFile!.path, isLocal: true);
    notifyListeners();
  }
}
