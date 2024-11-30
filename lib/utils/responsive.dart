import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  final double _screenWidth;
  final double _screenHeight;

  Responsive(this.context)
      : _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;

  // Responsive height
  double height(double percentage) {
    return _screenHeight * percentage / 100;
  }

  // Responsive width
  double width(double percentage) {
    return _screenWidth * percentage / 100;
  }

  // Responsive text size
  double textSize(double percentage) {
    return (_screenWidth < _screenHeight ? _screenWidth : _screenHeight) *
        percentage /
        100;
  }

  // Spacing or padding (based on width for consistency)
  double spacing(double percentage) {
    return _screenWidth * percentage / 100;
  }

  // Get screen width and height directly
  double get screenWidth => _screenWidth;
  double get screenHeight => _screenHeight;

  // Check device type based on width
  bool get isMobile => _screenWidth < 600;
  bool get isTablet => _screenWidth >= 600 && _screenWidth < 1200;
  bool get isDesktop => _screenWidth >= 1200;
}
