import 'package:flutter/material.dart';
import 'package:lbluebook_logistics/page/home_page.dart';
import 'package:lbluebook_logistics/page/language_page.dart';
import 'package:lbluebook_logistics/page/video_detail_page.dart';
import '../page/login_page.dart';

typedef RouteChangeListener = Function(
    RouteStatusInfo current, RouteStatusInfo pre);
// 创建页面
pageWrap(Widget child) {
  return MaterialPage(child: child, key: ValueKey(child.hashCode));
}

// 获取 routeStatus 在页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

// 自定义路由封装，路由状态
enum RouteStatus { login, language, home, detail, unknown }

// 获取 page 对应的 RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is LanguagePage) {
    return RouteStatus.language;
  } else if (page.child is HomePage) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  } else {
    return RouteStatus.unknown;
  }
}

// 路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

// 监听路由页面跳转
// 感知当前页面是否压后台
class LbNavigator extends _RouteJumpListener {
  static LbNavigator? _instance;
  RouteJumpListener? _routeJump;
  final List<RouteChangeListener> _listeners = [];
  RouteStatusInfo? _current;
  LbNavigator._();
  static LbNavigator getInstance() {
    _instance ??= LbNavigator._();
    return _instance!;
  }

  // 组测路由的跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    _routeJump = routeJumpListener;
  }

  // 监听路由页面跳转
  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  // 移除监听
  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    if (_routeJump != null && _routeJump?.onJumpTo != null) {
      _routeJump!.onJumpTo!(routeStatus, args: args);
    }
  }

  // 通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var current =
        RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    print('navigtor:current:${current.page}');
    print('navigtor:pre:${_current?.page}');
    _listeners.forEach((listener) {
      listener(current, _current!);
    });
    _current = current;
  }
}

// 抽象类供 LbNavigator 实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map? args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

// 定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  final OnJumpTo? onJumpTo;

  RouteJumpListener({this.onJumpTo});
}
