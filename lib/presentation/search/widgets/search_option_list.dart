import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/presentation/search/presenter/search_presenter.dart';

class SearchOptionList extends StatelessWidget {
  const SearchOptionList({
    super.key,
    required this.theme,
    required this.presenter,
  });

  final ThemeData theme;
  final SearchPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: thirtyFivePx,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: searchInList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => presenter.updateSearchInGroupValue(index),
            child: Padding(
              padding: EdgeInsets.only(right: fifteenPx),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.scale(
                    scale: 0.8,
                    child: Radio<int>(
                      value: index,
                      groupValue: presenter.uiState.value.searchInGroupValue,
                      onChanged: (int? newValue) {
                        if (newValue != null) {
                          presenter.updateSearchInGroupValue(newValue);
                        }
                      },
                    ),
                  ),
                  gapW5,
                  Text(
                    searchInList[index],
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

final List<String> searchInList = [
  'Translation',
  'Tafsir',
  'Arabic Ayah',
];
