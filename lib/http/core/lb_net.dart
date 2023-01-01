import 'dio_adapter.dart';
import 'package:lbluebook_logistics/http/request/base_request.dart';
import 'lb_net_adapter.dart';
import 'lb_error.dart';

class LbNet {
  LbNet._();
  static LbNet? _instance;
  static LbNet getInstance() => _instance ?? LbNet._();

  Future fire(BaseRequest request) async {
    LbNetResponse? response;
    var error;

    try {
      response = await send(request);
    } on LbNetError catch (e) {
      error = e;
      response = e.data;
      printLog('222$e');
    } catch (e) {
      error = e;
      printLog('333$e');
    }

    if (response == null) {
      printLog(error);
    }
    var result = response?.data;

    var status = response?.statusCode;

    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        var errMsg = '请求出错';
        if (result.containsKey('error')) {
          errMsg = result['error']['message'] ?? '请求出错';
        }
        throw NeedAuth(errMsg, data: result);
      default:
        throw LbNetError(status!, result.toString(), data: result);
    }
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    LbNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  // 给打印添加统一前缀，方便查看和筛选
  void printLog(log) {
    print('hi_net:${log.toString()}');
  }
}
