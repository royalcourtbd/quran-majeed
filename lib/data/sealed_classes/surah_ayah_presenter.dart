import 'package:quran_majeed/presentation/audio/audio_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/memorization/presenter/memorization_presenter.dart';

sealed class SurahAyahPresenter {
  const SurahAyahPresenter();

  factory SurahAyahPresenter.ayah(AyahPresenter presenter) = AyahSurahAyahPresenter;
  factory SurahAyahPresenter.audio(AudioPresenter presenter) = AudioSurahAyahPresenter;
  factory SurahAyahPresenter.memorization(MemorizationPresenter presenter) = MemorizationSurahAyahPresenter;
}

class AyahSurahAyahPresenter extends SurahAyahPresenter {
  final AyahPresenter presenter;
  const AyahSurahAyahPresenter(this.presenter);
}

class AudioSurahAyahPresenter extends SurahAyahPresenter {
  final AudioPresenter presenter;
  const AudioSurahAyahPresenter(this.presenter);
}

class MemorizationSurahAyahPresenter extends SurahAyahPresenter {
  final MemorizationPresenter presenter;
  const MemorizationSurahAyahPresenter(this.presenter);
}