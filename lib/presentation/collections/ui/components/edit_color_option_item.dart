import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/animate_do/slides.dart';

class EditColorOptionItem extends StatelessWidget {
  const EditColorOptionItem({
    super.key,
    required this.color,
    required this.isSelected,
  });

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: onSelected,
      child: Padding(
        padding: EdgeInsets.only(right: sevenPx),
        child: CircleAvatar(
          backgroundColor: color,
          radius: twentyPx,
          child: isSelected
              ? SlideInUp(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.check_circle,
                    size: sixteenPx,
                    color: Colors.white,
                    fill: 0,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
