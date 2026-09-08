import 'package:flutter/material.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<BannerItem> _bannerList = [
    BannerItem(
      id: '1',
      imgUrl: 'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg',
    ),
    BannerItem(
      id: '2',
      imgUrl: 'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png',
    ),
    BannerItem(
      id: '3',
      imgUrl: 'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg',
    ),
  ];

  //获取滚动容器的内容
  List<Widget> _getScrollContent() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)), //轮播图组件
      SliverToBoxAdapter(child: SizedBox(height: 10)), //放置间距组件
      SliverToBoxAdapter(child: HmCategory()), //分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10)), //放置间距组件
      SliverToBoxAdapter(child: HmSuggestion()), //推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10)), //放置间距组件
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: HmHot()),
              SizedBox(width: 10),
              Expanded(child: HmHot()),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)), //放置间距组件
      HmMoreList(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollContent());
  }
}
