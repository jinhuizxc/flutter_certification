import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_certification/base/Constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

/*
 * 原生webview,
 * 官方插件
 */
class FlutterWebView extends StatefulWidget {


  @override
  _FlutterWebViewState createState() => _FlutterWebViewState();
}

class _FlutterWebViewState extends State<FlutterWebView>
    with AutomaticKeepAliveClientMixin {

  //  String _webUrl = Constant.testIp56 + "index.html";
  String _webUrl = 'https://www.baidu.com/';  // 加载百度可以显示
  // flutter_webview_plugin 无法加载网页的异常处理
//  String _webUrl = 'https://www.jianshu.com/p/fa59d4357260'; // 可以显示

  bool _loading = true; //等待
  final Completer<WebViewController> _controller =
      new Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    _webUrl = Uri.decodeComponent(_webUrl);

    print("webUrl == $_webUrl");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // 必须实现
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        centerTitle: true,
      ),
      // 设置安全区域 ，不沉浸式
      body: SafeArea(
          top: true,
          child: Builder(builder: (BuildContext context) {
            return Stack(
              children: <Widget>[
                _showWebView(context),
                _loading
                    ? Center(child: CircularProgressIndicator())
                    : Container()
              ],
            );
          })),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  // 显示WebView
  Widget _showWebView(BuildContext context) {
    return WebView(
      initialUrl: _webUrl,

      // 初始化url
      javascriptMode: JavascriptMode.unrestricted,
      // JS执行模式
      onWebViewCreated: (WebViewController webViewController) {
        // 在WebView创建完成后调用，只会被调用一次
        _controller.complete(webViewController);
      },
      // javascript通道
      javascriptChannels: <JavascriptChannel>[
        ///JS和Flutter通信的Channel；
        _alertJavascriptChannel(context),
      ].toSet(),
      navigationDelegate: (NavigationRequest request) {
        //路由委托（可以通过在此处拦截url实现JS调用Flutter部分）；
        ///通过拦截url来实现js与flutter交互
        if (request.url.startsWith('js://webview')) {
          // Fluttertoast的使用
          Fluttertoast.showToast(
              msg: 'JS调用了Flutter By navigationDelegate',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          print('blocking navigation to $request}');
          return NavigationDecision.prevent;

          // 阻止路由替换，不能跳转，因为这是js交互给我们发送的消息
        }
        return NavigationDecision.navigate;
        // 允许路由替换
      },
      onPageFinished: (String url) {
        // 页面加载完成回调
        setState(() {
          _loading = false;
        });
        print('Page finished loading: $url');
      },
    );
  }

  // js与flutter交互
  _alertJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'invoke', // invoke要和前端协商一致
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
        });
  }
}
