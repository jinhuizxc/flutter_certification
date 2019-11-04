/*
 * 我的
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
 * 政务App 我的页面开发
 */
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '我的',
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            // 跟ReleativeLayout使用相同
            _my_top_layout(),
            _my_item('images/icon_my_pwd.png', '重置密码'),
            _my_item('images/icon_notification.png', '系统通知'),
            _my_item('images/icon_help.png', '帮助信息'),
            _my_item('images/icon_clear.png', '清除缓存'),
            _my_exitApp(),
          ],
        ),
      ),
    );
  }
}

// 顶部页面显示
Widget _my_top_layout() {
  return new Container(
    child: new Stack(
      children: <Widget>[
        // 设置背景
        Image.asset(
          'images/icon_my_top.png',
          fit: BoxFit.cover,
        ),
//        position_person(),
//        position_top(),
//        position_bottom_right(),
      Align(
        alignment: Alignment.bottomRight,
        child: new Row(
          children: <Widget>[
            Align(child: Image.asset('images/icon_person.png')),
            new Column(
              children: <Widget>[
                Text(
                  '用户名',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '15773003724',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )
          ],
        ),
      )
      ],
    ),
  );
}

Widget position_bottom_right() {
  return Positioned(
      right: 20,
      bottom: 10,
      child: Icon(
        Icons.access_alarm,
        size: 30,
        color: Colors.white,
      ));
}

Widget position_top() {
  return Positioned(
      right: 20,
      child: Icon(
        Icons.share,
        size: 30,
        color: Colors.white,
      ));
}

Widget position_person() {
  return Positioned(
    left: 15,
    child: new Row(
      children: <Widget>[
        Align(child: Image.asset('images/icon_person.png')),
        new Column(
          children: <Widget>[
            Text(
              '用户名',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              '15773003724',
              style: TextStyle(color: Colors.white),
            ),
          ],
        )
      ],
    ),
  );
}

Widget _my_exitApp() {
  return new Container(
    color: Colors.white,
    padding: EdgeInsets.all(20),
    child: Center(
      child: new Text(
        '退出登录',
        textAlign: TextAlign.center,
      ),
    ),
  );
}

/*
 * 显示列表项
 */
Widget _my_item(String name, String title) {
  return Container(
    padding: EdgeInsets.only(left: 5, top: 5),
    color: Colors.white,
    child: new Row(
      children: <Widget>[
        Image.asset(name),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: new Text(title),
        ),
      ],
    ),
  );
}
