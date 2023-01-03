import 'package:flutter/material.dart';
import 'package:lbluebook_logistics/http/dao/login_dao.dart';
import 'package:lbluebook_logistics/navigator/bottom_navigator.dart';
import 'package:lbluebook_logistics/navigator/lb_navigator.dart';
import 'package:lbluebook_logistics/page/home_page.dart';
import 'package:lbluebook_logistics/page/login_page.dart';
import 'package:lbluebook_logistics/page/video_detail_page.dart';
import 'package:lbluebook_logistics/page/language_page.dart';
import 'package:lbluebook_logistics/db/lb_cache.dart';
import 'package:lbluebook_logistics/util/toast.dart';
import 'model/video_model.dart';
import 'util/color.dart';

void main() {
  runApp(const LbApp());
}

class LbApp extends StatefulWidget {
  const LbApp({Key? key}) : super(key: key);

  @override
  State<LbApp> createState() => _LbAppState();
}

class _LbAppState extends State<LbApp> {
  final LbRouteDelegate _routeDelegate = LbRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LbCache>(
        future: LbCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<LbCache> snapshot) {
          // 定义 route
          var widget = snapshot.connectionState == ConnectionState.done
              ? Router(
                  routerDelegate: _routeDelegate,
                )
              : const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
          return MaterialApp(
            home: widget,
            theme: ThemeData(
              primarySwatch: white,
            ),
          );
        });
  }
}

// 路由导航部分
class LbRouteDelegate extends RouterDelegate<LbRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<LbRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  // 为 Navigator 设置一个 key，必要的时候可以通过 navigatorKey。currentState 来获取 NavigatorState 对象
  // 该对象里有很多方法，比如回到上一页等
  LbRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    // 实现路由跳转
    LbNavigator.getInstance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map? args}) {
      _routeStatus = routeStatus;
      if (routeStatus == RouteStatus.detail) {
        videoModel = args?['videoMo'];
      }
      notifyListeners();
    }));
  }
  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  VideoModel? videoModel;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      // 要打开的页面在栈中已存在，则将该页面和它上面的所有页面都出栈
      tempPages = tempPages.sublist(0, index);
    }
    late MaterialPage page;
    if (routeStatus == RouteStatus.home) {
      // 因为首页不可回退，所以将栈中其它页面全部出栈
      pages.clear();
      page = pageWrap(const BottomNavigator());
    } else if (routeStatus == RouteStatus.detail) {
      if (videoModel != null) {
        page = pageWrap(VideoDetailPage(videoModel!));
      }
    } else if (routeStatus == RouteStatus.language) {
      print(1);
      page = pageWrap(const LanguagePage());
      print(page == null);
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(const LoginPage());
    }

    // 重新创建一个数组，否则 pages 因引用没有改变 路由不会生效
    tempPages = [...tempPages, page];
    // 通知路由发生变化
    LbNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;
    return WillPopScope(
      // 修复安卓物理返回建无法返回上一页
      onWillPop: () async => !await navigatorKey.currentState!.maybePop(),
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        // 返回上一页的回调
        onPopPage: (route, result) {
          if (route.settings is MaterialPage) {
            // 登录页未登录返回拦截
            if ((route.settings as MaterialPage).child is LoginPage) {
              if (!hasLogin) {
                showWarnToast('请登录');
                return false;
              }
            }
          }
          // 执行返回操作
          if (!route.didPop(result)) {
            return false;
          }
          var tempPages = [...pages];
          pages.removeLast();
          // 通知路由发生变化
          LbNavigator.getInstance().notify(pages, tempPages);
          return true;
        },
      ),
    );
  }

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.language && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getToken() != null;

  @override
  Future<void> setNewRoutePath(LbRoutePath configuration) async {}
}

// 定义路由数据 path
class LbRoutePath {
  final String location;
  LbRoutePath.home() : location = '/';
  LbRoutePath.detail() : location = '/detail';
}
