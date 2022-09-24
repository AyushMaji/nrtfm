import 'dart:developer';

import 'package:just_audio/just_audio.dart';
import 'package:nrtfm/utils/barrel.dart';

class MusicPlayer extends ChangeNotifier {
  String musicId = "0";
  String musicUrl = "0";
  String poster = "0";
  String rating = "0";
  String views = "0";
  String tittle = "0";
  String description = "0";
  String totalRating = "0";
  bool isPlaying = false;
  bool isPaused = false;
  bool ismute = false;
  bool isRepeat = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  Duration bufferedPosition = Duration.zero;
  String processState = "loading";

  bool get getisPlaying => isPlaying;
  bool get getisPaused => isPaused;
  Duration get getposition => position;
  Duration get getduration => duration;
  Duration get getbufferedPosition => bufferedPosition;
  String get getprocessState => processState;
  String get getmusicId => musicId;
  String get getmusicUrl => musicUrl;
  String get getposter => poster;
  String get getrating => rating;
  String get getviews => views;
  String get gettittle => tittle;
  String get getdescription => description;
  String get gettotalRating => totalRating;
  bool get getismute => ismute;
  bool get getisRepeat => isRepeat;

  final player = AudioPlayer();
  void musicPlayer(
    String url,
    String musicId,
    String poster,
    String rating,
    String totalRating,
    String views,
    String tittle,
    String description,
  ) {
    try {
      player.setUrl(url);
      player.play();
      songposition();
      songState();
      isPlaying = true;
      isPaused = false;
      ismute = false;
      this.musicId = musicId;
      this.poster = poster;
      this.rating = rating;
      this.totalRating = totalRating;
      this.views = views;
      this.tittle = tittle;
      this.description = description;
      player.setVolume(1.0);
      notifyListeners();
    } on PlayerException catch (e) {
      log("Error code: ${e.code}");
      log("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      log("Connection aborted: ${e.message}");
    } catch (e) {
      log(e.toString());
    }
  }

  void stop() {
    player.stop();
    isPaused = true;
    notifyListeners();
  }

  void audiooff() {
    isPlaying = false;
    isPaused = false;
    player.stop();
    notifyListeners();
  }

  // void replay() {
  //   player.seek(Duration.zero);
  //   isPaused = false;
  //   notifyListeners();
  // }

  void play() {
    player.play();
    isPlaying = true;
    isPaused = false;
    notifyListeners();
  }

  void loopOn() {
    player.setLoopMode(LoopMode.one);
    isRepeat = false;
    notifyListeners();
  }

  void loopOff() {
    player.setLoopMode(LoopMode.off);
    isRepeat = true;
    notifyListeners();
  }

  void changeVolume(double value) {
    if (value == 0) {
      ismute = true;
      player.setVolume(value);
      notifyListeners();
    } else {
      ismute = false;
      player.setVolume(value);
      notifyListeners();
    }
  }

  void changeSideValue(Duration duration) {
    player.seek(duration);
  }

  void songposition() {
    player.positionStream.listen((positions) {
      position = positions;
      notifyListeners();
    });
    player.bufferedPositionStream.listen((bufferedPositions) {
      bufferedPosition = bufferedPositions;
      notifyListeners();
    });
    player.durationStream.listen((durations) {
      duration = durations!;
      notifyListeners();
    });
  }

  void songState() {
    player.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      var processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        processState = "Loading";
      } else if (!isPlaying) {
        processState = "stop";
      } else if (processingState != ProcessingState.completed) {
        processState = "done";
      } else {
        player.seek(Duration.zero);
        player.pause();
      }
    });
  }
}
