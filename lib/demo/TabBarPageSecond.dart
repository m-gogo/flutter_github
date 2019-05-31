import 'package:flutter/material.dart';

class TabBarPageSecond extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TabBarPageSecondState();
  }

}

class _TabBarPageSecondState extends State<TabBarPageSecond>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(5.0),
        itemExtent: 50.0,
        itemBuilder: (BuildContext context,int index){
          return Text("Second $index");
        }
    );
  }

}