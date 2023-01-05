import 'package:lbluebook_logistics/http/request/base_request.dart';

class HomeRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return '/api/content-management/category/list';
  }
}
