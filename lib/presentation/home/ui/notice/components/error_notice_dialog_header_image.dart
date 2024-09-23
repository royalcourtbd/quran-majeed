import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';

class ErrorNoticeDialogHeaderImage extends StatelessWidget {
  const ErrorNoticeDialogHeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: QuranScreen.width,
      height: 40.percentWidth,
      color: Theme.of(context).primaryColor.withAlpha(50),
      child: Image.asset(
        SvgPath.bgMosque,
        height: 30.percentWidth,
        width: QuranScreen.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
