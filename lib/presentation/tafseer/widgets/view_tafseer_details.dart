import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/presentable_widget_builder.dart';
import 'package:quran_majeed/core/static/font_family.dart';
import 'package:quran_majeed/domain/entities/setting_state_entity.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ui_state/ayah_ui_state.dart';
import 'package:quran_majeed/presentation/tafseer/widgets/copy_context_menu.dart';

class ViewTafseerDetails extends StatelessWidget {
  const ViewTafseerDetails({
    super.key,
    required this.theme,
    required this.surahID,
    required this.ayahID,
    required this.isLoading,
    required this.isTabChanged,
    required this.tafsirText,
    required this.ayahPresenter,
  });

  final ThemeData theme;
  final bool isLoading;
  final bool isTabChanged;
  final int surahID;
  final int ayahID;
  final String tafsirText;
  final AyahPresenter ayahPresenter;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const PageStorageKey<String>('tafseer_details'),
      child: Container(
        padding: EdgeInsets.only(left: twentyPx, right: twentyPx, top: tenPx, bottom: twentyPx),
        width: double.infinity,
        child: Column(
          key: const PageStorageKey<String>('tafseer_details'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              HtmlFormattedText(
                tafsirText: tafsirText,
                theme: theme,
                ayahPresenter: ayahPresenter,
              ),
          ],
        ),
      ),
    );
  }
}

class HtmlFormattedText extends StatelessWidget {
  const HtmlFormattedText({
    super.key,
    required this.tafsirText,
    required this.theme,
    required this.ayahPresenter,
  });

  final String tafsirText;
  final ThemeData theme;
  final AyahPresenter ayahPresenter;

  @override
  Widget build(BuildContext context) {
    return PresentableWidgetBuilder(
      presenter: ayahPresenter,
      builder: () {
        final AyahViewUiState ayahUiState = ayahPresenter.currentUiState;
        final double tafseerFontSize = ayahUiState.tafseerFontSize;
        final double arabicFontSize = ayahUiState.arabicFontSize;
        final ArabicFonts tafseerArabicFontFamily = ayahUiState.arabicFont;
        return SelectionArea(
          focusNode: FocusNode(),
          contextMenuBuilder: (context, selectableRegionState) {
            return CopyContextMenu(
              theme: theme,
              anchor: selectableRegionState.contextMenuAnchors.primaryAnchor,
              selectableRegionState: selectableRegionState,
            );
          },
          child: Html(
            data: tafsirText,
            shrinkWrap: true,
            extensions: [
              TagExtension(
                tagsToExtend: {"longer"},
                builder: (ExtensionContext extensionContext) {
                  return Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        extensionContext.element!.innerHtml.replaceAll('<br>', """
"""),
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: arabicFontSize,
                          fontFamily: tafseerArabicFontFamily.name,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
            style: {
              "body": Style(
                margin: Margins.zero,
                textAlign: TextAlign.left,
                padding: HtmlPaddings.zero,
                fontFamily: FontFamily.kalpurush,
                fontSize: FontSize(tafseerFontSize),
                lineHeight: const LineHeight(1.5),
                color: theme.textTheme.bodyMedium!.color,
              ),
              "span": Style(
                direction: TextDirection.rtl,
                lineHeight: const LineHeight(2),
                wordSpacing: 5,
                color: theme.textTheme.bodyMedium!.color,
                fontFamily: tafseerArabicFontFamily.name,
                fontSize: FontSize(arabicFontSize),
              ),
              "longer": Style(
                direction: TextDirection.rtl,
                lineHeight: const LineHeight(2),
                wordSpacing: 5,
                color: theme.textTheme.bodyMedium!.color,
              ),
            },
          ),
        );
      },
    );
  }
}
