import 'package:flutter/material.dart';
import 'package:lbluebook_logistics/core/lb_state.dart';
import 'package:lbluebook_logistics/util/color.dart';

import '../http/core/lb_error.dart';
import '../util/toast.dart';

/// 通用底层带分页和刷新的页面框架
/// M：Dao 层返回数据模型
/// L：列表数据模型
/// T：具体的 widget
abstract class LbBaseTabState<M, L, T extends StatefulWidget> extends LbState<T>
    with AutomaticKeepAliveClientMixin {
  List<L> dataList = [];
  int pageIndex = 1;
  bool loadding = false;
  ScrollController _scrollController = ScrollController();
  get contentChild;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      var dis = _scrollController.position.maxScrollExtent -
          _scrollController.position.pixels;
      // 距离底部不足300时加载更多
      if (dis < 300 && !loadding) {
        loadData(loadMore: true);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
        onRefresh: loadData,
        color: ColorPrimary,
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: contentChild,
        ));
  }

  // 获取对应页码的数据
  Future<M> getData(int pageIndex);

  // 从 Mo 中解析出 list 数据
  List<L> parseList(M result);

  Future<void> loadData({loadMore = false}) async {
    if (loadding) {
      print('上次加载还未完成');
      return;
    }
    loadding = true;
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    print('当前页码:$currentIndex');
    try {
      var result = await getData(currentIndex);
      setState(() {
        if (loadMore) {
          dataList = [...dataList, ...parseList(result)];
          if (parseList(result).length != 0) {
            pageIndex++;
          }
        } else {
          dataList = parseList(result);
        }
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on LbNetError catch (e) {
      print('e$e');
      showWarnToast(e.message);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
