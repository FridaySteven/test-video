import 'package:flutter/widgets.dart';

class ResponsiveUtils {
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    blockSizeHorizontal = screenWidth / 390.0;
    blockSizeVertical = screenHeight / 844.0;
  }
}

extension ResponsiveExtension on num {
  double get rw => this * ResponsiveUtils.blockSizeHorizontal;
  double get rh => this * ResponsiveUtils.blockSizeVertical;
  double get rr => this * ResponsiveUtils.blockSizeHorizontal;
  double get rsp => this * ResponsiveUtils.blockSizeHorizontal;
}
