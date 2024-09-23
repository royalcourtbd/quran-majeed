import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class TafseerTab extends StatelessWidget {
  const TafseerTab({
    super.key,
    required this.index,
    required this.theme,
    required this.selectedItemsLength,
    required this.onClose,
    required this.tafseerName,
    required this.language,
    required this.activeTabIndex,
  });
  final int index;
  final int activeTabIndex;
  final int selectedItemsLength;
  final ThemeData theme;
  final Function(int) onClose;
  final String tafseerName;
  final String language;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = activeTabIndex == index;
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          gapW20,
          Expanded(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: const [0.0, 0.9, 2],
                  colors: [
                    isSelected
                        ? const Color.fromARGB(255, 154, 81, 18)
                        : context.color.subtitleColor,
                    context.color.primaryColor.withOpacity(0.5),
                    context.color.primaryColor.withOpacity(0),
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Text(
                '$language: $tafseerName',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: thirteenPx,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (isSelected && selectedItemsLength > 1)
            GestureDetector(
              onTap: () async => await onClose(index),
              child: SvgPicture.asset(
                SvgPath.icClose2,
                height: twentyPx,
                colorFilter: buildColorFilter(
                  const Color.fromARGB(255, 196, 185, 149),
                ),
              ),
            ),
          gapW10,
          Container(
            height: twentyPx,
            width: 1,
            color: theme.textTheme.bodyMedium!.color!.withOpacity(0.1),
          ),
        ],
      ),
    );
  }
}
