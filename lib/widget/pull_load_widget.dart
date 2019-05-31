import 'package:flutter/material.dart';

class PullLoadWidget extends StatefulWidget{

  //item渲染
  final IndexedWidgetBuilder itemWidget;
  //加载更多回调
  final RefreshCallback onLoadMore;
  //下拉刷新回调
  final RefreshCallback onRefresh;
  //控制器 数据 配置等
  final PullLoadWidgetControl control;

  final Key refreshKey;

  PullLoadWidget(
      this.itemWidget,
      this.onLoadMore,
      this.onRefresh,
      this.control,
      {this.refreshKey});

  @override
  State<StatefulWidget> createState() {
    return _PullLoadWidgetState(this.itemWidget,this.onLoadMore,this.onRefresh,this.refreshKey);
  }

}

class _PullLoadWidgetState extends State<PullLoadWidget>{

  final IndexedWidgetBuilder itemBuilder;
  final RefreshCallback onLoadMore;
  final RefreshCallback onRefresh;
  final Key refreshKey;
  PullLoadWidgetControl control;

  _PullLoadWidgetState(
      this.itemBuilder,
      this.onLoadMore,
      this.onRefresh,
      this.refreshKey);

  final ScrollController _scrollController = new ScrollController();


  @override
  void initState() {
    //延迟两秒
    this.control.needLoadMore?.addListener((){
      try {
        Future.delayed(Duration(seconds: 2),(){
          // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
          _scrollController.notifyListeners();
        });
      } catch (e) {
        print(e);
      }
    });
    //滑动监听
    _scrollController.addListener((){
      //判断当前滑动位置是不是到达底部，触发加载更多回调
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        if(this.control.needLoadMore.value){
          this.onLoadMore?.call();
        }
      }
    });
    super.initState();
  }

  //根据配置状态返回事迹列表的数量
  _getListCount(){
    //是否需要头部
    if(control.needHeader){
      return (control.dataList.length > 0)? control.dataList.length + 2 : control.dataList.length + 1;
    }else{
      //如果不需要头部，在没有数据时，固定返回数量1用于空页面呈现
      if(control.dataList.length == 0){
        return 1;
      }
    }
    //如果有数据,因为部加载更多选项，需要对列表数据总数+1
    return (control.dataList.length > 0) ? control.dataList.length + 1 : control.dataList.length;
  }

  //根据配置状态返回实际列表渲染Item
  _getItem(int index){

  }


  @override
  Widget build(BuildContext context) {
    return null;
  }


  //空白页面
  Widget _buildEmpty(){
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: (){},
            child: Image(
                image: null
            ),
          )
        ],
      ),
    );
  }
}



class PullLoadWidgetControl{
  //数据
  List dataList = new List();
  //是否需要加载更多
  ValueNotifier<bool> needLoadMore = new ValueNotifier(false);
  //是否需要头部
  bool needHeader = false;
}