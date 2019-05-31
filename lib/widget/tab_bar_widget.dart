import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget{
  //底部模式type
  static const int BOTTOM_TAB = 1;
  //顶部模式type
  static const int TOP_TAB = 2;
  final int type;
  final bool resizeToAvoidBottomPadding;
  final List<Widget> tabItems;
  final List<Widget> tabViews;
  final Color backgroundColor;
  final Color indicatorColor;
  final Widget title;
  final Widget drawer;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Widget bottomBar;
  final TarWidgetControl tarWidgetControl;
  final ValueChanged<int> onPageChanged;


  TabBarWidget({
    Key key,
    this.type,
    this.tabItems,
    this.tabViews,
    this.backgroundColor,
    this.indicatorColor,
    this.title,
    this.drawer,
    this.bottomBar,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.resizeToAvoidBottomPadding = true,
    this.tarWidgetControl,
    this.onPageChanged
  }) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _TabBarState(
        type,
        tabViews,
        indicatorColor,
        title,
        drawer,
        floatingActionButton,
        tarWidgetControl,
        onPageChanged
    );
  }
}

class _TabBarState extends State<TabBarWidget>
  with SingleTickerProviderStateMixin{
  final int _type;
  final List<Widget> _tabViews;
  final Color _indicatorColor;
  final Widget _title;
  final Widget _drawer;
  final Widget _floatingActionButton;
  final TarWidgetControl _tarWidgetControl;
  final PageController _pageController = PageController();
  final ValueChanged<int> _onPageChanged;


  _TabBarState(
      this._type,
      this._tabViews,
      this._indicatorColor,
      this._title,
      this._drawer,
      this._floatingActionButton,
      this._tarWidgetControl,
      this._onPageChanged) : super();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: widget.tabItems.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(this._type == TabBarWidget.TOP_TAB){
      //顶部tabBar
      return Scaffold(
        resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
        floatingActionButton: SafeArea(child: _floatingActionButton ?? Container()),
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        persistentFooterButtons: _tarWidgetControl == null ? null : _tarWidgetControl.footerButton,
        appBar: AppBar(
          backgroundColor: widget.backgroundColor,
          title: _title,
          bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: widget.tabItems,
            indicatorColor: _indicatorColor,
            onTap: (index){
              _onPageChanged?.call(index);
              _pageController.jumpTo(MediaQuery.of(context).size.width * index);
            },
          ),
        ),
        body: PageView(
          controller: _pageController,
          children: _tabViews,
          onPageChanged: (index){
            _tabController.animateTo(index);
            _onPageChanged?.call(index);
          },
        ),
        bottomNavigationBar: widget.bottomBar,
      );
    }
    //底部tabBar
    return Scaffold(
      drawer: _drawer,
      appBar: AppBar(
        backgroundColor: widget.backgroundColor,
        title: _title,
      ),
      body: PageView(
        controller: _pageController,
        children: _tabViews,
        onPageChanged: (index){
          _tabController.animateTo(index);
          _onPageChanged?.call(index);
        },
      ),
      bottomNavigationBar: Material(
        color: widget.backgroundColor,
        child: SafeArea(
            child: TabBar(
              controller: _tabController,
              tabs: widget.tabItems,
              indicatorColor: _indicatorColor,
              onTap: (index){
                _onPageChanged?.call(index);
                _pageController.jumpTo(MediaQuery.of(context).size.width * index);
              },
            )
        ),
      ),
    );
  }

}

class TarWidgetControl{
  List<Widget> footerButton = [];
}
