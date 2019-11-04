
/*
 * 主页
 */
import 'package:flutter/material.dart';
import 'package:flutter_certification/base/Constant.dart';

/*
 * 首页内嵌webview
 */
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

//  var webview_url = Constant.testIp56;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("主页"),
    );
  }
}
