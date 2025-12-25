import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:window_size/window_size.dart';
import 'package:yt_client_flutter/home_page.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:yt_client_flutter/utils/desktop_screen_util.dart';

final screenUtil = DesktopScreenUtil(
  designHeight: 800,
  designWidth: 1440,
  minHeight: 600,
  minWidth: 800,
);

void main() {
  // 初始化 macOS WebView 引擎（必须优先执行）
  if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    WebViewPlatform.instance = WebKitWebViewPlatform();
  }
  // 🔴 必须在 runApp 之前！
  // WidgetsFlutterBinding.ensureInitialized();
  // setWindowTitle('XX银行客户端');
  // setWindowMinSize(const Size(800, 600));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '客户端',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        // 全局文本样式配置
        textTheme: const TextTheme(
          bodyLarge: TextStyle(decoration: TextDecoration.none),
          bodyMedium: TextStyle(decoration: TextDecoration.none),
          bodySmall: TextStyle(decoration: TextDecoration.none),
          titleLarge: TextStyle(decoration: TextDecoration.none),
          // 可根据自己使用的文本样式类型逐一配置
        ),
      ),
      home: Builder(
        builder: (context) {
          // 初始化屏幕适配工具
          screenUtil.init(context);
          return const HomePage();
        },
      ),
    );
  }
}
