import 'package:flutter/material.dart';
import 'package:quran_majeed/core/utility/utility.dart';


class RoundedScaffoldBody extends StatelessWidget {
  const RoundedScaffoldBody({
    super.key,
    this.child,
    this.isColored = false,
  });
  final Widget? child;
  final bool isColored;


  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return ColoredBox(
      color: isDarkMode(context)
          ? themeData.cardColor
          : isColored
              ? themeData.colorScheme.secondary
              : themeData.primaryColor,
      child: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          // backgroundBlendMode: BlendMode.srcATop,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(isMobile ? twentyPx : tenPx),
          //   topRight: Radius.circular(isMobile ? twentyPx : tenPx),
          // ),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: ClipRRect(
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(twentyPx),
          //   topRight: Radius.circular(twentyPx),
          // ),
          child: child,
        ),
      ),
    );
  }
}
