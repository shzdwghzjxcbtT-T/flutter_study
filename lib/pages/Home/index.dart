import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/utils/Toastutils.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //分类列表
  List<CategoryItem> _categoryList = [];
  List<BannerItem> _bannerList = [
    // BannerItem(
    //   id: '1',
    //   imgUrl: 'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg',
    // ),
    // BannerItem(
    //   id: '2',
    //   imgUrl: 'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png',
    // ),
    // BannerItem(
    //   id: '3',
    //   imgUrl: 'https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg',
    // ),
  ];

  //获取滚动容器的内容
  List<Widget> _getScrollContent() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)), //轮播图组件
      SliverToBoxAdapter(child: SizedBox(height: 10)), //放置间距组件
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)), //分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10)), //放置间距组件
      SliverToBoxAdapter(
        child: HmSuggestion(specialRecommendResult: _specialRecommendResult),
      ), //推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10)), //放置间距组件
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)), //放置间距组件
      HmMoreList(recommendList: _recommendList), // 无限滚动列表
    ];
  }

  //特惠推荐
  SpecialRecommendResult _specialRecommendResult = SpecialRecommendResult(
    id: '',
    title: '',
    subTypes: [],
  );
  // 热榜推荐
  SpecialRecommendResult _inVogueResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐
  SpecialRecommendResult _oneStopResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 推荐列表
  List<GoodDetailItem> _recommendList = [];

  //页码
  int _page = 1;
  bool _isLoading = false; //是否正在加载中
  bool _hasMore = true; //是否还有下一页

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _registerEvent();
    Future.microtask(() {
      _paddingTop = 100;
      setState(() {});
      _key.currentState?.show();
    });
  }

  //监听滚动到底部的事件
  Future<void> _registerEvent() async {
    _controller.addListener(() {
      // print("滚动了");
      //距离底部不足50px时触发 pixels是连续值 必须用>=不能用==精确匹配
      if (_controller.position.pixels >=
          (_controller.position.maxScrollExtent - 50)) {
        // print("到底了");
        _getRecommendList();
      }
    });
  }

  // 获取推荐列表
  Future<void> _getRecommendList() async {
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    int requestLimit = _page * 8;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoading = false;
    setState(() {});
    if (_recommendList.length < requestLimit) {
      _hasMore = false;
      return;
    }
    _page++;
  }

  // 获取热榜推荐列表
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
  }

  //获取特惠推荐列表
  Future<void> _getProductList() async {
    _specialRecommendResult = await getProductListAPI();
  }

  //获取轮播图列表
  Future<void> _getBannerList() async {
    _bannerList = await getBannerListAPI();
  }

  //获取分类列表
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
  }

  Future<void> _onRefresh() async {
    // print('下拉刷新');
    _page = 1;
    _isLoading = false;
    _hasMore = true;
    await _getBannerList();
    await _getCategoryList();
    await _getProductList();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();
    //数据获取成功。刷新成功
    Toastutils.showToast(context, "刷新成功");
    _paddingTop = 0;
    setState(() {});
  }

  final ScrollController _controller = ScrollController();

  //GlobalKey是一个方法可以创建一个key绑定到Widget部件上 可以操作Widget部件
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();

  double _paddingTop = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      //绑定key
      // 刷新时调用的方法
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          controller: _controller, //绑定控制器
          slivers: _getScrollContent(),
        ),
      ),
    );
  }
}
