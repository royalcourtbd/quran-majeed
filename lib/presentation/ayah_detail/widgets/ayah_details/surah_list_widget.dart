import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/data/service/cache_data.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/build_expanded_column.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/surah_list_item.dart';
import 'package:quran_majeed/presentation/common/text_field/user_input_field.dart';

class SurahListColumn extends StatelessWidget {
  const SurahListColumn({
    super.key,
    this.onSurahSelected,
    required this.theme,
    required this.selectedSurahIndex,
  });

  final void Function(int surahId)? onSurahSelected;
  final ThemeData theme;
  final int selectedSurahIndex;

  @override
  Widget build(BuildContext context) {
    return BuildExpandedColumn(
      flex: 2,
      searchTextField: UserInputField(
        borderRadius: radius6,
        // textEditingController: presenter.surahNameSearchController,
        textEditingController: TextEditingController(),
        hintText: 'Surah Name',
        inputFormatters: [
          LengthLimitingTextInputFormatter(15),
        ],
      ),
      itemCount: CacheData.surahsCache.length,
      itemBuilder: (context, index) {
        return SurahListItem(
          surah: CacheData.surahsCache[index],
          theme: theme,
          index: index,
          onSelect: () => onSurahSelected!(index),
          selectedSurahIndex: selectedSurahIndex,
        );
      },
    );
  }
}
