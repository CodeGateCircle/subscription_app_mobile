import 'package:subscription_app_web/lib/api.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';

class SubscriptionRepository {
  static Future<FindAllResponseData> findAll(String userId) async {
    final queryParams = {
      "userId": userId,
    };
    final res = await api().get("/subscriptions", queryParameters: queryParams);
    return FindAllResponseData.fromJson(res.data);
  }

  static Future<CreateResponseData> create(RequestData subscription) async {
    final res = await api().post("/subscriptions", data: subscription);
    return CreateResponseData.fromJson(res.data);
  }

  static Future<UpdateResponseData> update(
    RequestData subscription,
    int id,
  ) async {
    final res =
        await api().post("/subscriptions/${id.toString()}", data: subscription);
    return UpdateResponseData.fromJson(res.data);
  }

  static Future<UpdateResponseData> pause(
    Subscription subscription,
    bool isPaused,
    String userId,
  ) async {
    final postData = RequestData(
      userId: userId,
      subscription: RequestSubscription(
        name: subscription.name,
        price: subscription.price,
        paymentCycle: subscription.paymentCycle,
        firstPaymentDate: subscription.firstPaymentDate,
        paymentMethod: subscription.paymentMethod,
        isPaused: !isPaused,
        image: subscription.imageUrl,
        remarks: subscription.remarks,
      ),
    );

    final res = await api().post(
      "/subscriptions/${subscription.id.toString()}",
      data: postData,
    );
    return UpdateResponseData.fromJson(res.data);
  }

  static Future<void> delete(int id) async {
    await api().delete("/subscriptions/${id.toString()}");
  }
}
