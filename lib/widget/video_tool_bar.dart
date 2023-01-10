import 'package:flutter/material.dart';
import 'package:lbluebook_logistics/util/color.dart';
import 'package:lbluebook_logistics/util/format_util.dart';
import 'package:lbluebook_logistics/util/view_util.dart';

// 视频点赞分享收藏等工具栏
class VideoToolBar extends StatelessWidget {
  final int likeNumber;
  final bool isLike;
  final int coin;
  final VoidCallback? onLike;
  final VoidCallback? onUnLike;
  final VoidCallback? onCoin;
  final VoidCallback? onFavority;
  final VoidCallback? onShare;

  const VideoToolBar(
      {Key? key,
      required this.likeNumber,
      required this.isLike,
      required this.coin,
      this.onLike,
      this.onUnLike,
      this.onCoin,
      this.onFavority,
      this.onShare})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(border: borderLine()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText(
            Icons.thumb_up_alt_outlined,
            likeNumber,
            onClick: onLike,
            tint: isLike,
          ),
          _buildIconText(
            Icons.thumb_down_alt_outlined,
            '不喜欢',
            onClick: onUnLike,
          ),
          _buildIconText(
            Icons.monetization_on,
            coin,
            onClick: onCoin,
          ),
          _buildIconText(
            Icons.grade_rounded,
            600,
            onClick: onShare,
          ),
          _buildIconText(
            Icons.share_rounded,
            600,
            onClick: onCoin,
          )
        ],
      ),
    );
  }

  // tint 代表是否着色
  _buildIconText(IconData iconData, text, {onClick, bool tint = false}) {
    text ??= '';
    if (text is int) {
      text = countFormat(text);
    }
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Icon(
            iconData,
            color: tint ? ColorPrimary : Colors.grey,
            size: 20,
          ),
          LbSpace(height: 5),
          Text(
            text,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          )
        ],
      ),
    );
  }
}
