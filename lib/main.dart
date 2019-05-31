import 'package:flutter/material.dart';
import 'widget/tab_bar_widget.dart';
import 'demo/TabBarPageFirst.dart';
import 'demo/TabBarPageSecond.dart';
import 'demo/TabBarPageThree.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<String> tab = ["首页","动态","我的"];

  //渲染底部
  _renderTab(){
    List<Widget> list = new List();
    for(int i = 0; i< tab.length;i++){
      list.add(
        Tab(
          child: Text(tab[i]),
        )
      );
    }
    return list;
  }

  //渲染Tab  对应页面
  _renderPage(){
    return [
      new TabBarPageFirst(),
      new TabBarPageSecond(),
      new TabBarPageThree()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return TabBarWidget(
      type: TabBarWidget.BOTTOM_TAB,
      tabItems: _renderTab(),
      tabViews: _renderPage(),
      backgroundColor: Colors.black45,
      indicatorColor: Colors.white,
      title: Text("GithubFlutter"),
    );
  }
}
