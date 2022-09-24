import 'package:subscription_app_web/lib/api.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';

class SubscriptionRepository {
  static Future<FindAllResultData> findAll() async {
    final res = await api().get("/subscriptions");
    return FindAllResultData.fromJson(res.data);
  }

  static Future<void> delete(int id) async {
    await api().delete("/subscriptions/${id.toString()}");
  }
}