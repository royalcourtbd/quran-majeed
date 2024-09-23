import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/on_tap_widget.dart';
import 'package:quran_majeed/presentation/on_boarding/model/language_model.dart';
import 'package:quran_majeed/presentation/on_boarding/presenter/on_boarding_presenter.dart';

class LanguageSelectionListItem extends StatelessWidget {
  const LanguageSelectionListItem({
    super.key,
    required OnBoardingPresenter presenter,
    required this.language,
    required this.index,
    required this.theme,
  }) : _presenter = presenter;

  final OnBoardingPresenter _presenter;
  final Languages language;
  final int index;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return OnTapWidget(
      theme: theme,
      borderRadius: BorderRadius.zero,
      onTap: () => _presenter.selectLanguage(index),
      child: Container(
        margin: EdgeInsets.only(
          left: eighteenPx,
          right: eighteenPx,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          splashColor: theme.cardColor.withOpacity(0.7),
          leading: Transform.scale(
            scale: 0.8,
            child: Radio(
              value: index,
              groupValue: _presenter.currentUiState.selectedLanguageIndex,
              onChanged: (value) => _presenter.selectLanguage(value!),
              fillColor:
                  _presenter.currentUiState.selectedLanguageIndex == index
                      ? WidgetStateProperty.all(context.color.primaryColor)
                      : WidgetStateProperty.all(
                          context.color.primaryColor.withOpacity(0.38)),
            ),
          ),
          title: Text(
            language.language!,
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
