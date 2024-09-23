import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomStatusBarColor extends StatelessWidget {
  final Widget child;
  final Color statusBarColor;
  final Brightness? statusBarIconColor;

  const CustomStatusBarColor({
    super.key,
    required this.child,
    required this.statusBarColor,
    this.statusBarIconColor,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness: statusBarIconColor,
    ));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconColor,
      ),
      child: child,
    );
  }
}
