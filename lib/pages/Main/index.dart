import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //定义数据 根据数据进行渲染4个导航
  //一般应用程序导航是固定的
  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/ic_public_home_normal.png", //正常图标
      "active_icon": "lib/assets/ic_public_home_active.png", //选中图标
      "text": "首页",
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png", //正常图标
      "active_icon": "lib/assets/ic_public_pro_active.png", //选中图标
      "text": "分类",
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png", //正常图标
      "active_icon": "lib/assets/ic_public_cart_active.png", //选中图标
      "text": "购物车",
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png", //正常图标
      "active_icon": "lib/assets/ic_public_my_active.png", //选中图标
      "text": "我的",
    },
  ];
  int _currentIndex = 0;

  //返回导航栏的四个分类
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (int index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]!, width: 30, height: 30),
        activeIcon: Image.asset(
          _tabList[index]["active_icon"]!,
          width: 30,
          height: 30,
        ),
        label: _tabList[index]["text"], //导航栏文字
      );
    });
  }

  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex, //显示当前选中的子页面
          children: _getChildren(), //放置几个组件
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true, //显示未选中的文字
        unselectedItemColor: Colors.black, //未选中文字颜色显示
        selectedItemColor: Colors.black, //选中文字颜色
        onTap: (int index) {
          _currentIndex = index;

          setState(() {});
        },
        currentIndex: _currentIndex,
        items: _getTabBarWidget(),
      ),
    );
  }
}
