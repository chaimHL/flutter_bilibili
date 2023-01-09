// 页面顶部导航
import 'package:flutter/material.dart';

appBar(String title, {Icon? rightIcon, VoidCallback? rightBtnClick}) {
  return AppBar(
    elevation: 1,
    centerTitle: true,
    titleSpacing: 0,
    leading: const BackButton(),
    title: Text(
      title,
      style: const TextStyle(fontSize: 18),
    ),
    actions: [
      InkWell(
          onTap: rightBtnClick,
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            alignment: Alignment.center,
            child: rightIcon,
          ))
    ],
  );
}
