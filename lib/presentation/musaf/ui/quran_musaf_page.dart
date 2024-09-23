import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/presentation/common/app_bar/appbar_action_icon.dart';
import 'package:quran_majeed/presentation/common/app_bar/build_custom_app_bar.dart';
import 'package:quran_majeed/presentation/settings/widgets/mini_settings/mini_settings_drawer.dart';

class QuranMusafPage extends StatefulWidget {
  const QuranMusafPage({super.key});

  @override
  State<QuranMusafPage> createState() => _QuranMusafPageState();
}

class _QuranMusafPageState extends State<QuranMusafPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isVisible = false;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: MiniSettingsDrawer(),
        body: Stack(
          children: [
            PageView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _toggleVisibility(),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: padding10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const ChapterDetailsRow(),
                              gapH10,
                              const MusafSurahNameSection(),
                              Text(
                                'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ ١ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَٰلَمِينَ ٢ٱلرَّحْمَٰنِ ٱلرَّحِيمِ ٣مَٰلِكِ يَوْمِ ٱلدِّينِ ٤إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ٥ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ ٦صِرَٰطَ ٱلَّذِينَ أَنْعَمْتَ عَوْمِ ٱلدِّينِ ٤إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ٥ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ ٦صِرَٰطَ ٱلَّذِينَ أَنْعَمْتَ عَوْمِ ٱلدِّينِ ٤إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ٥ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ ٦صِرَٰطَ ٱلَّذِينَ أَنْعَمْتَ عَوْمِ ٱلدِّينِ ٤إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ٥ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ ٦صِرَٰطَ ٱلَّذِينَ أَنْعَمْتَ عَوْمِ ٱلدِّينِ ٤إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ٥ٱهْدِنَا ٱلصِّرَٰطَ ٱلْ٤إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ٥ٱهْدِنَا ٱلصِّرَٰطَ ٱلْ٤إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ٥ٱهْدِنَا ٱلصِّرَٰطَ ٱلْ٤إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ٥ٱهْدِنَا ٱلصِّرَٰطَ ٱلْ٤إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ٥ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَصِّرَٰطَ ٱلْ٤إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ٥ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَصِّرَٰطَ ٱلْ٤إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ٥ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَصِّرَٰطَ ٱلْ٤إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ٥ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَصِّرَٰطَ ٱلْ٤إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ٥ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَصِّرَٰطَ ٱلْ٤إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ٥ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ ٦صِرَٰطَ ٱلَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ ٱلْمَغْضُوبِ عَلَيْهِمْ وَلَا ٱلضَّآلِّينَ ٧',
                                textAlign: TextAlign.justify,
                                // overflow: TextOverflow.ellipsis,
                                maxLines: 15,
                                style: context.quranText.arabicAyah!,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 20,
                                  width: 40,
                                  color: Colors.red,
                                  child: const Text(
                                    '1',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            _buildAppbar(context),
            Stack(
              children: [
                Positioned(
                  bottom: _isVisible ? 0 : -100,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 15.percentWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: twentyPx,
                      vertical: tenPx,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(twentyPx),
                      ),
                      color: theme.cardColor,
                    ),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text('Page - 01'),
                        ),
                        gapH5,
                        Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 4.0,
                              decoration: BoxDecoration(
                                color:
                                    context.color.primaryColor.withOpacity(.1),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 20,
                              height: 8.0,
                              decoration: BoxDecoration(
                                color: context.color.primaryColor,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Stack _buildAppbar(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: _isVisible ? 0 : -kToolbarHeight,
          left: 0,
          right: 0,
          child: BuildCustomAppBar(
            theme: Theme.of(context),
            title: 'Al Fatiha',
            dropDownPath: SvgPath.icArrowDown,
            onTap: () => locate<AyahPresenter>().onSurahListTap(
              context: context,
              isDoneButtonEnabled: true,
              isJumpToAyahBottomSheet: false,
              onAyahSelected: (ayahId) {},
              onSurahSelected: (surahId) {},
              onSubmit: () {},
              title: context.l10n.jumpToAyah,
            ),
            actions: [
              SvgPicture.asset(SvgPath.icMusafDark),
              GestureDetector(
                onTap: () => scaffoldKey.currentState!.openEndDrawer(),
                child: AppbarActionIcon(
                  svgPath: SvgPath.icSettings,
                  theme: Theme.of(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChapterDetailsRow extends StatelessWidget {
  const ChapterDetailsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Al Fatiha',
          style: theme.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.primaryColor,
          ),
        ),
        Text(
          'Page : 2  •  Juz : 1 ',
          style: theme.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.primaryColor,
          ),
        ),
      ],
    );
  }
}

class MusafSurahNameSection extends StatelessWidget {
  const MusafSurahNameSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(SvgPath.imgSurahName),
        Text(
          '001',
          style: context.quranText.surahName,
        )
      ],
    );
  }
}
