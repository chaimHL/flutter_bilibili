// 顶部栏
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lbluebook_logistics/util/color.dart';

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class LbNavigationBar extends StatefulWidget {
  final StatusStyle? statusStyle;
  final Color? color;
  final double height;
  final Widget? child;

  const LbNavigationBar(
      {Key? key,
      this.statusStyle = StatusStyle.DARK_CONTENT,
      this.color = ColorPrimary,
      this.height = 50,
      this.child})
      : super(key: key);

  @override
  State<LbNavigationBar> createState() => _LbNavigationBarState();
}

class _LbNavigationBarState extends State<LbNavigationBar> {
  @override
  Widget build(BuildContext context) {
    _statusBarInit();
    //状态栏高度
    var top = MediaQuery.of(context).padding.top;
    print('top:$top');
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: widget.color),
      child: widget.child,
    );
  }

  void _statusBarInit() {
    //沉浸式状态栏
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: widget.statusStyle == StatusStyle.DARK_CONTENT
          ? Brightness.light
          : Brightness.dark,
      statusBarIconBrightness: widget.statusStyle == StatusStyle.DARK_CONTENT
          ? Brightness.dark
          : Brightness.light,
    ));
  }
}
