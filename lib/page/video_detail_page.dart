import 'package:flutter/material.dart';
import 'package:lbluebook_logistics/model/video_model.dart';
import 'package:lbluebook_logistics/widget/appBar.dart';
import 'package:lbluebook_logistics/widget/lb_tab.dart';
import 'package:lbluebook_logistics/widget/video_header.dart';
import 'package:lbluebook_logistics/widget/video_tool_bar.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetailPage(this.videoModel, {super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  late TabController _controller;
  List tabs = ['简介', '评论'];
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('详情'),
        body: Column(
          children: [
            _buildTabNavigation(),
            Flexible(
              child: TabBarView(
                controller: _controller,
                children: [_buildDetailList(), const Text('敬请期待')],
              ),
            ),
          ],
        ));
  }

  _buildTabNavigation() {
    return Material(
      elevation: 5,
      shadowColor: Colors.grey[100],
      child: Container(
        padding: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        height: 40,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabBar(),
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.live_tv_rounded,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return LbTab(
      tabs.map<Tab>((name) {
        return Tab(
          text: name,
        );
      }).toList(),
      controller: _controller,
    );
  }

  _buildDetailList() {
    return ListView(
      children: [...buildContents()],
    );
  }

  buildContents() {
    return [
      VideoHeader(widget.videoModel),
      VideoToolBar(
        likeNumber: 55010,
        isLike: true,
        coin: 1001,
        onLike: _doLike,
        onUnLike: _onUnLike,
        onFavority: _onFavority,
      ),
    ];
  }

  void _doLike() {}

  void _onUnLike() {}

  void _onFavority() {}
}
