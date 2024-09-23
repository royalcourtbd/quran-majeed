import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';

class AudioPlayerService {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static final StreamController<Duration> _durationStreamController =
      StreamController<Duration>();
  static final StreamController<PlayerState> _playerStateStreamController =
      StreamController<PlayerState>();
  static final StreamController<int?> _currentIndexStreamController =
      StreamController<int?>();
  static final StreamController<Duration> _positionStreamController =
      StreamController<Duration>();

  static AudioPlayer get instance => _audioPlayer;

  static Stream<Duration> get durationStream =>
      _durationStreamController.stream;
  static Stream<PlayerState> get playerStateStream =>
      _playerStateStreamController.stream;
  static Stream<int?> get currentIndexStream =>
      _currentIndexStreamController.stream;
  static Stream<Duration> get positionStream =>
      _positionStreamController.stream;

  AudioPlayerService._();

  static bool get playing => _audioPlayer.playing;

  static Future<void> enqueueAudioToPlaylist({
    required String audioPath,
    required String title,
    String? albumTitle,
    String? artwork,
  }) async {
    final MediaItem mediaItem = MediaItem(
      id: audioPath,
      title: title,
      album: albumTitle ?? 'Quran Majeed',
      artUri: artwork != null ? Uri.parse(artwork) : null,
    );

    final AudioSource source =
        ProgressiveAudioSource(Uri.file(audioPath), tag: mediaItem);

    final ConcatenatingAudioSource currentPlaylist =
        _audioPlayer.audioSource as ConcatenatingAudioSource;
    final List<AudioSource> currentChildren = currentPlaylist.children;
    currentChildren.add(source);

    await _audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: currentChildren));
  }

  static Future<void> clearPlaylist() async {
    try {
      final ConcatenatingAudioSource emptyPlaylist =
          ConcatenatingAudioSource(children: []);
      await _audioPlayer.setAudioSource(emptyPlaylist);
    } catch (e) {
      logErrorStatic('Error in clearPlaylist: $e', 'AudioPlayerService');
      rethrow;
    }
  }

  static Future<void> startPlaylistPlayback() async {
    try {
      await _audioPlayer.play();
    } catch (e) {
      logErrorStatic('Error in playPlaylist: $e', 'AudioPlayerService');
      rethrow;
    }
  }

  // Method to create a new playlist
  static Future<void> setPlaylist(ConcatenatingAudioSource playlist) async {
    try {
      await _audioPlayer.setAudioSource(playlist);
    } catch (e) {
      logErrorStatic('Error in setPlaylist: $e', 'AudioPlayerService');
      rethrow;
    }
  }

  static Future<void> pausePlayback() async {
    try {
      return await _audioPlayer.pause();
    } on PlayerException catch (e) {
      logErrorStatic('Error in pause: $e', 'AudioPlayerService');
      rethrow;
    }
  }

  static Future<void> resumePlayback() async {
    try {
      return await _audioPlayer.play();
    } on PlayerException catch (e) {
      logErrorStatic('Error in resumePlayback: $e', 'AudioPlayerService');
      rethrow;
    }
  }

  static Future<void> stopPlayback() async {
    try {
      if (_audioPlayer.playing) {
        await _audioPlayer.stop();
        _durationStreamController.add(Duration.zero);
        _playerStateStreamController.add(PlayerState(
          false,
          ProcessingState.idle,
        ));
        _currentIndexStreamController.add(null);
        _positionStreamController.add(Duration.zero);
      }
    } on PlayerException catch (e) {
      logErrorStatic('Error in stopPlayback: $e', 'AudioPlayerService');
      rethrow;
    }
  }

  static Future<void> seekAudioPosition(Duration position) async {
    try {
      return await _audioPlayer.seek(position);
    } on PlayerException catch (e) {
      logErrorStatic('Error in seek: $e', 'AudioPlayerService');
      rethrow;
    }
  }

  static Future<void> playSpecificVerse(VerseTiming verseTiming) async {
    await _audioPlayer.seek(Duration(milliseconds: verseTiming.time));
    await _audioPlayer.play();
    await Future.delayed(Duration(milliseconds: verseTiming.time));
    await _audioPlayer.pause();
  }

  static Future<void> playVerseAfterDelay(
      VerseTiming verseTiming, Duration delay) async {
    await playSpecificVerse(verseTiming);
    await Future.delayed(delay);
  }
}
