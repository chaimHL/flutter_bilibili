import 'package:flutter/material.dart';
import 'package:lbluebook_logistics/core/lb_state.dart';
import 'package:lbluebook_logistics/http/core/lb_error.dart';
import 'package:lbluebook_logistics/http/dao/home_dao.dart';
import 'package:lbluebook_logistics/navigator/lb_navigator.dart';
import 'package:lbluebook_logistics/page/home_tab_page.dart';
import 'package:lbluebook_logistics/util/toast.dart';
import 'package:underline_indicator/underline_indicator.dart';

import '../model/banner_model.dart';
import '../model/home_model.dart';
import '../util/color.dart';
import '../util/font.dart';
import '../widget/navigation_bar.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJumpTo;
  const HomePage({super.key, this.onJumpTo});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends LbState<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;
  late TabController _controller;
  List<HomeTabsMo?> tabsList = [];
  List<BannerMo> bannerList = [];
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabsList.length, vsync: this);
    LbNavigator.getInstance().addListener(listener = (current, pre) {
      if (widget == current.page || current.page is HomePage) {
        print('首页: onResume 展现');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('首页: onPause 隐藏');
      }
    });
    loadData();
  }

  @override
  void dispose() {
    LbNavigator.getInstance().removeListener(listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          LbNavigationBar(
            color: Colors.white,
            statusStyle: StatusStyle.DARK_CONTENT,
            child: _appBar(),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: _tabBar(),
            ),
          ),
          Flexible(
            child: TabBarView(
                controller: _controller,
                children: tabsList.map((tab) {
                  return HomeTabPage(
                    categoryName: tab?.displayName ?? '-',
                    bannerList: tab?.displayName == '公司动态' ? bannerList : null,
                  );
                }).toList()),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return TabBar(
        controller: _controller,
        isScrollable: true,
        labelColor: Colors.black,
        indicator: const UnderlineIndicator(
            strokeCap: StrokeCap.round,
            borderSide: BorderSide(color: ColorPrimary, width: 3),
            insets: EdgeInsets.only(left: 16, right: 16)),
        tabs: tabsList.map<Tab>((tab) {
          return Tab(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                tab?.displayName ?? '-',
                style: const TextStyle(fontSize: FontSizeDefalut),
              ),
            ),
          );
        }).toList());
  }

  void loadData() async {
    try {
      HomeMo result = await HomeDao.get('3a058056-5433-5bc5-be33-31bb403f792e');
      if (result.items != null) {
        // tab 长度变化后需要重新创建 TabController
        _controller = TabController(length: result.items!.length, vsync: this);
      }
      setState(() {
        tabsList = result.items ?? [];
        bannerList = [
          BannerMo('banner1', 'video',
              'https://imgcps.jd.com/img-cubic/creative_server_cia_jdcloud/v2/2000367/100030411817/FocusFullshop/CkNqZnMvdDEvMTQwNTgzLzE2LzMyMDUyLzU2Mzk1LzYzYjA4YWRhRmNlY2VkYzU3L2NiYmMxOGFiZGIwMmI0NmYucG5nEgkyLXR5XzBfNTMwAjjvi3pCGAoS5Lqs6Ie05LyY54mp5p2l6KKtEAEYAUIQCgznlYXkuqvkvJjlk4EQAkIQCgznq4vljbPmiqLotK0QBkIKCgbnp43ojYkQB1ip6JvS9AI/cr/s/q.jpg'),
          BannerMo('banner2', 'video',
              'https://img12.360buyimg.com/pop/s1180x940_jfs/t1/102791/25/34343/38728/63b4ed5dFd8faf95e/09150c42d8b545cc.jpg'),
          BannerMo('banner3', 'video',
              'https://img30.360buyimg.com/babel/s1180x940_jfs/t1/60355/18/23395/121919/63ae9ecdF8308a54a/a3731f453c0fa164.png')
        ];
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on LbNetError catch (e) {
      print('e$e');
      showWarnToast(e.message);
    }
  }

  _appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.onJumpTo != null) {
                widget.onJumpTo!(3); // 跳转到 “我的” tab
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: const Image(
                height: 46,
                width: 46,
                image: AssetImage('images/avatar.png'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 32,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  child: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          const Icon(
            Icons.explore_outlined,
            color: Colors.grey,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(
              Icons.mail_outline,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
