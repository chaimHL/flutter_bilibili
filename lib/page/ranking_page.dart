// 排行榜
import 'package:flutter/material.dart';
import 'package:lbluebook_logistics/widget/lb_navigation_bar.dart';
import 'package:lbluebook_logistics/widget/lb_tab.dart';

import '../util/view_util.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with TickerProviderStateMixin {
  static const TABS = [
    {'key': 'like', 'name': '最热'},
    {'key': 'update', 'name': '最新'},
    {'key': 'favorite', 'name': '收藏'}
  ];
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: TABS.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [_buildNavigationBar(), _buildTabView()],
      ),
    );
  }

  _buildNavigationBar() {
    return LbNavigationBar(
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        decoration: bottomBoxShadow(),
        child: _tabBar(),
      ),
    );
  }

  _tabBar() {
    return LbTab(
        TABS.map<Tab>((tab) {
          return Tab(
            text: tab['name'],
          );
        }).toList(),
        fontSize: 16,
        borderWidth: 3,
        unselectedLabelColor: Colors.black54,
        controller: _controller);
  }

  _buildTabView() {
    return Flexible(
        child: TabBarView(
            controller: _controller,
            children: TABS.map((tab) {
              return Container(
                child: Text(tab['name']!),
              );
            }).toList()));
  }
}
