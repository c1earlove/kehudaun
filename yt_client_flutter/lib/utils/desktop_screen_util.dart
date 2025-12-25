import 'package:flutter/material.dart';

class DesktopScreenUtil {
  // 设计稿基准尺寸（可自定义）
  final double designWidth;
  final double designHeight;

  // 最小允许的屏幕尺寸（防止窗口太小时 UI 崩溃）
  final double minWidth;
  final double minHeight;

  // 内部缓存当前有效尺寸（考虑最小值限制）
  late double _effectiveWidth;
  late double _effectiveHeight;

  // 构造函数
  DesktopScreenUtil({
    this.designWidth = 1920,
    this.designHeight = 1080,
    this.minWidth = 800,
    this.minHeight = 600,
  });

  /// 初始化：从 BuildContext 获取实际窗口尺寸并应用最小限制
  void init(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    _effectiveWidth = size.width < minWidth ? minWidth : size.width;
    _effectiveHeight = size.height < minHeight ? minHeight : size.height;
  }

  /// 手动设置尺寸（适用于无 context 场景，如测试或非 widget 环境）
  void setSize(double width, double height) {
    _effectiveWidth = width < minWidth ? minWidth : width;
    _effectiveHeight = height < minHeight ? minHeight : height;
  }

  // 获取当前有效宽度（受 minWidth 限制）
  double get screenWidth => _effectiveWidth;

  // 获取当前有效高度（受 minHeight 限制）
  double get screenHeight => _effectiveHeight;

  // 宽度适配：按设计稿比例缩放
  double wp(double px) {
    return px * (_effectiveWidth / designWidth);
  }

  // 高度适配
  double hp(double px) {
    return px * (_effectiveHeight / designHeight);
  }

  // 字体大小适配（通常用宽度比例）
  double sp(double px) {
    return px * (_effectiveWidth / designWidth);
  }

  // 是否当前窗口小于最小尺寸（可用于提示用户）
  bool get isBelowMinSize {
    final actual =
        WidgetsBinding.instance.window.physicalSize /
        WidgetsBinding.instance.window.devicePixelRatio;
    return actual.width < minWidth || actual.height < minHeight;
  }
}
