import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lbluebook_logistics/core/lb_base_tab_state.dart';
import 'package:lbluebook_logistics/widget/lb_banner.dart';
import 'package:lbluebook_logistics/widget/video_card.dart';

import '../http/core/lb_error.dart';
import '../http/dao/home_dao.dart';
import '../model/banner_model.dart';
import '../model/home_model.dart';
import '../model/video_model.dart';
import '../util/toast.dart';

class HomeTabPage extends StatefulWidget {
  final String categoryName;
  final List<BannerMo>? bannerList;
  const HomeTabPage({Key? key, required this.categoryName, this.bannerList})
      : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState
    extends LbBaseTabState<HomeMo, VideoModel, HomeTabPage> {
  @override
  void initState() {
    super.initState();
    print(widget.categoryName);
    print(widget.bannerList);
  }

  _banner() {
    return LbBanner(widget.bannerList!);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  get contentChild => StaggeredGridView.countBuilder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        crossAxisCount: 2,
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          // banner 独占第一列
          if (widget.bannerList != null && index == 0) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: _banner(),
            );
          } else {
            return VideoCard(videoModel: dataList[index]);
          }
        },
        staggeredTileBuilder: (int index) {
          if (widget.bannerList != null && index == 0) {
            return StaggeredTile.fit(2);
          } else {
            return StaggeredTile.fit(1);
          }
        },
      );

  @override
  Future<HomeMo> getData(int pageIndex) async {
    HomeMo result = await HomeDao.get(widget.categoryName,
        pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoModel> parseList(HomeMo result) {
    // return result.items;
    // 弄个假数据
    List<VideoModel> mockList = [
      VideoModel('戴着口罩的妹子，一半沐浴在阳光下，一般躲藏在阴影中，真美',
          'https://i2.hdslb.com/bfs/archive/cb4b7dcb54460e29d53c45d6584532eb50255e53.jpg'),
      VideoModel('黄衣服',
          'https://i1.hdslb.com/bfs/archive/ddcb6dad24d2414ec3e205caf01f8d830b938521.jpg'),
      VideoModel('扇子',
          'https://i0.hdslb.com/bfs/archive/c168bb7ea7f9bf271a4bdf86625dc84290c9b9f3.jpg'),
      VideoModel('架子鼓',
          'https://i0.hdslb.com/bfs/archive/7b19439483ceb9dfd364a4dc8caf9c5f1be43d1e.jpg'),
      VideoModel('棒棒糖',
          'https://i0.hdslb.com/bfs/live/new_room_cover/c7d269de2da98819610d2482270bb57bb16354bc.jpg'),
      VideoModel('白帽子',
          'https://i0.hdslb.com/bfs/live/user_cover/5a286383e65df5d1be22421e169674724cc2003d.jpg'),
    ];
    return mockList;
  }
}
