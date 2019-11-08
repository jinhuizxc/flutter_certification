import 'package:flutter/material.dart';
import 'package:flutter_certification/base/Constant.dart';
import 'package:flutter_certification/pages/home/flutter_webview.dart';
import 'package:flutter_certification/pages/home/home_page.dart';
import 'package:flutter_certification/pages/my/mypage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '政务App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: CertifyApp(),
    );
  }
}

class CertifyApp extends StatefulWidget {
  @override
  _CertifyAppState createState() => _CertifyAppState();
}

// 要让主页面 Index 支持动效，要在它的定义中附加mixin类型的对象TickerProviderStateMixin
class _CertifyAppState extends State<CertifyApp> with TickerProviderStateMixin{

  // 定义选中的下标
  int _selectedIndex = 0;
  List<StatefulWidget> _pageList;   // 用来存放我们的图标对应的页面
  StatefulWidget _currentPage;  // 当前的显示页面

  // 设置下标


  // 初始化导航图标
  @override
  void initState() {
    super.initState();

    // 将我们 bottomBar 上面的按钮图标对应的页面存放起来，方便我们在点击的时候
    _pageList = <StatefulWidget>[
//      new HomePage(),
      new FlutterWebView(),
      new MyPage()
    ];
    _currentPage = _pageList[_selectedIndex];

  }
  @override
  Widget build(BuildContext context) {

    // 声明定义一个 底部导航的工具栏
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      onTap: _onItemTap,
      currentIndex: _selectedIndex,
      selectedItemColor: /*Colors.amber[800]*/Colors.blue,
      // 设置底部导航工具栏的类型：fixed 固定
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('首页'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          title: Text('我的'),
        ),
      ],
    );

    return new Scaffold(
      body: new Center(
        child: _currentPage   // 动态的展示我们当前的页面,
      ),
      bottomNavigationBar: bottomNavigationBar,   // 底部工具栏
    );
  }

  /*
   * onTap点击事件
   */
  _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      _currentPage = _pageList[_selectedIndex];
    });
  }
}


