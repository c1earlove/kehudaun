import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// 日志标签常量：统一管理项目日志标签，便于筛选
class LogTags {
  static const String NETWORK = "NETWORK"; // 网络相关日志
  static const String USER = "USER"; // 用户相关日志
  static const String UI = "UI"; // 界面相关日志
  static const String PLUGIN = "PLUGIN"; // 插件相关日志
  static const String DB = "DB"; // 数据库相关日志
  static const String OTHER = "OTHER"; // 其他通用日志
}

/// 日志工具类：封装分级打印、格式化打印等功能，仅Debug模式启用
class LogUtil {
  /// 是否启用日志：Debug模式自动启用，Release模式自动禁用
  static const bool _isEnable = kDebugMode;

  /// 信息级别日志（Info）：打印普通调试信息
  /// [message] 日志内容
  /// [tag] 日志标签，默认使用 Tags.OTHER
  static void info(String message, {String tag = LogTags.OTHER}) {
    if (!_isEnable) return;
    developer.log(
      message,
      name: tag,
      level: 0, // 0 = Info级别
    );
  }

  /// 警告级别日志（Warn）：打印潜在问题提示信息
  /// [message] 日志内容
  /// [tag] 日志标签，默认使用 Tags.OTHER
  static void warn(String message, {String tag = LogTags.OTHER}) {
    if (!_isEnable) return;
    developer.log(
      message,
      name: tag,
      level: 8, // 8 = Warn级别
    );
  }

  /// 错误级别日志（Error）：打印异常/报错信息
  /// [message] 日志内容
  /// [tag] 日志标签，默认使用 Tags.OTHER
  /// [error] 错误详情对象
  /// [stackTrace] 调用栈信息，便于定位问题
  static void error(
    String message, {
    String tag = LogTags.OTHER,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (!_isEnable) return;
    developer.log(
      message,
      name: tag,
      level: 16, // 16 = Error级别
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// 致命错误级别日志（Fatal）：打印程序崩溃/核心功能异常信息
  /// [message] 日志内容
  /// [tag] 日志标签，默认使用 Tags.OTHER
  /// [error] 错误详情对象
  /// [stackTrace] 调用栈信息，便于定位问题
  static void fatal(
    String message, {
    String tag = LogTags.OTHER,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (!_isEnable) return;
    developer.log(
      message,
      name: tag,
      level: 24, // 24 = Fatal级别
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// 格式化打印JSON数据：带缩进，提升可读性
  /// [jsonData] JSON对象（Map/List等）
  /// [tag] 日志标签，默认使用 Tags.OTHER
  /// [message] 附加说明信息
  static void json(
    dynamic jsonData, {
    String tag = LogTags.OTHER,
    String message = "JSON数据：",
  }) {
    if (!_isEnable) return;
    try {
      // 格式化JSON，带2个空格缩进
      String formattedJson = JsonEncoder.withIndent('  ').convert(jsonData);
      info("$message\n$formattedJson", tag: tag);
    } catch (e, stack) {
      // JSON格式化失败时，打印错误信息
      error("JSON格式化失败：${e.toString()}", tag: tag, error: e, stackTrace: stack);
    }
  }

  /// 打印超长字符串：自动分段，避免截断（基于debugPrint）
  /// [message] 超长日志内容
  /// [tag] 日志标签，默认使用 Tags.OTHER
  /// [wrapWidth] 每行最大字符数，默认80
  static void longText(
    String message, {
    String tag = LogTags.OTHER,
    int wrapWidth = 80,
  }) {
    if (!_isEnable) return;
    // 拼接标签后分段打印
    String content = "[$tag] $message";
    debugPrint(content, wrapWidth: wrapWidth);
  }
}
