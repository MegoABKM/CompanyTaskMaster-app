import 'package:flutter/material.dart';

class ScaleConfig {
  final double referenceWidth;
  final double referenceHeight;
  final double referenceDPI;
  final double screenWidth;
  final double screenHeight;
  final double scaleWidth;
  final double scaleHeight;
  final double textScaleFactor;
  final Orientation orientation;
  final double devicePixelRatio;

  ScaleConfig._({
    required this.referenceWidth,
    required this.referenceHeight,
    required this.referenceDPI,
    required this.screenWidth,
    required this.screenHeight,
    required this.scaleWidth,
    required this.scaleHeight,
    required this.textScaleFactor,
    required this.orientation,
    required this.devicePixelRatio,
  });

  factory ScaleConfig(
    BuildContext context, {
    double refWidth = 375,
    double refHeight = 812,
    double refDPI = 326,
  }) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final orientation = mediaQuery.orientation;
    final textScale = mediaQuery.textScaleFactor;
    final devicePixelRatio = mediaQuery.devicePixelRatio;

    return ScaleConfig._(
      referenceWidth: refWidth,
      referenceHeight: refHeight,
      referenceDPI: refDPI,
      screenWidth: width,
      screenHeight: height,
      scaleWidth: width / refWidth,
      scaleHeight: height / refHeight,
      textScaleFactor: textScale,
      orientation: orientation,
      devicePixelRatio: devicePixelRatio,
    );
  }

  double get scaleFactor {
    final baseScale = scaleWidth < scaleHeight ? scaleWidth : scaleHeight;
    final dpiRatio = devicePixelRatio / (referenceDPI / 160);
    final dpiScale =
        1.0 + (dpiRatio - 1.0) * 0.1; // Less aggressive DPI scaling
    final landscapeMultiplier =
        orientation == Orientation.landscape ? 1.1 : 1.0; // Reduced multiplier
    return baseScale * dpiScale * landscapeMultiplier;
  }

  double scale(double size) {
    return (size * scaleFactor).clamp(size * 0.8, size * 3.0);
  }

  double scaleText(double fontSize) {
    double adjustedTextScaleFactor =
        textScaleFactor.clamp(0.8, 1.2); // Limit textScaleFactor
    double scaledSize = fontSize * scaleFactor * adjustedTextScaleFactor;
    if (devicePixelRatio > 2.5) {
      scaledSize *= 0.9; // Slight reduction for high-DPI devices
    }
    return scaledSize.clamp(fontSize * 0.8, fontSize * 1.5); // Tighter clamp
  }

  bool get isTablet {
    final shortestSide =
        screenWidth < screenHeight ? screenWidth : screenHeight;
    final longestSide = screenWidth > screenHeight ? screenWidth : screenHeight;
    return shortestSide > 600 && longestSide > 900;
  }

  double tabletScale(double size) {
    final baseScaledSize = scale(size);
    if (isTablet) {
      return baseScaledSize * 1.1;
    }
    return baseScaledSize;
  }

  double tabletScaleText(double fontSize) {
    final baseScaledSize = scaleText(fontSize);
    if (isTablet) {
      return baseScaledSize * 1.1;
    }
    return baseScaledSize;
  }
}
