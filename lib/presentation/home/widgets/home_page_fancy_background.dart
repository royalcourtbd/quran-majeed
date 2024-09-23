import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class HomePageFancyBackgroundImage extends StatelessWidget {
  const HomePageFancyBackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    // used vector for improved rendering performance
    return SvgPicture.asset(
      SvgPath.imgBgHome,
      height: 53.percentHeight,
      width: 100.percentWidth,
      colorFilter: buildColorFilterToChangeColor(
          context.theme.bannerTheme.backgroundColor),
    );
  }
}

class StartPageFancyBackgroundColor extends StatelessWidget {
  const StartPageFancyBackgroundColor({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        height: 47.percentHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.42, 1.0],
            colors: [
              context.color.gdTop,
              context.color.gdMiddle,
              context.color.gdBottom,
            ],
          ),
        ),
      ),
    );
  }
}

class OvalBottomBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var controlPoint =
        Offset(size.width / 2, size.height + 40); // Adjust the curve
    var endPoint =
        Offset(size.width, size.height - 50); // Adjust the height of the curve

    // Start with a line from the top left
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 50);

    // Create a quadratic bezier curve for the bottom
    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );

    // Finish the path
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
