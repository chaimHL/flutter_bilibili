import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lbluebook_logistics/util/format_util.dart';

// 带本地缓存的 image
Widget cachedImage(String url,
    {required double width, required double height}) {
  return CachedNetworkImage(
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (
        BuildContext context,
        String url,
      ) =>
          Container(
            color: Colors.grey,
          ),
      errorWidget: (
        BuildContext context,
        String url,
        dynamic error,
      ) =>
          const Icon(Icons.error),
      imageUrl: url);
}

// 黑色线性渐变
blackLinearGradient({bool fromTop = false}) {
  return LinearGradient(
      begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
      end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
      colors: const [
        Colors.black54,
        Colors.black45,
        Colors.black38,
        Colors.black26,
        Colors.black12,
        Colors.transparent
      ]);
}

// border
borderLine({bottom = true, top = false}) {
  BorderSide borderSide = const BorderSide(width: 0.5, color: Colors.black12);
  return Border(
    bottom: bottom ? borderSide : BorderSide.none,
    top: top ? borderSide : BorderSide.none,
  );
}

// 间距
SizedBox LbSpace({double height = 1, double width = 1}) {
  return SizedBox(height: height, width: width);
}

// 带文字的小图标
smallIconText(IconData iconData, var text) {
  var style = TextStyle(fontSize: 12, color: Colors.grey);
  if (text is int) {
    text = countFormat(text);
  }
  return [
    Icon(
      iconData,
      color: Colors.grey,
      size: 12,
    ),
    Text(
      ' $text',
      style: style,
    )
  ];
}

// 底部阴影
BoxDecoration bottomBoxShadow() {
  return BoxDecoration(color: Colors.white, boxShadow: [
    BoxShadow(
      color: Colors.grey[100]!,
      offset: const Offset(0, 5), // xy轴偏移
      blurRadius: 5.0, // 阴影模糊程度
      spreadRadius: 1, // 阴影扩散程度
    )
  ]);
}
