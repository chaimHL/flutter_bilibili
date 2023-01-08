import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
