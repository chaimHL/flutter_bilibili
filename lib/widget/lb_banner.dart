import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:lbluebook_logistics/model/video_model.dart';
import 'package:lbluebook_logistics/navigator/lb_navigator.dart';

import '../model/banner_model.dart';

class LbBanner extends StatelessWidget {
  const LbBanner(this.bannerList,
      {Key? key, this.bannerHeight = 160, this.padding})
      : super(key: key);
  final List<BannerMo> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right = 10 + (padding?.horizontal ?? 0) / 2;
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return _image(bannerList[index]);
      },
      itemCount: bannerList.length,
      autoplay: true,
      pagination: const SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(color: Colors.white60, size: 8)),
    );
  }

  _image(BannerMo bannerMo) {
    return InkWell(
      onTap: () {
        print(bannerMo.title);
        _handleClick(bannerMo);
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          child: Image.network(
            bannerMo.cover,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  void _handleClick(BannerMo bannerMo) {
    if (bannerMo.type == 'video') {
      LbNavigator.getInstance().onJumpTo(RouteStatus.detail,
          args: {'videoMo': VideoModel(bannerMo.title, bannerMo.cover)});
    } else {
      // todo
    }
  }
}
