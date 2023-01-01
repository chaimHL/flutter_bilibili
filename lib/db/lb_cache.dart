// 缓存管理类
import 'package:shared_preferences/shared_preferences.dart';

class LbCache {
  SharedPreferences? prefs;
  LbCache._() {
    init();
  }
  static LbCache? _instance;
  LbCache._pre(SharedPreferences this.prefs);
  // 预初始化
  static Future<LbCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = LbCache._pre(prefs);
    }
    return _instance!;
  }

  static LbCache getInstance() {
    _instance ??= LbCache._();
    return _instance!;
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  setString(String key, String value) {
    prefs?.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  Object? get<T>(String key) {
    return prefs?.get(key);
  }
}
