import 'package:lbluebook_logistics/http/dao/login_dao.dart';

enum HttpMethod { GET, POST, DELETE }

// 基础请求
abstract class BaseRequest {
  var pathParams;
  var useHttps = false;
  String authority() {
    return 'dexi-api.devlogistics.lbluebook.cn';
  }

  HttpMethod httpMethod();

  // 请求路径
  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    // 拼接 path 和 params
    if (pathParams != null) {
      if (path().endsWith('/')) {
        pathStr = '${path()}$pathParams';
      } else {
        pathStr = '${path()}/$pathParams';
      }
    }
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, queryParameters);
    } else {
      uri = Uri.http(authority(), pathStr, queryParameters);
    }
    if (needLogin()) {
      addHeader('authorization', LoginDao.getTokenType() + LoginDao.getToken());
    }
    return uri.toString();
  }

  // 是否需要登录
  bool needLogin();

  // query 参数
  Map<String, String> queryParameters = Map();
  BaseRequest add(String k, Object v) {
    queryParameters[k] = v.toString();
    return this;
  }

  // headers
  Map<String, dynamic> header = Map();
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
