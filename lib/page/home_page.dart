import 'package:flutter/material.dart';
import 'package:lbluebook_logistics/core/lb_state.dart';
import 'package:lbluebook_logistics/http/core/lb_error.dart';
import 'package:lbluebook_logistics/http/dao/home_dao.dart';
import 'package:lbluebook_logistics/navigator/lb_navigator.dart';
import 'package:lbluebook_logistics/page/home_tab_page.dart';
import 'package:lbluebook_logistics/util/toast.dart';
import 'package:underline_indicator/underline_indicator.dart';

import '../model/home_model.dart';
import '../model/video_model.dart';
import '../util/color.dart';
import '../util/font.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends LbState<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;
  late TabController _controller;
  List<HomeTabsMo?> tabsList = [];
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabsList.length, vsync: this);
    LbNavigator.getInstance().addListener(listener = (current, pre) {
      print('首页监听:current:${current.page}');
      print('首页监听:pre:${pre.page}');
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
      body: Column(
        children: [
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
                  return HomeTabPage(name: tab?.displayName ?? '-');
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
      print('loadData: $result');
      if (result.items != null) {
        // tab 长度变化后需要重新创建 TabController
        _controller = TabController(length: result.items!.length, vsync: this);
      }
      setState(() {
        tabsList = result.items ?? [];
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on LbNetError catch (e) {
      print('e$e');
      showWarnToast(e.message);
    }
  }
}
