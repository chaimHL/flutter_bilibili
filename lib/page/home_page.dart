import 'package:flutter/material.dart';
import 'package:lbluebook_logistics/navigator/lb_navigator.dart';
import 'package:lbluebook_logistics/page/home_tab_page.dart';
import 'package:underline_indicator/underline_indicator.dart';

import '../model/video_model.dart';
import '../util/color.dart';
import '../util/font.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;
  late TabController _controller;
  var tabs = ['推荐', '热门', '追播', '影视', '搞笑', '日常'];
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    LbNavigator.getInstance().addListener(listener = (current, pre) {
      print('首页监听:current:${current.page}');
      print('首页监听:pre:${pre.page}');
      if (widget == current.page || current.page is HomePage) {
        print('首页: onResume 展现');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('首页: onPause 隐藏');
      }
    });
  }

  @override
  void dispose() {
    LbNavigator.getInstance().removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 30),
            child: _tabBar(),
          ),
          Flexible(
            child: TabBarView(
                controller: _controller,
                children: tabs.map((tab) {
                  return HomeTabPage(name: tab);
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
        tabs: tabs.map<Tab>((tab) {
          return Tab(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Text(
                tab,
                style: const TextStyle(fontSize: FontSizeDefalut),
              ),
            ),
          );
        }).toList());
  }
}
