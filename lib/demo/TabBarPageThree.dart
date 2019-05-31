import 'package:flutter/material.dart';

class TabBarPageThree extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TabBarPageThreeState();
  }

}

class _TabBarPageThreeState extends State<TabBarPageThree>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(5.0),
        itemExtent: 50.0,
        itemBuilder: (BuildContext context,int index){
          return Text("Three $index");
        }
    );
  }

}