import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;

  Responsive(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isDesktop => width >= 1024;

  double dynamicFont(double base) {
    if (isMobile) return base;
    if (isTablet) return base * 1.2;
    return base * 1.4;
  }

  double dynamicPadding(double base) {
    if (isMobile) return base;
    if (isTablet) return base * 1.3;
    return base * 1.6;
  }

  double dynamicRadius(double base) {
    double shortestSide = width < height ? width : height;
    return base * (shortestSide / 400);
  }
}
