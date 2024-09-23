import 'package:flutter/material.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/font_family.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/translation/presenter/translation_presenter.dart';
import 'package:quran_majeed/presentation/translation/presenter/translation_ui_state.dart';

class TranslationTextWidget extends StatelessWidget {
  TranslationTextWidget({
    super.key,
    required this.surahID,
    required this.ayahNumber,
    required this.localFontSize,
    required this.theme,
  });

  final int surahID;
  final int ayahNumber;
  final double localFontSize;
  final ThemeData theme;
  final TranslationPresenter translationPresenter =
      locate<TranslationPresenter>();

  @override
  Widget build(BuildContext context) {
    return PresentableWidgetBuilder(
      presenter: translationPresenter,
      builder: () {
        final TranslationUiState uiState = translationPresenter.currentUiState;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: uiState.selectedItems.length,
          itemBuilder: (context, index) {
            final item = uiState.selectedItems[index];
            String translationText = translationPresenter.getTranslationText(
                item.fileName, surahID, ayahNumber);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (uiState.selectedItems.length != 1)
                  Text(
                    item.name,
                    style: theme.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.color.primaryColor.withOpacity(0.5),
                    ),
                  ),
                gapH3,
                Text(
                  translationText,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: localFontSize,
                    color: context.color.subtitleColor,
                    fontFamily: FontFamily.kalpurush,
                  ),
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                ),
                gapH22,
              ],
            );
          },
        );
      },
    );
  }
}
