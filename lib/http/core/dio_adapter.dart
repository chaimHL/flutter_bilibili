// Dio 适配器
import 'package:dio/dio.dart';
import 'lb_error.dart';
import 'lb_net_adapter.dart';
import 'package:lbluebook_logistics/http/request/base_request.dart';

class DioAdapter extends LbNetAdapter {
  @override
  Future<LbNetResponse> send<T>(BaseRequest request) async {
    var response, options = Options(headers: request.header);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        print('get: ${request.url()}');
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio().post(request.url(),
            data: request.queryParameters, options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio().delete(request.url(), options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }

    if (error != null) {
      print('error: ${error.response.data['error']['message']}');
      throw LbNetError(response.statusCode ?? -1, '1111',
          // error.response.data['error']['message'].toString(),
          data: buildRes(response, request));
    }

    return buildRes(response, request);
  }

  LbNetResponse buildRes(Response response, BaseRequest request) {
    return LbNetResponse(
        data: response.data,
        request: request,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        extra: response);
  }
}
