import 'package:flutter/material.dart';

// 页面状态异常管理
abstract class LbState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      // 如果页面被装载
      super.setState(fn);
    } else {
      print('页面已销毁，setState 不执行');
    }
  }
}
