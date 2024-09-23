import 'package:flutter/material.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/custom_drawer_tile.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/drawer_title_widget.dart';

class MusafDrawerWidget extends StatelessWidget {
  const MusafDrawerWidget({super.key, required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         DrawerTitleWidget(title: "Musaf", theme: theme,),
        CustomDrawerTile(
            title: "Hafezi Quran", svgPath: SvgPath.icBookSave, onTap: () {}),
        CustomDrawerTile(
            title: "Nurani Quran", svgPath: SvgPath.icBookSave, onTap: () {})
      ],
    );
  }
}
