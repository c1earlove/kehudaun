import 'dart:math';
import 'package:flutter/material.dart';

class ColorUtils {
  /// 从十六进制字符串创建 Color
  /// 支持格式：
  /// - "#FF5733" (带 #，6 位)
  /// - "FF5733"  (无 #，6 位)
  /// - "#F53"    (带 #，3 位)
  /// - "F53"     (无 #，3 位)
  /// - "#88FF5733" (带 #，8 位，含透明度)
  /// - "88FF5733"  (无 #，8 位)
  ///
  /// 如果解析失败，返回 [fallbackColor]（默认为 Colors.grey）
  static Color fromHex(String hexString, {Color fallbackColor = Colors.grey}) {
    try {
      // 移除 #
      String hex = hexString.replaceAll('#', '');

      // 处理 3 位简写 -> 6 位
      if (hex.length == 3) {
        hex = '${hex[0]}${hex[0]}${hex[1]}${hex[1]}${hex[2]}${hex[2]}';
      } else if (hex.length == 4) {
        // 4 位：带透明度的简写（如 #F53A → FF5533AA）
        hex =
            '${hex[0]}${hex[0]}${hex[1]}${hex[1]}${hex[2]}${hex[2]}${hex[3]}${hex[3]}';
      }

      // 补全透明度（默认不透明）
      if (hex.length == 6) {
        hex = 'FF$hex';
      } else if (hex.length != 8) {
        throw FormatException('Invalid length');
      }

      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      return fallbackColor;
    }
  }

  /// 从 ARGB 整数值创建 Color（如 0xFFFF5733）
  static Color fromArgb(int argb) => Color(argb);

  /// 设置颜色透明度（alpha）
/// [opacity] 范围：0.0（完全透明） ~ 1.0（完全不透明）
static Color withOpacity(Color color, double opacity) {
  // 将 0.0~1.0 映射到 0~255，并四舍五入取整
  final alpha = (opacity.clamp(0.0, 1.0) * 255).round();
  return color.withAlpha(alpha);
}

  /// 设置颜色透明度（alpha 值 0~255）
  static Color withAlpha(Color color, int alpha) {
    return Color.fromARGB(
      alpha.clamp(0, 255),
      color.red,
      color.green,
      color.blue,
    );
  }

  /// 生成随机颜色
  /// [includeOpacity]：是否包含随机透明度（默认 false，即不透明）
  static Color random({bool includeOpacity = false}) {
    final Random random = Random();
    final int r = random.nextInt(256);
    final int g = random.nextInt(256);
    final int b = random.nextInt(256);
    final int a = includeOpacity ? random.nextInt(256) : 255;
    return Color.fromARGB(a, r, g, b);
  }

  /// 生成随机但明亮的颜色（避免太暗）
  static Color randomBright() {
    final Random random = Random();
    // 确保至少两个通道 > 100，避免黑色系
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);
    if (r < 100 && g < 100) r = 150 + random.nextInt(105);
    if (g < 100 && b < 100) g = 150 + random.nextInt(105);
    if (b < 100 && r < 100) b = 150 + random.nextInt(105);
    return Color.fromARGB(255, r, g, b);
  }

  /// 创建线性渐变（常用场景封装）
  /// [colors]：颜色列表（支持字符串或 Color）
  /// [stops]：可选，渐变位置（0.0 ~ 1.0）
  static LinearGradient linearGradient({
    required List<dynamic> colors,
    List<double>? stops,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    final List<Color> parsedColors = colors.map((color) {
      if (color is String) {
        return fromHex(color);
      } else if (color is Color) {
        return color;
      } else {
        throw ArgumentError('Color must be String or Color');
      }
    }).toList();

    return LinearGradient(
      colors: parsedColors,
      stops: stops,
      begin: begin,
      end: end,
    );
  }

  /// 检查颜色是否为“亮色”（用于文字对比）
  static bool isLightColor(Color color) {
    final brightness =
        (color.red * 299 + color.green * 587 + color.blue * 114) / 1000;
    return brightness > 128; // 0~255，>128 为亮色
  }

  /// 根据背景色自动选择前景色（白 or 黑）
  static Color getContrastColor(Color backgroundColor) {
    return isLightColor(backgroundColor) ? Colors.black : Colors.white;
  }
}
