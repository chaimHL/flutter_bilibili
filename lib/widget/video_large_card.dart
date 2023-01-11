import 'package:flutter/material.dart';
import 'package:lbluebook_logistics/model/video_model.dart';
import 'package:lbluebook_logistics/navigator/lb_navigator.dart';
import 'package:lbluebook_logistics/util/format_util.dart';
import 'package:lbluebook_logistics/util/view_util.dart';

// 视频列表卡片
class VideoLargeCard extends StatelessWidget {
  final VideoModel videoModel;
  const VideoLargeCard({Key? key, required this.videoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        LbNavigator.getInstance()
            .onJumpTo(RouteStatus.detail, args: {'videoMo': videoModel});
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 5),
        padding: EdgeInsets.only(bottom: 6),
        height: 106,
        decoration: BoxDecoration(border: borderLine()),
        child: Row(
          children: [_itemImage(), _buildContent()],
        ),
      ),
    );
  }

  _itemImage() {
    double height = 90;
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Stack(
        children: [
          cachedImage(videoModel.cover,
              width: height * (16 / 9), height: height),
          Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  durationTransform(100),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ))
        ],
      ),
    );
  }

  _buildContent() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(
          left: 8,
          top: 5,
          bottom: 5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              videoModel.vid,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
            _buildBottomContent()
          ],
        ),
      ),
    );
  }

  _buildBottomContent() {
    return Column(
      children: [
        _owner(),
        LbSpace(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ...smallIconText(Icons.ondemand_video, 242020),
                LbSpace(width: 5),
                ...smallIconText(Icons.list_alt, 1000)
              ],
            ),
            const Icon(
              Icons.more_vert_sharp,
              color: Colors.grey,
              size: 15,
            )
          ],
        )
      ],
    );
  }

  _owner() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: Colors.grey),
          ),
          child: const Text(
            'Up',
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        LbSpace(width: 8),
        const Text(
          '作者',
          style: TextStyle(fontSize: 11, color: Colors.grey),
        )
      ],
    );
  }
}
