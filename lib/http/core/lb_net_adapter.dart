import 'package:lbluebook_logistics/http/request/base_request.dart';
import 'dart:convert';

// 统一网络层返回格式
class LbNetResponse<T> {
  T? data;
  BaseRequest? request;
  int? statusCode;
  String? statusMessage;
  dynamic? extra;

  LbNetResponse(
      {this.data,
      this.request,
      this.statusCode,
      this.statusMessage,
      this.extra});

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}

// 网络请求抽象类
abstract class LbNetAdapter {
  Future<LbNetResponse> send<T>(BaseRequest request);
}
