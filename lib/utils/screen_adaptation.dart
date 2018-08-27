import 'dart:ui';

enum ScreenAdaptationType {
  byWidth,
  byHeight,
}

class ScreenAdaptation {
  static final double screenWidth =
      window.physicalSize.width / window.devicePixelRatio;
  static final double screenHeight =
      window.physicalSize.height / window.devicePixelRatio;

  static double designWidth = screenWidth;

  static double designHeight = screenHeight;

  static ScreenAdaptationType screenAdaptationType =
      ScreenAdaptationType.byWidth;
}

dp(value) {
  if (ScreenAdaptation.screenAdaptationType == ScreenAdaptationType.byWidth) {
    return value / ScreenAdaptation.designWidth * ScreenAdaptation.screenWidth;
  } else {
    return value /
        ScreenAdaptation.designHeight *
        ScreenAdaptation.screenHeight;
  }
}

/// 以iPhone7Plus作为适配尺寸 逻辑尺寸为(宽414，高736)
dpx(value) {
  return value / ScreenAdaptation.screenWidth * 414;
}

vw(value) {
  return ScreenAdaptation.screenWidth * value / 100;
}

vh(value) {
  return ScreenAdaptation.screenHeight * value / 100;
}
