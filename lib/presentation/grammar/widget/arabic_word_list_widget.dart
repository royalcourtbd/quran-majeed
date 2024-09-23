import 'package:flutter/material.dart';
import 'package:quran_majeed/presentation/grammar/widget/build_expansion_tile.dart';

class ArabicWordListWidget extends StatelessWidget {
  final ThemeData theme;

  final bool Function(ScrollNotification)? onNotification;
  const ArabicWordListWidget(
      {super.key,
      required this.onNotification,
      required this.theme});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: onNotification,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) => BuildExpansionTile(
            index: index,
            theme: theme,
          ),
        ),
      ),
    );
  }
}
