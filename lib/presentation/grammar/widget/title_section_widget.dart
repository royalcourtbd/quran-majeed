import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/arrow_button.dart';

class TitleSectionWidget extends StatelessWidget {
  final PageController pageController;
  const TitleSectionWidget({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: twentyPx),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ArrowButton(
            svgPath: SvgPath.icArrowLeft,
            onTap: () => pageController.nextPage(
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear,
            ),
            theme: theme,
          ),
          Text(
            '',
            style: theme.textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w700,
              color: context.color.primaryColor,
            ),
          ),
          ArrowButton(
            svgPath: SvgPath.icArrowRight,
            onTap: () => pageController.previousPage(
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear,
            ),
            theme: theme,
          ),
        ],
      ),
    );
  }
}
