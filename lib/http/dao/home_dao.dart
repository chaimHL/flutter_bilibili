import 'package:lbluebook_logistics/http/core/lb_net.dart';
import 'package:lbluebook_logistics/http/request/home_request.dart';
import 'package:lbluebook_logistics/model/home_model.dart';

class HomeDao {
  static get(String id, {int sorting = 0, int maxResultCount = 7}) async {
    HomeRequest request = HomeRequest();
    // request.pathParams = id; // path 参数，其实本接口不需要
    request
        .addBody('sorting', sorting)
        .addBody('maxResultCount', maxResultCount);
    var result = await LbNet.getInstance().fire(request);
    print(result);
    return HomeMo.fromJson(result);
  }
}
