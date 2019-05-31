import 'package:flutter/material.dart';

class TabBarPageFirst extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TabBarPageFirstState();
  }

}

class _TabBarPageFirstState extends State<TabBarPageFirst>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(5.0),
      itemExtent: 50.0,
      itemBuilder: (BuildContext context,int index){
        return Text("First $index");
      }
    );
  }

}