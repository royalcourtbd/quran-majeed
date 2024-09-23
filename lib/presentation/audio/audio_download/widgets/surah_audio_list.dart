import 'package:flutter/material.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/presentation/audio/audio_download/widgets/surah_audio_list_item.dart';

class SurahAudioList extends StatelessWidget {
  final Reciter reciter;
  final ThemeData theme;

  const SurahAudioList({
    super.key,
    required this.reciter,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 114,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return SurahAudioListItem(
          index: index,
          reciter: reciter,
          theme: theme,
        );
      },
    );
  }
}
