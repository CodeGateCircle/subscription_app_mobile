import 'package:subscription_app_web/lib/api.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';

class SubscriptionRepository {
  static Future<ResponseData> findAll() async {
    final res = await api().get("/subscriptions");
    return ResponseData.fromJson(res.data);
  }

  static Future<ResponseData> create(CreateRequestData subscription) async {
    final res = await api().post("/subscriptions", data: subscription);
    return ResponseData.fromJson(res.data);
  }

  static Future<void> delete(int id) async {
    await api().delete("/subscriptions/${id.toString()}");
  }
}
