import 'package:flutter/material.dart';

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Create a new Path object
    final Path path = Path()
      // Move the starting point of the path to (0, size.height)
      ..lineTo(0, size.height)
      // Draw a line to (size.width, size.height)
      ..lineTo(size.width, size.height)
      // Draw a line to (size.width, 0)
      ..lineTo(size.width, 0)
      // Draw a line to (0, 0)
      ..lineTo(0, 0)
      // Close the path to form a closed shape
      ..close();

    // Define the width of the arrow
    const double arrowWidth = 8;
    // Calculate the starting x-coordinate of the arrow
    final double startPointX = (size.width - arrowWidth) / 2;
    // Calculate the starting y-coordinate of the arrow
    double startPointY = size.height / 2 - arrowWidth / 2;
    // Move to the starting point of the arrow
    path
      ..moveTo(startPointX, startPointY)
      // Draw a line to the top vertex of the arrow
      ..lineTo(startPointX + arrowWidth / 2, startPointY - arrowWidth / 2)
      // Draw a line to the right vertex of the arrow
      ..lineTo(startPointX + arrowWidth, startPointY)
      // Draw a line to the bottom vertex of the arrow
      ..lineTo(startPointX + arrowWidth, startPointY + 1.0)
      // Draw a line to the right bottom vertex of the arrow
      ..lineTo(
        startPointX + arrowWidth / 2,
        startPointY - arrowWidth / 2 + 1.0,
      )
      // Draw a line back to the starting point of the arrow
      ..lineTo(startPointX, startPointY + 1.0)
      // Close the path to complete the arrow shape
      ..close();

    // Update the starting y-coordinate for the second part of the arrow
    startPointY = size.height / 2 + arrowWidth / 2;
    // Move to the starting point of the second part of the arrow
    path
      ..moveTo(startPointX + arrowWidth, startPointY)
      // Draw a line to the top vertex of the second part of the arrow
      ..lineTo(startPointX + arrowWidth / 2, startPointY + arrowWidth / 2)
      // Draw a line to the left vertex of the second part of the arrow
      ..lineTo(startPointX, startPointY)
      // Draw a line to the top left vertex of the second part of the arrow
      ..lineTo(startPointX, startPointY - 1.0)
      // Draw a line to the left bottom vertex of the second part of the arrow
      ..lineTo(
        startPointX + arrowWidth / 2,
        startPointY + arrowWidth / 2 - 1.0,
      )
      // Draw a line back to the starting point of the second part of the arrow
      ..lineTo(startPointX + arrowWidth, startPointY - 1.0)
      // Close the path to complete the second part of the arrow shape
      ..close();

    // Return the final path representing the arrow shape
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
