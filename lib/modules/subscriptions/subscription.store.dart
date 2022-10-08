import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';

class SubscriptionsNotifier extends StateNotifier<List<Subscription>> {
  SubscriptionsNotifier() : super([]);

  void addSubscription(Subscription subscription) {
    state = [...state, subscription];
  }

  void updateSubscription(Subscription updatedSubscription) {
    state = [
      for (final subscription in state)
        if (subscription.id == updatedSubscription.id)
          updatedSubscription
        else
          subscription,
    ];
  }
}

final subscriptionsProvider =
    StateNotifierProvider<SubscriptionsNotifier, List<Subscription>>((ref) {
  return SubscriptionsNotifier();
});
