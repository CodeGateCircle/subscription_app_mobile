import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_app_web/modules/subscriptions/subscription.entity.dart';

class SubscriptionsNotifier extends StateNotifier<List<Subscription>> {
  SubscriptionsNotifier() : super([]);

  void add(Subscription subscription) {
    state = [...state, subscription];
  }

  void delete(int subscriptionId) {
    state = state
        .where((subscription) => subscription.id != subscriptionId)
        .toList();
  }

  void replace(Subscription updatedSubscription) {
    state = [
      for (final subscription in state)
        if (subscription.id == updatedSubscription.id)
          updatedSubscription
        else
          subscription,
    ];
  }

  int getIndex(int id) {
    final index = state.indexWhere((subscription) => subscription.id == id);
    return index;
  }
}

final subscriptionsProvider =
    StateNotifierProvider<SubscriptionsNotifier, List<Subscription>>((ref) {
  return SubscriptionsNotifier();
});
