import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  HmSlider({Key? key, required this.bannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  Widget _getSlider() {
    //在flutter获取屏幕宽度
    final double screenWidth = MediaQuery.of(context).size.width;
    return CarouselSlider(
      items: List.generate(widget.bannerList.length, (int index) {
        return Image.network(
          widget.bannerList[index].imgUrl,
          fit: BoxFit.cover,
          width: 800,
        );
      }),
      options: CarouselOptions(
        autoPlayInterval: Duration(seconds: 5), // 自动播放间隔
        viewportFraction: 1, // 视口比例
        autoPlay: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider()]);
    // return Container(
    //   height: 300,
    //   color: Colors.blue,
    //   alignment: Alignment.center,
    //   child: Text("轮播图", style: TextStyle(fontSize: 20, color: Colors.white)),
    // );
  }
}
