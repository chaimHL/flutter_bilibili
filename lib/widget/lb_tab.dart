import 'package:flutter/material.dart';
import 'package:underline_indicator/underline_indicator.dart';

import '../util/color.dart';

// 顶部 tab
class LbTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController controller;
  final double fontSize;
  final double borderWidth;
  final double insets;
  final Color unselectedLabelColor;
  const LbTab(
    this.tabs, {
    Key? key,
    required this.controller,
    this.fontSize = 16,
    this.borderWidth = 3,
    this.insets = 13, // 指示线的左右边距，数值越大线越短
    this.unselectedLabelColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: controller,
        isScrollable: true,
        labelColor: ColorPrimary,
        unselectedLabelColor: unselectedLabelColor,
        labelStyle: TextStyle(fontSize: fontSize),
        indicator: UnderlineIndicator(
            strokeCap: StrokeCap.round,
            borderSide: BorderSide(color: ColorPrimary, width: borderWidth),
            insets: EdgeInsets.only(left: insets, right: insets)),
        tabs: tabs);
  }
}
