import 'package:lbluebook_logistics/db/lb_cache.dart';
import 'package:lbluebook_logistics/http/core/lb_net.dart';
import 'package:lbluebook_logistics/http/request/login_request.dart';

class LoginDao {
  static login(String username, String password) {
    return _send(username, password);
  }

  static _send(String username, String password) async {
    LoginRequest request = LoginRequest();
    request
        .addBody('username', username)
        .addBody('password', password)
        .addBody('clientSecret', '1q2w3e*')
        .addBody('grantType', 'password_blue')
        .addBody('clientId', 'Logistics_App');
    var result = await LbNet.getInstance().fire(request);

    if (result['error'] == null &&
        result['tokenType'] != null &&
        result['accessToken'] != null) {
      LbCache.getInstance().setString('token_type', result['tokenType']);
      LbCache.getInstance().setString('accessToken', result['accessToken']);
    }
    return result;
  }

  static getTokenType() {
    return LbCache.getInstance().get('token_type');
  }

  static getToken() {
    return LbCache.getInstance().get('accessToken');
  }
}
