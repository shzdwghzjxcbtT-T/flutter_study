class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  //扩展一个工厂函数 一般用factory来声明 一般用来创建实例对象
  factory BannerItem.fromJSON(Map<String, dynamic> json) {
    //必须返回一个BannerItem对象
    return BannerItem(
      //如果id为空 则默认值为空字符串
      id: json['id'] ?? '',
      //如果imgUrl为空 则默认值为空字符串
      imgUrl: json['imgUrl'] ?? '',
    );
  }
}
