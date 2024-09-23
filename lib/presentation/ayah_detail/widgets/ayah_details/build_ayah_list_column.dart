import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/ayah_details/ayah_number_list_widget.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/build_expanded_column.dart';
import 'package:quran_majeed/presentation/common/text_field/user_input_field.dart';

class BuildAyahListColumn extends StatelessWidget {
  const BuildAyahListColumn({
    super.key,
    this.onAyahSelected,
    required this.theme,
    required this.ayahNumbers,
    required this.selectedAyahIndex,
  });

  final void Function(int ayahID)? onAyahSelected;
  final int ayahNumbers;
  final int selectedAyahIndex;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return BuildExpandedColumn(
      flex: 1,
      searchTextField: UserInputField(
        // textEditingController: presenter.ayahNumberSearchController,
        textEditingController: TextEditingController(),
        borderRadius: radius6,
        hintText: 'Ayah',
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
      ),
      itemCount: ayahNumbers,
      itemBuilder: (context, index) {
        return AyahNumberListItem(
          index: index,
          theme: theme,
          selectedAyahIndex: selectedAyahIndex,
          onSelect: () => onAyahSelected!(index),
        );
      },
    );
  }
}
