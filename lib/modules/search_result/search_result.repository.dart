import 'package:subscription_app_web/lib/api.dart';
import 'package:subscription_app_web/modules/search_result/search_result.entity.dart';

class SearchResultRepository {
  static Future<ResponseData> get(String name) async {
    final res = await api().get("/search?name=$name");
    return ResponseData.fromJson(res.data);
  }
}
