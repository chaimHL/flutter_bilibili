import 'package:flutter/material.dart';
import 'package:lbluebook_logistics/navigator/lb_navigator.dart';

import '../model/video_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  var listener;
  @override
  void initState() {
    super.initState();
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
      appBar: AppBar(),
      body: Column(
        children: [
          const Text('首页'),
          MaterialButton(
            onPressed: () {
              LbNavigator.getInstance().onJumpTo(RouteStatus.detail,
                  args: {'videoMo': VideoModel(100)});
            },
            child: const Text('详情'),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
