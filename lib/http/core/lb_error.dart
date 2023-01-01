// 网络异常统一格式类
class LbNetError implements Exception {
  final int code; // 异常码
  final String message;
  final dynamic data;

  LbNetError(this.code, this.message, {this.data});
}

// 需要授权的异常
class NeedAuth extends LbNetError {
  NeedAuth(String message, {int code: 403, dynamic data})
      : super(code, message, data: data);
}

// 需要登录的异常
class NeedLogin extends LbNetError {
  NeedLogin({int code: 401, String message: '请登录'}) : super(code, message);
}
