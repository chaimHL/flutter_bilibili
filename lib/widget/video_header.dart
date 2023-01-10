import 'package:flutter/material.dart';
import 'package:lbluebook_logistics/util/color.dart';
import 'package:lbluebook_logistics/util/format_util.dart';

import '../model/video_model.dart';

// 详情页 头部作者信息
class VideoHeader extends StatelessWidget {
  final VideoModel videoModel;
  const VideoHeader(this.videoModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  videoModel.cover,
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    const Text(
                      '哈哈哈',
                      style: TextStyle(
                        fontSize: 13,
                        color: ColorPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${countFormat(12)}粉丝',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          MaterialButton(
            onPressed: () {
              print('关注');
            },
            color: ColorPrimary,
            height: 24,
            minWidth: 50,
            child: const Text(
              '关注',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          )
        ],
      ),
    );
  }
}
