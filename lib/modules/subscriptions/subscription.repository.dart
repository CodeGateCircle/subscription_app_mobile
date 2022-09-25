import 'package:subscription_app_web/lib/api.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';

class SubscriptionRepository {
  static Future<Response> findAll() async {
    final res = await api().get("/subscriptions");
    return Response.fromJson(res.data);
  }

  static Future<Response> create(Subscription subscription) async {
    final res = await api().post("/subscriptions", data: subscription);
    return Response.fromJson(res.data);
  }

  static Future<void> delete(int id) async {
    await api().delete("/subscriptions/${id.toString()}");
  }
}
