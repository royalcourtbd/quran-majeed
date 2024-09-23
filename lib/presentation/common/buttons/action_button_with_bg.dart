// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quran_majeed/core/config/quran_color.dart';
// import 'package:quran_majeed/core/config/quran_screen.dart';

// class ActionButtonWithBg extends StatelessWidget {
//   const ActionButtonWithBg({
//     super.key,
//     required this.buttonText,
//     this.isFocused = true,
//     required this.height,
//     required this.width,
//     required this.theme,
//     this.padding = const EdgeInsets.symmetric(
//       horizontal: 15,
//     ),
//     required this.onTap,
//   });

//   final String buttonText;
//   final bool isFocused;
//   final VoidCallback onTap;
//   final double height;
//   final double width;
//   final EdgeInsets padding;
//   final ThemeData theme;
  

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         alignment: Alignment.center,
//         padding: padding,
//         width: width,
//         height: height,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.px),
//           color: isFocused
//               ? theme.primaryColor
//               : theme.primaryColor.withOpacity(0.12),
//         ),
//         child: Text(
//           buttonText,
//           style: TextStyle(
//             fontSize: fourteenPx,
//             color: isFocused ? Colors.white : QuranColor.primaryColorLight,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
