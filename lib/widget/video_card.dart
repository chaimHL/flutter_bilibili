import 'package:flutter/material.dart';
import 'package:lbluebook_logistics/model/video_model.dart';
import 'package:lbluebook_logistics/navigator/lb_navigator.dart';
import 'package:lbluebook_logistics/util/format_util.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoCard extends StatelessWidget {
  final VideoModel videoModel;
  const VideoCard({Key? key, required this.videoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        LbNavigator.getInstance()
            .onJumpTo(RouteStatus.detail, args: {'videoMo': videoModel});
      },
      child: SizedBox(
        height: 200,
        child: Card(
          // 改变默认 margin
          margin: EdgeInsets.only(left: 4, right: 4, bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Column(
              children: [_itemImage(context), _infoText()],
            ),
          ),
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: videoModel.cover,
          height: 120,
          width: size.width / 2,
          fit: BoxFit.cover,
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black54, Colors.transparent],
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconText(Icons.ondemand_video, 10000),
                  _iconText(Icons.favorite_border, 520),
                  _iconText(null, 81)
                ],
              ),
            ))
      ],
    );
  }

  _iconText(IconData? iconData, int count) {
    String views = '';
    if (iconData != null) {
      views = countFormat(count);
    } else {
      views = durationTransform(count);
    }
    return Row(
      children: [
        if (iconData != null)
          Icon(
            iconData,
            color: Colors.white,
            size: 12,
          ),
        Padding(
          padding: EdgeInsets.only(left: 3),
          child: Text(
            views,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        )
      ],
    );
  }

  _infoText() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start, // 文字左对齐
          children: [
            Text(
              videoModel.vid,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
            _owner()
          ],
        ),
      ),
    );
  }

  _owner() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                videoModel.cover,
                width: 24,
                height: 24,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                '统一',
                style: TextStyle(fontSize: 11, color: Colors.black87),
              ),
            ),
          ],
        ),
        Icon(
          Icons.more_vert_sharp,
          size: 15,
          color: Colors.grey,
        )
      ],
    );
  }
}
