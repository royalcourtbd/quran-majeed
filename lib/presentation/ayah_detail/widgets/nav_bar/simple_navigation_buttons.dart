import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/external_libs/animate_do/fades.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/audio/audio_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/nav_button_widget.dart';
import 'package:quran_majeed/presentation/download_page/download_page.dart';
import 'package:quran_majeed/presentation/tafseer/presenter/tafseer_presenter.dart';
import 'package:quran_majeed/presentation/translation/presenter/translation_presenter.dart';

class SimpleNavigationButtons extends StatelessWidget {
  SimpleNavigationButtons({
    super.key,
    required this.ayahPresenter,
    required this.audioPresenter,
    required this.theme,
    required this.bottomNavigationBarHeight,
    this.isTafseerPage = false,
  });

  final bool isTafseerPage;
  final ThemeData theme;
  final AyahPresenter ayahPresenter;
  final double bottomNavigationBarHeight;
  final AudioPresenter audioPresenter;
  late final TafseerPresenter _tafseerPresenter = locate<TafseerPresenter>();
  late final TranslationPresenter _translationPresenter =
      locate<TranslationPresenter>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bottomNavigationBarHeight,
      padding: EdgeInsets.symmetric(
        horizontal: twentyPx,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(twentyPx),
        ),
        color: theme.cardColor,
      ),
      child: FadeIn(
        child: Row(
          key: const Key('SimpleNavigationButtons'),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isTafseerPage)
              NavButtonWidget(
                onTap: () => navigateToDownloadPage(
                    context, context.l10n.tafseer, false, theme),
                iconSvgPath: SvgPath.icOpenBookOutline,
              ),
            if (!isTafseerPage)
              NavButtonWidget(
                onTap: () async {
                  showComingSoonMessage(context: context);
                  //TODO: Auto Scroll Functionality is not implemented
                  // ayahPresenter.toggleAutoScroll();
                  //  await _presenter.onClickSingleWord(context);
                },
                iconSvgPath: SvgPath.icVerticalScroller,
                iconColor: Colors.grey.withOpacity(0.3),
              ),
            if (!isTafseerPage)
              NavButtonWidget(
                onTap: () => navigateToDownloadPage(
                    context, context.l10n.translation, false, theme),
                iconSvgPath: SvgPath.icTranslation,
              ),
            if (!isTafseerPage)
              NavButtonWidget(
                onTap: () async =>
                    await audioPresenter.onClickAudioButton(context, true),
                iconSvgPath: SvgPath.icPlayOutline,
              ),
            if (isTafseerPage)
              NavButtonWidget(
                onTap: () {},
                iconSvgPath: SvgPath.icPlayOutline,
              ),
            if (isTafseerPage)
              NavButtonWidget(
                onTap: () =>
                    _tafseerPresenter.onClickNoteCreate(context, false),
                iconSvgPath: SvgPath.icCreateNote,
              ),
            if (!isTafseerPage)
              NavButtonWidget(
                onTap: () async {
                  showComingSoonMessage(context: context);
                  // ayahPresenter.onMusafModeTap(context);
                },
                iconSvgPath: SvgPath.icOpenBook,
                iconColor: Colors.grey.withOpacity(0.3),
              ),
            if (!isTafseerPage)
              NavButtonWidget(
                onTap: () async {
                  showComingSoonMessage(context: context);
                  // await ayahPresenter.onClickAdvanceCopy(context, theme);
                },
                iconColor: Colors.grey.withOpacity(0.3),
                iconSvgPath: SvgPath.icCopy,
              ),
            if (isTafseerPage)
              NavButtonWidget(
                onTap: () async =>
                    await _tafseerPresenter.onClickTafseerCopyButton(context),
                iconSvgPath: SvgPath.icCopy,
              ),
          ],
        ),
      ),
    );
  }

  void navigateToDownloadPage(
      BuildContext context, String title, bool isTafseer, ThemeData theme) {
    context.customNavigatorPush(
      context,
      DownloadPage(
        presenter: isTafseer ? _tafseerPresenter : _translationPresenter,
        title: title,
        isTafseer: isTafseer,
      ),
    );
  }
}
