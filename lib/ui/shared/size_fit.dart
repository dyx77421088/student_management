import 'dart:ui';

class DYXSizeFit {
  static double physicalWidth;
  static double physicalHeight;
  static double dpr;
  static double screenWidth;
  static double screenHeight;
  static double statusHeight;

  static double rpx;
  static double px;

  static void initialize({standardSize=750}) {
    // 1. 手机物理分辨率
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;

    // 2. 获得dpr
    dpr = window.devicePixelRatio;

    // 3. 宽度和高度
    screenWidth = physicalWidth / dpr;
    screenHeight = physicalHeight / dpr;

    // 4. 状态栏的高度
    statusHeight = window.padding.top / dpr;

    // 5. 计算rpx的大小
    rpx = screenWidth / standardSize;
    px = screenWidth / standardSize * 2;
  }

  static double setRpx(double size) {
    return rpx * size;
  }
  /// 获得最大高度
  static double maxHeight() {
    return screenHeight;
  }
  /// 获得最大宽度
  static double maxWidth() {
    return screenWidth;
  }

  static double setPx(double size) {
    return px * size;
  }
}