import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class TrackProgressBar extends StatelessWidget {
  final double progress; // Progress value between 0.0 and 1.0
  final Function(double)? onTapSeek; // Add this callback
  final ThemeData theme;

  const TrackProgressBar({
    super.key,
    required this.progress,
    required this.theme,
    this.onTapSeek, // Make sure to require the onTapSeek callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        if (onTapSeek != null) {
          // Calculate tap position and seek percentage
          final RenderBox box = context.findRenderObject() as RenderBox;
          final Offset localOffset = box.globalToLocal(details.globalPosition);
          final double seekPercent = localOffset.dx / box.size.width;
          onTapSeek!(seekPercent);
        }
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: double.infinity,
            height: ninePx, // Assuming fourPx is a constant for 4.0
            decoration: BoxDecoration(
              color: context.color.primaryColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(
                  fiftyPx), // Assuming fiftyPx is a constant for 50.0
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: progress > 0.0
                ? MediaQuery.of(context).size.width * .9 * progress
                : MediaQuery.of(context).size.width * 0.1,
            height: ninePx, // Assuming sixPx is a constant for 6.0
            decoration: BoxDecoration(
              color: context.color.primaryColor,
              borderRadius: BorderRadius.circular(fiftyPx),
            ),
          ),
        ],
      ),
    );
  }
}
