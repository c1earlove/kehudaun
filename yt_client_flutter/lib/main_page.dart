import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late WebViewController _webController; // WebView 控制器
  bool _isLoading = true; // 加载状态标记

  @override
  void initState() {
    super.initState();
    // 初始化 WebView 控制器
    _initWebController();
  }

  /// 初始化 WebView 配置
  void _initWebController() {
    _webController = WebViewController()
      // 启用 JavaScript（多数网页依赖，必开）
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // 配置导航代理（监听加载状态、错误等）
      ..setNavigationDelegate(
        NavigationDelegate(
          // 开始加载网页回调
          onPageStarted: (String url) {
            debugPrint("开始加载：$url");
            setState(() {
              _isLoading = true;
            });
          },
          // 加载完成回调
          onPageFinished: (String url) {
            debugPrint("加载完成：$url");
            setState(() {
              _isLoading = false;
            });
          },
          // 加载错误回调
          onWebResourceError: (WebResourceError error) {
            debugPrint("加载失败：${error.description}，错误码：${error.errorCode}");
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      // 加载远程 URL
      ..loadRequest(
        Uri.parse('https://zxwxcs.hubeibank.cn:7081/sit1/ebank/#/login'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("XX银行网银登录"), centerTitle: true),
      body: Stack(
        children: [
          // WebView 组件（使用 WebViewWidget 包裹控制器）
          WebViewWidget(controller: _webController),
          // 加载指示器（加载中显示）
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 2,
              ),
            ),
        ],
      ),
      // 底部操作栏（回退、刷新、前进）
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 回退上一页
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                if (await _webController.canGoBack()) {
                  _webController.goBack();
                }
              },
              tooltip: "回退",
            ),
            // 刷新网页
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _webController.reload();
              },
              tooltip: "刷新",
            ),
            // 前进下一页
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () async {
                if (await _webController.canGoForward()) {
                  _webController.goForward();
                }
              },
              tooltip: "前进",
            ),
          ],
        ),
      ),
    );
  }
}
