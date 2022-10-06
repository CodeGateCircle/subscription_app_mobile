import 'package:subscription_app_web/lib/api.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';

class SubscriptionRepository {
  static Future<FindAllResponseData> findAll() async {
    final res = await api().get("/subscriptions");
    return FindAllResponseData.fromJson(res.data);
  }

  static Future<CreateResponseData> create(RequestData subscription) async {
    final res = await api().post("/subscriptions", data: subscription);
    return CreateResponseData.fromJson(res.data);
  }

  static Future<UpdateResponseData> update(
      RequestData subscription, int id) async {
    final res =
        await api().put("/subscriptions/${id.toString()}", data: subscription);
    return UpdateResponseData.fromJson(res.data);
  }

  static Future<void> delete(int id) async {
    await api().delete("/subscriptions/${id.toString()}");
  }
}
