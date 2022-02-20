import 'package:flutter/material.dart';

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0.0, 55);
    path.relativeArcToPoint(const Offset(0, 40),
        radius: const Radius.circular(24.0), clockwise: true);
    path.lineTo(0.0, size.height - 10);
    path.quadraticBezierTo(0.0, size.height, 10.0, size.height);
    path.lineTo(size.width - 10.0, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 10);
    path.lineTo(size.width, 95);
    path.arcToPoint(Offset(size.width, 55),
        radius: const Radius.circular(24.0), clockwise: true);
    path.lineTo(size.width, 10.0);
    path.quadraticBezierTo(size.width, 0.0, size.width - 10.0, 0.0);
    path.lineTo(10.0, 0.0);
    path.quadraticBezierTo(0.0, 0.0, 0.0, 10.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}