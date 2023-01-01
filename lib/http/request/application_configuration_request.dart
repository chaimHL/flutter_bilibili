import 'base_request.dart';

class ApplicationConfigurationRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return '/api/system/application-configuration';
  }
}
