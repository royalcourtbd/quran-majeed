import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';

class LoadingNoticeDialogHeaderImage extends StatelessWidget {
  const LoadingNoticeDialogHeaderImage({super.key, required this.progress});

  final double? progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: QuranScreen.width,
      height: 30.percentWidth,
      color: Theme.of(context).primaryColor.withAlpha(50),
      child: Center(
        child: CircularProgressIndicator(value: progress ?? 0),
      ),
    );
  }
}
