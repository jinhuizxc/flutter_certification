
/*
 * 主页
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_certification/base/Constant.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/*
 * 首页加载WebView;
 */
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _webUrl = Constant.testIp56 + "index.html";
//  String _webUrl = 'https://www.baidu.com/';  // 加载百度可以显示
  // flutter_webview_plugin 无法加载网页的异常处理
//  String _webUrl = 'https://www.jianshu.com/p/fa59d4357260'; // 可以显示

  final flutterWebviewPlugin = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;

  @override
  void initState() {
    super.initState();
    print('homeUrl: ' + _webUrl);
    _webUrl = Uri.decodeComponent(_webUrl);

    // 监听事件
    flutterWebviewPlugin.close();
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {});
    _onStateChanged = flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {

    });
    _onHttpError = flutterWebviewPlugin.onHttpError.listen((WebViewHttpError error) {
      print(error);
    });

    // Listen for scroll event in webview
    flutterWebviewPlugin.onScrollYChanged.listen((double offsetY) { // latest offset value in vertical scroll
      // compare vertical scroll changes here with old value
      print(offsetY);
    });

    flutterWebviewPlugin.onScrollXChanged.listen((double offsetX) { // latest offset value in horizontal scroll
      // compare horizontal scroll changes here with old value
      print(offsetX);
    });


  }

  @override
  void dispose() {
    _onStateChanged.cancel();
    _onUrlChanged.cancel();
    _onHttpError.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('首页'),
      ),
      body: WebviewScaffold(
        url: _webUrl,
        withJavascript: true,
        withZoom: false,
        withLocalStorage: true,
        hidden: true,
        initialChild: Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
